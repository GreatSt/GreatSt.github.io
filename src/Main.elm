module Main exposing (..)

import Model exposing (..)
import View exposing (..)
import UpdateMsg exposing (..)
import UrlParser exposing (..)
import Navigation exposing (..)


main : Program Never Model Msg
main =
    Navigation.program locFor
        { init = \location -> ( init location, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }


locFor : Location -> Msg
locFor location =
    parseHash route location
        |> GoTo


init : Location -> Model
init location =
    let
        tabID =
            case parseHash route location of
                Nothing ->
                    0

                Just (Tab index) ->
                    index
    in
        initModel tabID


route : Parser (Page -> a) a
route =
    oneOf
        [ UrlParser.map Tab (int)
        ]
