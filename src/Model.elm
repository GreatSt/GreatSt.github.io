module Model exposing (..)

import Material
import Extra


type alias Model =
    { count : Int
    , mdl : Material.Model
    , selectedTab : Int
    , selectedMore : Info
    , extraModel : Extra.Model
    }


type Info
    = None
    | School Int
    | Work
    | Skills
    | Teaching TeachJob


type TeachJob
    = AllT
    | Intize
    | SI
    | Galaren


initModel : Int -> Model
initModel tabID =
    { count = 0
    , mdl = Material.model
    , selectedTab = tabID
    , selectedMore = None
    , extraModel = Extra.initModel
    }
