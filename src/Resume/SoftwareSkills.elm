module Resume.SoftwareSkills exposing (..)

import Html exposing (Html, b, br, div, p, text)
import Html.Attributes exposing (style)
import Material.Elevation as Elevation
import Material.Grid as Grid exposing (Device(..), offset, size)
import Material.Options as Options exposing (css)
import Material.Table as Table
import Resume.ModelMsg exposing (..)


overview : Html Msg
overview =
    let
        cellStyle =
            [ size All 4
            , offset Desktop 4
            , offset Tablet 2
            , Options.onClick <| ShowMore None
            , Elevation.e2
            , css "text-sizing" "border-box"
            , css "overflow" "auto"
            , css "background-color" "#DDDDEE"
            , css "padding-left" "8px"
            , css "padding-top" "10px"
            ]

        guiPressGuide =
            p [ style [ ( "color", "#AAAAAA" ), ( "text-align", "center" ) ] ]
                [ text "(press to return)" ]
    in
        Grid.grid []
            [ Grid.cell cellStyle
                [ p [ style [ ( "font-size", "large" ) ] ] [ text """
                I am facinated by designs and programming languages are not
                an exception(). Below you can see a list of languages I remember
                using. Those that I fancy the most are: Rust, Haskell, Elm,
                Scala, Kotlin.
                """ ]
                , guiPressGuide
                ]
            , Grid.cell
                [ size All 4
                , offset Desktop 4
                , offset Tablet 2
                ]
                [ table
                ]
            ]


type alias Data =
    { language : String
    , score : String
    }


table : Html Msg
table =
    Table.table [ css "margin" "auto" ]
        [ Table.thead []
            [ Table.tr []
                [ Table.th [] [ text "Language" ]
                , Table.th [] [ text "Score" ]
                ]
            ]
        , Table.tbody []
            (data
                |> List.map
                    (\item ->
                        Table.tr []
                            [ Table.td [] [ text item.language ]
                            , Table.td [] [ text item.score ]
                            ]
                    )
            )
        ]


data : List Data
data =
    [ { language = "Java"
      , score = "Okej"
      }
    , { language = "Rust"
      , score = "Great"
      }
    , { language = "Elm"
      , score = "Good"
      }
    , { language = "Haskell"
      , score = "Good"
      }
    , { language = "C"
      , score = "Okej"
      }
    , { language = "C++"
      , score = "Okej"
      }
    , { language = "C#"
      , score = "Good"
      }
    , { language = "Python"
      , score = "Good"
      }
    , { language = "Assembly"
      , score = "Essential"
      }
    , { language = "Javascript"
      , score = "Bad"
      }
    , { language = "Scala"
      , score = "Good"
      }
    , { language = "CSS"
      , score = "Bad"
      }
    , { language = "HTML"
      , score = "Bad"
      }
    , { language = "PostgreSQL"
      , score = "Okej"
      }
    , { language = "Erlang"
      , score = "Okej"
      }
    , { language = "Kotlin"
      , score = "Good"
      }
    , { language = "Mathematica"
      , score = "Okej"
      }
    , { language = "MATLAB"
      , score = "Okej"
      }
    , { language = "PHP"
      , score = "Bad"
      }
    , { language = "LaTeX"
      , score = "Unclear"
      }
    ]



{- Extra: Git, OpenGL, Android, Bootstrap, Unity3D, Windows, Linux, MacOS -}
