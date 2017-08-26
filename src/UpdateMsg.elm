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
    | Mdl (Material.Msg Msg)
    | ExtraMsg Extra.Msg
    | GoTo (Maybe PageMsg)
    | ResumeMsg ResumeM.Msg


type PageMsg
    = GetTab Int
    | SetTab Int
    | GetCatergory String
    | SetCatergory String


setTab : Int -> Msg
setTab =
    GoTo << Just << SetTab


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

        GoTo page ->
            case page of
                Just (GetTab index) ->
                    ( { model
                        | selectedTab = index
                        , resumeModel = ResumeM.initModel
                      }
                    , Cmd.none
                    )

                Just (SetTab i) ->
                    ( model, newUrl <| "#" ++ (toString i) )

                -- I don't like this:
                Just (GetCatergory str) ->
                    ( { model
                        | selectedTab = 1
                        , resumeModel =
                            ResumeM.initModel1 <|
                                case str of
                                    "school" ->
                                        ResumeM.School 0

                                    "work" ->
                                        ResumeM.Work

                                    "skills" ->
                                        ResumeM.Skills

                                    "teach" ->
                                        ResumeM.Teach ResumeM.AllT

                                    _ ->
                                        ResumeM.None
                      }
                    , Cmd.none
                    )

                _ ->
                    ( model, Cmd.none )

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
