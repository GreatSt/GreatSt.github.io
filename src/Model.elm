module Model exposing (..)

import Material


type alias Model =
    { count : Int
    , mdl :
        Material.Model

    -- Boilerplate: model store for any and all Mdl components you use.
    , selectedTab : Int
    }


initModel : Model
initModel =
    { count = 0
    , mdl =
        Material.model

    -- Boilerplate: Always use this initial Mdl model store.
    , selectedTab = 0
    }
