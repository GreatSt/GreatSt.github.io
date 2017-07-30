module Transformer exposing (..)

import Animation exposing (px)
import Animation.Messenger
import Ease exposing (..)
import List
import Html exposing (..)
import Material.Grid exposing (Device(All), cell, grid)
import Material.Grid as Grid
import Material.Options exposing (css)
import Material.Options as Options
import Time exposing (..)


type alias Model =
    { style1 : Animation.State
    , style2 : Animation.Messenger.State Msg
    , isIn : Bool
    , newText : Bool
    }


initModel : Model
initModel =
    { style1 =
        Animation.style
            [ Animation.height <| Animation.px 100
            ]
    , style2 =
        Animation.style
            [ Animation.opacity 1.0
            ]
    , isIn = True
    , newText = False
    }


subscriptions : Model -> (Msg -> m) -> Sub m
subscriptions model msgFn =
    Sub.map msgFn <|
        Animation.subscription Animate [ model.style2 ]


type Msg
    = FancyAnim
    | SwitchText
    | Animate Animation.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    let
        smoothFn =
            Animation.easing
                { duration = 0.6 * Time.second
                , ease = Ease.outQuart
                }

        halfSmoothFn =
            Animation.easing
                { duration = 0.3 * Time.second
                , ease = Ease.outQuad
                }
    in
        case action of
            FancyAnim ->
                ( { model
                    | style1 =
                        Animation.interrupt
                            [ Animation.toWith smoothFn
                                [ Animation.height <|
                                    Animation.px <|
                                        if model.isIn then
                                            180
                                        else
                                            100
                                ]
                            ]
                            model.style1
                    , style2 =
                        Animation.interrupt
                            [ Animation.toWith halfSmoothFn
                                [ Animation.opacity <| 0.0
                                ]
                            , Animation.Messenger.send SwitchText
                            , Animation.toWith halfSmoothFn
                                [ Animation.opacity <| 1.0
                                ]
                            ]
                            model.style2
                    , isIn = not model.isIn
                  }
                , Cmd.none
                )

            SwitchText ->
                ( { model | newText = not model.newText }, Cmd.none )

            Animate animMsg ->
                let
                    newStyle1 =
                        Animation.update animMsg model.style1

                    ( newStyle2, cmd2 ) =
                        Animation.Messenger.update animMsg model.style2
                in
                    ( { model
                        | style1 = newStyle1
                        , style2 = newStyle2
                      }
                    , cmd2
                    )


view : Model -> (Msg -> m) -> Html m
view =
    boxView


boxView : Model -> (Msg -> m) -> Html m
boxView model msgFn =
    grid []
        [ cell
            ([ Grid.offset All 5
             , Grid.size All 2
             , css "text-sizing" "border-box"
             , css "overflow" "auto"
             , css "background-color" "#50FF50"
             , css "padding-left" "8px"
             , css "padding-top" "10px"
             , css "text-align" "center"
             , Options.onClick <| msgFn FancyAnim
             ]
                ++ List.map (Options.attribute)
                    (Animation.render model.style1)
            )
            [ p (Animation.render model.style2)
                [ text <|
                    if model.newText then
                        "Click to go back in"
                    else
                        "Click to go out"
                ]
            ]
        , cell
            [ Grid.offset All 5
            , Grid.size All 2
            , css "text-sizing" "border-box"
            , css "overflow" "auto"
            , css "background-color" "#FF5050"
            , css "padding-left" "8px"
            , css "height" "100px"
            , css "padding-top" "10px"
            , css "text-align" "center"
            ]
            [ text "No clicky" ]
        ]
