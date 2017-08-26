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


initModel : Model
initModel =
    { count = 0
    , mdl = Material.model
    , selectedTab = 0
    , resumeModel = Resume.initModel
    , extraModel = Extra.initModel
    }
