module UpdateMsg exposing (..)

import Extra
import Material
import Model exposing (..)
import Navigation exposing (newUrl)


type Msg
    = Increase
    | Reset
    | SelectTab Int
    | Mdl (Material.Msg Msg)
    | ExtraMsg Extra.Msg
    | GoTo (Maybe Page)
    | ShowMore Info


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
                    ( { model | selectedTab = index }
                    , Cmd.none
                    )

                Nothing ->
                    ( { model | selectedTab = 0 }
                    , Cmd.none
                    )

        ShowMore m ->
            ( { model | selectedMore = m }, Cmd.none )

        Mdl msg_ ->
            Material.update Mdl msg_ model

        ExtraMsg msg ->
            let
                ( mdl, cmd ) =
                    Extra.update msg model.extraModel
            in
                ( { model | extraModel = mdl }, Cmd.map (ExtraMsg) cmd )
