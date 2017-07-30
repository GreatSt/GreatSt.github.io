module Model exposing (..)

import BoxAnimation
import Material
import Transformer


type alias Model =
    { count : Int
    , mdl : Material.Model
    , selectedTab : Int
    , selectedMore : Info
    , boxModel : BoxAnimation.Model
    , boxTransModel : Transformer.Model
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
    , boxModel = BoxAnimation.initModel
    , boxTransModel = Transformer.initModel
    }
