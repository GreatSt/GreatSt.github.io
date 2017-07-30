module Extra.BoxAnimation exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Animation exposing (px)
import Time exposing (..)
import Ease exposing (..)


type alias Model =
    { style : Animation.State, angle : Float }


initModel : Model
initModel =
    { style =
        Animation.style
            [ Animation.opacity 1.0
            , Animation.rotate (Animation.turn 0.0)
            ]
    , angle = 0.0
    }


subscriptions : Model -> (Msg -> m) -> Sub m
subscriptions model msgFn =
    Sub.map msgFn <|
        Animation.subscription Animate [ model.style ]


type Msg
    = FancyAnim
    | Animate Animation.Msg


update : Msg -> Model -> Model
update action model =
    let
        newAngle =
            model.angle + 0.25

        easingFun =
            Animation.easing
                { duration = 1 * Time.second
                , ease = Ease.outBounce
                }
    in
        case action of
            FancyAnim ->
                { model
                    | style =
                        Animation.interrupt
                            [ Animation.toWith easingFun
                                [ Animation.rotate <| Animation.turn newAngle ]
                            ]
                            model.style
                    , angle = newAngle
                }

            Animate animMsg ->
                { model
                    | style = Animation.update animMsg model.style
                }


view : Model -> (Msg -> m) -> Html m
view model msgFn =
    div
        (Animation.render model.style
            ++ [ onClick <| msgFn FancyAnim
               , style
                    [ ( "position", "relative" )
                    , ( "margin", "100px auto" )
                    , ( "padding", "25px" )
                    , ( "width", "200px" )
                    , ( "height", "200px" )
                    , ( "background-color", "#40c4ff" )
                    , ( "font-size", "16px" )
                    ]
               ]
        )
        [ text "Click to have fun!" ]
