module Resume.ModelMsg exposing (..)

import Material
import Animation exposing (px)
import Animation.Messenger


type alias Model =
    { chosenCard : Info
    , mdl : Material.Model
    , style1 : Animation.State
    , style2 : Animation.Messenger.State Msg
    , isIn : Bool
    , newText : Bool
    }


type Msg
    = TeachMsg TeachJob
    | ShowMore Info
    | MdlMsg (Material.Msg Msg)
    | FancyAnim
    | SwitchText
    | Animate Animation.Msg


initModel : Model
initModel =
    { chosenCard = None
    , mdl = Material.model
    , style1 =
        Animation.style
            [ Animation.height <| Animation.px 210
            ]
    , style2 =
        Animation.style
            [ Animation.opacity 1.0
            ]
    , isIn = True
    , newText = False
    }


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
