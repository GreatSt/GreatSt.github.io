module UpdateMsg exposing (..)

import Material
import Model exposing (..)
import Navigation exposing (newUrl)


type Msg
    = Increase
    | Reset
    | SelectTab Int
    | Mdl (Material.Msg Msg)
    | GoTo (Maybe Page)


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

        -- Boilerplate: Mdl action handler.
        Mdl msg_ ->
            Material.update Mdl msg_ model

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
