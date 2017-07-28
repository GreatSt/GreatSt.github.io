module Model exposing (..)

import BoxAnimation
import Material


type alias Model =
    { count : Int
    , mdl : Material.Model
    , selectedTab : Int
    , selectedMore : Info
    , boxModel : BoxAnimation.Model
    }


type Info
    = None
    | School Int
    | Work
    | Skills
    | Teaching


initModel : Int -> Model
initModel tabID =
    { count = 0
    , mdl = Material.model
    , selectedTab = tabID
    , selectedMore = None
    , boxModel = BoxAnimation.initModel
    }
