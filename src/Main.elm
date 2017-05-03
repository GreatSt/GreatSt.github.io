module Main exposing (..)

import Html
import Model exposing (..)
import View exposing (..)
import UpdateMsg exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = ( initModel, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }
