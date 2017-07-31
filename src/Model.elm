module Model exposing (..)

import Material
import Extra
import Resume.ModelMsg as Resume


type alias Model =
    { count : Int
    , mdl : Material.Model
    , selectedTab : Int
    , resumeModel : Resume.Model
    , extraModel : Extra.Model
    }


initModel : Int -> Model
initModel tabID =
    { count = 0
    , mdl = Material.model
    , selectedTab = tabID
    , resumeModel = Resume.initModel
    , extraModel = Extra.initModel
    }
