module CvView exposing (..)

import Array
import Html exposing (..)
import Html.Attributes exposing (attribute, href, style)
import Material.Button as Button
import Material.Grid exposing (Device(..), cell, grid, offset, size)
import Material.Options as Options exposing (css)
import Model exposing (..)
import TeachingView exposing (teachView)
import UpdateMsg exposing (..)


cvView : Model -> Html Msg
cvView model =
    case model.selectedMore of
        Teaching job ->
            teachView model job

        _ ->
            cvGrid model


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
                case model.selectedMore of
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
            , cell
                (bStyle
                    [ size Desktop 4
                    , size Tablet 4
                    , size Phone 4
                    ]
                )
              <|
                if model.selectedMore /= Work then
                    [ workIntroText
                    , moreInfoButton model Work
                    ]
                else
                    [ workText
                    , backButton model
                    ]
            , if model.selectedMore /= Skills then
                cell (cellStyle Skills) <|
                    [ swSkillIntroText
                    , guiPressGuide "(press me)"
                    ]
              else
                cell (cellStyle None) <|
                    [ softwareSkillText
                    , guiPressGuide "(press to return)"
                    ]
            , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
                [ h3 [] [ text "Interests" ]
                , text <|
                    "I have a wide area of interests at the moment from "
                        ++ "functional programming to algorithms about machine "
                        ++ "learning or computer graphics. But whatevery I do, "
                        ++ "there is always a part about creative problem solving."
                ]
            , if model.selectedMore /= Teaching AllT then
                cell (cellStyle <| Teaching AllT)
                    [ teachingIntroText
                    , guiPressGuide "(press me)"
                    ]
              else
                cell (cellStyle None)
                    [ teachingText
                    , guiPressGuide "(press to return)"
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
        Mdl
        [ 2 ]
        model.mdl
        [ Options.onClick <| ShowMore info
        , Button.raised
        ]
        [ text "More" ]


arrowButton : Int -> String -> Model -> Html Msg
arrowButton n arrow model =
    Button.render
        Mdl
        [ 4 ]
        model.mdl
        [ Options.onClick <| ShowMore <| School n
        , Button.raised
        ]
        [ text arrow ]


backButton : Model -> Html Msg
backButton model =
    Button.render
        Mdl
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


workText : Html Msg
workText =
    div []
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
        , br [] []
        , p []
            [ text "June 2015 – August 2015"
            , br [] []
            , text "Zogaj of Sweden, Gothenburg"
            , br [] []
            , text "Game programmer"
            ]
        , text "Continuing work on the game "
        , em [] [ text "Zogaj Memo Gym" ]
        , text " while expanding to iOS using RoboVM."
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


softwareSkillText : Html msg
softwareSkillText =
    div []
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


teachingText : Html msg
teachingText =
    div []
        [ p []
            [ text "April 2013 – May 2013"
            , br [] []
            , text "Galären (AcadeMedia Fria Grundskolor), Karskrona"
            , br [] []
            , text "Programming teacher"
            ]
        , text <|
            "Teaching programming to curious kids from 12 to 16 years "
                ++ "old. Got recommended by a math teacher as a talented "
                ++ "guy and someone with spare time. All the pupils wished "
                ++ "to try programming as a voluntary subject in the end "
                ++ "of the school year and I made that possible."
        , br [] []
        , br [] []
        , p []
            [ text "August 2014 – November 2014"
            , br [] []
            , text "Chalmers University of Technology, Gothenburg"
            , br [] []
            , text "Supplementary Instructor (SI leader)"
            ]
        , text <|
            "A leader of SI (supplemental instruction) in linear algebra "
                ++ "at Chalmers."
        , br [] []
        , br [] []
        , p []
            [ text "October 2016 – May 2017"
            , br [] []
            , text "Intize, Gothenburg"
            , br [] []
            , text "Intize Mentor"
            ]
        , text <|
            "Intize is a non-profit organisation that provides mentorship "
                ++ "in mathematics. I am one of these voluntary mentors "
                ++ "and together we work towards a more educated world."
        ]
