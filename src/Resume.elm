module Resume exposing (..)

import Resume.CvView as CvView
import Html exposing (Html, div, h1, text)
import Material
import Resume.Teaching as Teaching exposing (teachView)
import Resume.ModelMsg exposing (..)


view : Model -> Html Msg
view model =
    case model.chosenCard of
        Teach job ->
            teachView job model

        _ ->
            CvView.cvGrid model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TeachMsg job ->
            Teaching.update job model

        ShowMore info ->
            ( { model | chosenCard = info }, Cmd.none )

        MdlMsg msg_ ->
            Material.update MdlMsg msg_ model
