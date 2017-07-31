module Resume exposing (..)

import Animation exposing (px)
import Animation.Messenger
import Ease exposing (..)
import Html exposing (Html, div, h1, text)
import Material
import Resume.CvView as CvView
import Resume.Teaching as Teaching exposing (teachView)
import Resume.ModelMsg exposing (..)
import Time exposing (..)


view : Model -> Html Msg
view model =
    case model.chosenCard of
        Teach job ->
            teachView job model

        _ ->
            CvView.cvGrid model


subscriptions : Model -> (Msg -> m) -> Sub m
subscriptions =
    Teaching.subscriptions


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
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
        case msg of
            FancyAnim ->
                ( { model
                    | style1 =
                        Animation.interrupt
                            [ Animation.toWith smoothFn
                                [ Animation.height <|
                                    Animation.px <|
                                        if model.isIn then
                                            220
                                        else
                                            210
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

            TeachMsg job ->
                Teaching.update job model

            ShowMore info ->
                ( { model | chosenCard = info }, Cmd.none )

            MdlMsg msg_ ->
                Material.update MdlMsg msg_ model
