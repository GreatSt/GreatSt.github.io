module Main exposing (..)

import Extra
import Material.Layout as Layout
import Model exposing (..)
import Navigation exposing (..)
import Resume
import UpdateMsg exposing (..)
import UrlParser exposing (..)
import View exposing (..)


main : Program Never Model Msg
main =
    Navigation.program locFor
        { init =
            \location ->
                let
                    ( model, _ ) =
                        update (initLoc location) initModel
                in
                    ( { model
                        -- tab width of 240 is an empirical value
                        | mdl = Layout.setTabsWidth 240 model.mdl
                      }
                    , Layout.sub0 Mdl
                    )
        , view = view
        , update = update
        , subscriptions =
            \model ->
                Sub.batch
                    [ Layout.subs Mdl model.mdl
                    , Extra.subscriptions model.extraModel UpdateMsg.ExtraMsg
                    , Resume.subscriptions model.resumeModel UpdateMsg.ResumeMsg
                    ]
        }


locFor : Location -> Msg
locFor location =
    parseHash route location
        |> GoTo


initLoc : Location -> Msg
initLoc =
    GoTo << parseHash route


route : Parser (PageMsg -> a) a
route =
    oneOf
        [ UrlParser.map GetTab int
        , UrlParser.map GetCatergory string
        ]
