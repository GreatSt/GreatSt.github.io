module Model exposing (..)

import Material
import Navigation exposing (..)
import UrlParser exposing (..)


type alias Model =
    { count : Int
    , mdl :
        Material.Model

    -- Boilerplate: model store for any and all Mdl components you use.
    , selectedTab : Int
    }


initModel : Int -> Model
initModel tabID =
    { count = 0
    , mdl =
        Material.model

    -- Boilerplate: Always use this initial Mdl model store.
    , selectedTab = tabID
    }
