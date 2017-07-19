module CvView exposing (..)

import Material.Options as Options exposing (css)
import Html exposing (..)
import Model exposing (..)
import Html.Attributes exposing (href)
import Material.Grid exposing (Device(..), cell, grid, offset, size)
import UpdateMsg exposing (..)
import Material.Button as Button


cvGrid : Model -> Html Msg
cvGrid model =
    grid []
        [ cell [ size All 12, css "text-align" "center" ]
            [ h1 [] [ text "To be continued..." ] ]
        , cell
            (bStyle
                [ size Desktop 4
                , size Tablet 4
                , size Phone 4
                ]
            )
          <|
            if model.selectedMore /= School then
                [ h2 [] [ text "Eduacation" ]
                , moreInfoButton model School
                ]
            else
                [ schoolText
                , backButton model
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
                [ h2 [] [ text "Work Experience" ]
                , moreInfoButton model Work
                ]
            else
                [ workText
                , backButton model
                ]
        , cell
            (bStyle
                [ size Desktop 4
                , size Tablet 4
                , size Phone 4
                ]
            )
          <|
            if model.selectedMore /= Skills then
                [ h2 [] [ text "Software Skills" ]
                , moreInfoButton model Skills
                ]
            else
                [ softwareSkillButton
                , backButton model
                ]
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Interests" ]
            , text <|
                "I have a wide area of interests at the moment from "
                    ++ "functional programming to algorithms about machine "
                    ++ "learning or computer graphics. But whatevery I do, "
                    ++ "there is always a part about creative problem solving."
            ]
        , cell
            (bStyle
                [ size Desktop 4
                , size Tablet 4
                , size Phone 4
                ]
            )
          <|
            if model.selectedMore /= Teaching then
                [ h2 [] [ text "Teaching" ]
                , moreInfoButton model Teaching
                ]
            else
                [ teachingText
                , backButton model
                ]
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Public Projects" ]
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
            [ h4 [] [ text "Communication Skills" ]
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
        , css "height" "230px"
        , css "padding-left" "8px"
        , css "padding-top" "4px"
        , css "text-align" "center"
        ]
        more


schoolText : Html Msg
schoolText =
    div []
        [ text "2010 – 2013:"
        , br [] []
        , text "Matematisk spetsutbildning Leonardo"
        , br [] []
        , text "Ehrensvärdska gymnasiet, Karlskrona"
        , br [] []
        , br [] []
        , text "2013 – present:"
        , br [] []
        , text "Datateknik (300 hp)"
        , br [] []
        , text "Chalmers University of Technology, Gothenbrg"
        , br [] []
        , br [] []
        , text "2016 – present:"
        , br [] []
        , text "Computer Science – algorithms, languages and logic"
        , br [] []
        , text "Master program at Chalmers University of Technology, Gothenbrg"
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


softwareSkillButton : Html msg
softwareSkillButton =
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
