module Resume.Education exposing (..)

import Array
import Html exposing (Html, b, br, button, div, h4, p, text)
import Html.Attributes exposing (style)
import Json.Decode as Decode
import Material.Button as Button
import Material.Elevation as Elevation
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
            , Elevation.e2
            , css "text-sizing" "border-box"
            , css "overflow" "auto"
            , css "background-color" "#E0DDDD"
            , css "padding-left" "8px"
            , css "padding-top" "10px"
            , css "padding-bottom" "10px"
            , css "text-align" "center"
            ]

        guiPressGuide =
            b
                [ style
                    [ ( "color", "#AAAAAA" )
                    , ( "margin", "10px" )
                    ]
                ]
                [ text "(press to return)" ]
    in
        Grid.grid []
            [ Grid.cell cellStyle <|
                case model.chosenCard of
                    School n ->
                        [ schoolText n
                        , div []
                            [ arrowButton ((n - 1) % 3) "<" model
                            , guiPressGuide
                            , arrowButton ((n + 1) % 3) ">" model
                            ]
                        ]

                    _ ->
                        []
            ]


schoolText : Int -> Html Msg
schoolText i =
    let
        arr =
            Array.fromList
                [ schoolText1
                , schoolText2
                , schoolText3
                ]
    in
        case Array.get i arr of
            Nothing ->
                schoolText1

            Just school ->
                school


schoolText1 : Html Msg
schoolText1 =
    div []
        [ h4 [] [ text "2016 – present:" ]
        , p [] [ text "Computer Science – algorithms, languages and logic" ]
        , p [] [ text "Master program at Chalmers University of Technology, Gothenborg" ]
        ]


schoolText2 : Html Msg
schoolText2 =
    div []
        [ h4 [] [ text "2013 – present:" ]
        , p [] [ text "Datateknik (300 hp)" ]
        , p [] [ text "Chalmers University of Technology, Gothenbrg" ]
        ]


schoolText3 : Html Msg
schoolText3 =
    div []
        [ h4 [] [ text "2010 – 2013:" ]
        , p [] [ text "Matematisk spetsutbildning Leonardo" ]
        , p [] [ text "Ehrensvärdska gymnasiet, Karlskrona" ]
        ]


arrowButton : Int -> String -> Model -> Html Msg
arrowButton n arrow model =
    Button.render
        MdlMsg
        [ n ]
        model.mdl
        [ Options.onWithOptions "click"
            { stopPropagation = True, preventDefault = False }
          <|
            Decode.succeed <|
                SwithToMore <|
                    School n
        , Button.raised
        , Button.ripple
        ]
        [ text arrow ]


backButton : Model -> Html Msg
backButton model =
    Button.render
        MdlMsg
        [ -1 ]
        model.mdl
        [ Options.onClick <| ShowMore None
        , Button.raised
        , Button.ripple
        ]
        [ text "Back" ]
