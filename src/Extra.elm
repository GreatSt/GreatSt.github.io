module Extra exposing (..)

import Extra.BoxAnimation as BoxAnimation
import Html exposing (Html, div, text, h1)
import Extra.Transformer as Transformer


type alias Model =
    { transModel : Transformer.Model
    , boxModel : BoxAnimation.Model
    }


type Msg
    = TransMsg Transformer.Msg
    | BoxMsg BoxAnimation.Msg


initModel : Model
initModel =
    { transModel = Transformer.initModel
    , boxModel = BoxAnimation.initModel
    }


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "To be continued..." ]
        , Transformer.view model.transModel TransMsg
        , BoxAnimation.view model.boxModel BoxMsg
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BoxMsg boxMsg ->
            ( { model | boxModel = BoxAnimation.update boxMsg model.boxModel }
            , Cmd.none
            )

        TransMsg transMsg ->
            let
                ( transModel, transCmd ) =
                    Transformer.update transMsg model.transModel
            in
                ( { model | transModel = transModel }
                , Cmd.map (TransMsg) transCmd
                )


subscriptions : Model -> (Msg -> m) -> Sub m
subscriptions model lift =
    Sub.batch
        [ Transformer.subscriptions model.transModel <| lift << TransMsg
        , BoxAnimation.subscriptions model.boxModel <| lift << BoxMsg
        ]
