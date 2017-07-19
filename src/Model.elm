module Model exposing (..)

import Material


type alias Model =
    { count : Int
    , mdl :
        Material.Model
        -- Boilerplate: model store for any and all Mdl components you use.
    , selectedTab : Int
    , selectedMore : Info
    }


type Info
    = None
    | School
    | Work
    | Skills
    | Teaching


initModel : Int -> Model
initModel tabID =
    { count = 0
    , mdl =
        Material.model
        -- Boilerplate: Always use this initial Mdl model store.
    , selectedTab = tabID
    , selectedMore = None
    }
