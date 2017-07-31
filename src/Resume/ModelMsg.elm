module Resume.ModelMsg exposing (..)

import Material


type alias Model =
    { chosenCard : Info
    , mdl : Material.Model
    }


type Msg
    = TeachMsg TeachJob
    | ShowMore Info
    | MdlMsg (Material.Msg Msg)


initModel : Model
initModel =
    Model None Material.model


type Info
    = None
    | School Int
    | Work
    | Skills
    | Teach TeachJob


type TeachJob
    = AllT
    | BackHome
    | Intize
    | SI
    | Galaren
