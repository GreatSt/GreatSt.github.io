module Resume.CvView exposing (..)

import Array
import Html exposing (..)
import Html.Attributes exposing (attribute, href, style)
import Material.Button as Button
import Material.Grid exposing (Device(..), cell, grid, offset, size)
import Material.Options as Options exposing (css)
import Resume.ModelMsg exposing (..)


cvGrid : Model -> Html Msg
cvGrid model =
    let
        cellStyle action =
            (bStyle
                [ size Desktop 4
                , size Tablet 4
                , size Phone 4
                , Options.onClick <| ShowMore action
                ]
            )

        guiPressGuide str =
            p [ style [ ( "color", "#AAAAAA" ) ] ]
                [ text str ]
    in
        grid []
            [ cell [ size All 12, css "text-align" "center" ]
                [ h1 [] [ text "W.I.P." ] ]
            , cell
                (bStyle
                    [ size Desktop 4
                    , size Tablet 4
                    , size Phone 4
                    ]
                )
              <|
                case model.chosenCard of
                    School n ->
                        [ schoolText n
                        , div []
                            [ arrowButton ((n - 1) % 3) "<" model
                            , backButton model
                            , arrowButton ((n + 1) % 3) ">" model
                            ]
                        ]

                    _ ->
                        [ schoolIntroText
                        , moreInfoButton model <| School 0
                        ]
            , cell (cellStyle Work) <|
                [ workIntroText
                , guiPressGuide "(press me)"
                ]
            , cell (cellStyle Skills) <|
                [ swSkillIntroText
                , guiPressGuide "(press me)"
                ]
            , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
                [ h3 [] [ text "Interests" ]
                , text <|
                    "I have a wide area of interests at the moment from "
                        ++ "functional programming to algorithms about machine "
                        ++ "learning or computer graphics. But whatevery I do, "
                        ++ "there is always a part about creative problem solving."
                ]
            , cell (cellStyle <| Teach AllT)
                [ teachingIntroText
                , guiPressGuide "(press me)"
                ]
            , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
                [ h3 [] [ text "Public Projects" ]
                , text "2016:"
                , br [] []
                , text "Chalmers Bachelor Thesis ("
                , a [ href "http://www.lib.chalmers.se/en/publishing/to-publish/student-theses/" ]
                    [ text "lib.chalmers.se" ]
                , text ")"
                , br [] []
                , text "Abstract Visualization of Algorithms and Data Structures"
                ]
            , cell (bStyle [ size All 12 ])
                [ h3 [] [ text "Communication Skills" ]
                , text "Native: Swedish"
                , br [] []
                , text "Advanced: English"
                , br [] []
                , text "Forgotten: Germany"
                ]
            ]


moreInfoButton : Model -> Info -> Html Msg
moreInfoButton model info =
    Button.render
        MdlMsg
        [ 2 ]
        model.mdl
        [ Options.onClick <| ShowMore info
        , Button.raised
        ]
        [ text "More" ]


arrowButton : Int -> String -> Model -> Html Msg
arrowButton n arrow model =
    Button.render
        MdlMsg
        [ 4 ]
        model.mdl
        [ Options.onClick <| ShowMore <| School n
        , Button.raised
        ]
        [ text arrow ]


backButton : Model -> Html Msg
backButton model =
    Button.render
        MdlMsg
        [ 3 ]
        model.mdl
        [ Options.onClick <| ShowMore None
        , Button.raised
        ]
        [ text "Back" ]


bStyle : List (Options.Style a) -> List (Options.Style a)
bStyle more =
    List.append
        [ css "text-sizing" "border-box"
        , css "overflow" "auto"
        , css "background-color" "#DDDDDD"
        , css "height" "250px"
        , css "padding-left" "8px"
        , css "padding-top" "10px"
        , css "text-align" "center"
        ]
        more


schoolIntroText : Html Msg
schoolIntroText =
    div []
        [ h3 [] [ text "Eduacation" ]
        , p []
            [ text "Chalmers – Master of Science in Computer Science"
            , br [] []
            , text "Matematisk spetsutbildning Leonardo"
            ]
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


workIntroText : Html Msg
workIntroText =
    div []
        [ h3 [] [ text "Work Experience" ]
        , p []
            [ text "Distributed System Programmer – FCC"
            , br [] []
            , text "Mobile Game Programmer – Zogaj Memo Gym"
            ]
        ]


swSkillIntroText : Html msg
swSkillIntroText =
    div []
        [ h3 [] [ text "Software Skills" ]
        , h6 []
            [ text "Favorite languages:"
            , br [] []
            , i [] [ text "Rust, Elm, Scala" ]
            ]
        ]


teachingIntroText : Html msg
teachingIntroText =
    div []
        [ h3 [] [ text "Teaching" ]
        , h6 []
            [ text "Mentor in Mathematics – Intize"
            , br [] []
            , text "Programming Teacher – Galären"
            ]
        ]
