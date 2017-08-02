module Resume.SoftwareSkills exposing (..)

import Html exposing (Html, b, br, div, p, text)
import Html.Attributes exposing (style)
import Material.Grid as Grid exposing (Device(..), offset, size)
import Material.Options as Options exposing (css)
import Resume.ModelMsg exposing (..)


overview : Model -> Html Msg
overview model =
    let
        cellStyle =
            [ size All 4
            , offset Desktop 4
            , offset Tablet 2
            , Options.onClick <| ShowMore None
            , css "text-sizing" "border-box"
            , css "overflow" "auto"
            , css "background-color" "#DDE0DD"
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
                [ p [] [ b [] [ text "Advanced:" ] ]
                , text "Java"
                , br [] []
                , text "Haskell"
                , br [] []
                , br [] []
                , p [] [ b [] [ text "Intermediate:" ] ]
                , text <|
                    "C, C#, C++, CSS, Elm, git, HTML, LaTeX, "
                        ++ "LibGDX, PostgreSQL, OpenGL, Scala"
                , br [] []
                , br [] []
                , p [] [ b [] [ text "Basic:" ] ]
                , text <|
                    "Assembly, Android, AngularJS, Bootstrap, Erlang, "
                        ++ "iOS, Javascript, JSON, Kotlin, Linux, MacOS, "
                        ++ "Mathematica, MATLAB, MySQL, PHP, Python, Rust, "
                        ++ "Unity 3D, Windows"
                , br [] []
                , guiPressGuide
                ]
            ]
