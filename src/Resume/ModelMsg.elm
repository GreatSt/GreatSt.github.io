module Resume.ModelMsg exposing (..)

import Material
import Animation exposing (px)
import Animation.Messenger


type alias Model =
    { chosenCard : Info
    , mdl : Material.Model
    , style : TransitionStyles
    , transition : Animation.Messenger.State Msg

    -- This transition is later paired with the MeasureH message
    -- to set the real transition. If Nothing, MeasureH will nothing.
    , hTransition : Maybe (Float -> Animation.Messenger.State Msg)
    }


type alias TransitionStyle =
    { card : Animation.State
    , text : Animation.Messenger.State Msg
    }


type alias TransitionStyles =
    { intize : TransitionStyle
    , si : TransitionStyle
    }


type Msg
    = TeachMsg TeachJob
    | ShowMore Info
    | SwithToMore Info
    | MdlMsg (Material.Msg Msg)
    | FancyAnim TeachJob
    | SwitchText TeachJob
    | Animate Animation.Msg
    | MeasureH Float


initModel : Model
initModel =
    { chosenCard = None
    , mdl = Material.model
    , style =
        TransitionStyles
            { card =
                Animation.style
                    [ Animation.height <| Animation.px 210
                    ]
            , text =
                Animation.style
                    [ Animation.opacity 1.0
                    ]
            }
            { card =
                Animation.style
                    [ Animation.height <| Animation.px 260
                    ]
            , text =
                Animation.style
                    [ Animation.opacity 1.0
                    ]
            }
    , transition =
        Animation.style
            [ Animation.marginTop <| Animation.px 0.0 ]
    , hTransition = Nothing
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
