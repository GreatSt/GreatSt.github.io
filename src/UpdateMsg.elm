module UpdateMsg exposing (..)

import Extra
import Material
import Model exposing (..)
import Navigation exposing (newUrl)
import Resume.ModelMsg as ResumeM
import Resume


type Msg
    = Increase
    | Reset
    | SelectTab Int
    | Mdl (Material.Msg Msg)
    | ExtraMsg Extra.Msg
    | GoTo (Maybe Page)
    | ResumeMsg ResumeM.Msg


type Page
    = Tab Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increase ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Reset ->
            ( { model | count = 0 }
            , Cmd.none
            )

        SelectTab num ->
            { model | selectedTab = num } ! [ newUrl <| "#" ++ (toString num) ]

        GoTo page ->
            case page of
                Just (Tab index) ->
                    ( { model
                        | selectedTab = index
                        , resumeModel = ResumeM.initModel
                      }
                    , Cmd.none
                    )

                Nothing ->
                    ( { model | selectedTab = 0 }
                    , Cmd.none
                    )

        Mdl msg_ ->
            Material.update Mdl msg_ model

        ResumeMsg msg_ ->
            let
                ( m, cmd ) =
                    Resume.update msg_ model.resumeModel
            in
                ( { model | resumeModel = m }, Cmd.map (ResumeMsg) cmd )

        ExtraMsg msg_ ->
            let
                ( mdl, cmd ) =
                    Extra.update msg_ model.extraModel
            in
                ( { model | extraModel = mdl }, Cmd.map (ExtraMsg) cmd )
