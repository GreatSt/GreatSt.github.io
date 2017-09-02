module Resume.WorkExp exposing (..)

import Html exposing (Html, a, br, div, em, p, text)
import Html.Attributes exposing (href)
import Html.Attributes exposing (style)
import Material.Elevation as Elevation
import Material.Grid as Grid exposing (Device(..), offset, size)
import Material.Options as Options exposing (css)
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
            , css "background-color" "#E5DDE5"
            , css "padding-left" "8px"
            , css "padding-top" "10px"
            , css "text-align" "center"
            ]

        guiPressGuide =
            p [ style [ ( "color", "#AAAAAA" ) ] ]
                [ text "(press to return)" ]
    in
        Grid.grid []
            [ Grid.cell cellStyle
                [ p []
                    [ text "June 2017 – July 2017"
                    , br [] []
                    , text "FCC (Fraunhofer-Chalmers Centre), Gothenburg"
                    , br [] []
                    , text "Programmer"
                    ]
                , text """
                  A very extensive work, where I did distributed networking,
                  low-level programming, GUI, and neural networks.
                  Languages included Erlang, C, Python, and Bash.
                  """
                , br [] []
                , guiPressGuide
                ]
            , Grid.cell cellStyle
                [ p []
                    [ text "June 2014 – August 2014"
                    , br [] []
                    , text "Zogaj of Sweden, Gothenburg"
                    , br [] []
                    , text "Game programmer"
                    ]
                , text "Porting of "
                , em [] [ text "Zogaj Memo Gym" ]
                , text <|
                    " from iOS to Android. The port could be considered a remaster "
                        ++ "of the original game as everything was rewritten in "
                        ++ "LibGDX. Employed by "
                , a [ href "http://www.zogaj.se/" ] [ text "Idriz Zogaj." ]
                , br [] []
                , guiPressGuide
                ]
            , Grid.cell cellStyle
                [ p []
                    [ text "June 2015 – August 2015"
                    , br [] []
                    , text "Zogaj of Sweden, Gothenburg"
                    , br [] []
                    , text "Game programmer"
                    ]
                , text "Continuing work on the game "
                , em [] [ text "Zogaj Memo Gym" ]
                , text " while expanding to iOS using RoboVM."
                , br [] []
                , guiPressGuide
                ]
            ]
