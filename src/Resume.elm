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

        animation h0 h1 job mdl =
            let
                isIn ifT ifF =
                    if model.chosenCard /= (Teach job) then
                        ifT
                    else
                        ifF
            in
                { card =
                    Animation.interrupt
                        [ Animation.toWith smoothFn
                            [ Animation.height <|
                                Animation.px <|
                                    isIn h1 h0
                            ]
                        ]
                        mdl.card
                , text =
                    Animation.interrupt
                        [ Animation.toWith halfSmoothFn
                            [ Animation.opacity <| 0.0
                            ]
                        , Animation.Messenger.send <| SwitchText job
                        , Animation.toWith halfSmoothFn
                            [ Animation.opacity <| 1.0
                            ]
                        ]
                        mdl.text
                }
    in
        case msg of
            FancyAnim job ->
                ( { model
                    | style =
                        case job of
                            Intize ->
                                TransitionStyles
                                    (animation 210 220 Intize model.style.intize)
                                    model.style.si

                            _ ->
                                TransitionStyles
                                    model.style.intize
                                    (animation 260 205 SI model.style.si)
                  }
                , Cmd.none
                )

            SwitchText job ->
                case model.chosenCard of
                    Teach currentJob ->
                        if job == currentJob then
                            ( { model | chosenCard = Teach AllT }, Cmd.none )
                        else
                            ( { model | chosenCard = Teach job }, Cmd.none )

                    _ ->
                        ( model, Cmd.none )

            Animate animMsg ->
                let
                    newStyle1 =
                        Animation.update animMsg model.style.intize.card

                    ( newStyle2, cmd2 ) =
                        Animation.Messenger.update animMsg model.style.intize.text

                    newStyle3 =
                        Animation.update animMsg model.style.si.card

                    ( newStyle4, cmd4 ) =
                        Animation.Messenger.update animMsg model.style.si.text
                in
                    ( { model
                        | style =
                            TransitionStyles
                                { card = newStyle1, text = newStyle2 }
                                { card = newStyle3, text = newStyle4 }
                      }
                    , Cmd.batch [ cmd2, cmd4 ]
                    )

            TeachMsg job ->
                Teaching.update job model

            ShowMore info ->
                ( { model | chosenCard = info }, Cmd.none )

            MdlMsg msg_ ->
                Material.update MdlMsg msg_ model
