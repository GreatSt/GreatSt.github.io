module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Material
import Material.Button as Button
import Material.Layout as Layout
import Material.Color as Color
import Material.Options as Options exposing (css)
import Model exposing (..)
import UpdateMsg exposing (..)
import Material.Grid exposing (offset, grid, cell, size, Device(..))


type alias Mdl =
    Material.Model


view : Model -> Html Msg
view model =
    Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        , Layout.scrolling
        , Layout.selectedTab model.selectedTab
        , Layout.onSelectTab SelectTab
        ]
        { header =
            [ p
                [ style
                    [ ( "padding-left", "5mm" )
                    , ( "padding-top", "5mm" )
                    , ( "font-size", "200%" )
                    ]
                ]
                [ text "Simon Smith" ]
            ]
        , drawer = []
        , tabs =
            ( [ text "Main", text "Extra" ]
            , [ Color.background (Color.color Color.DeepOrange Color.S400) ]
            )
        , main = [ viewBody model ]
        }


viewBody : Model -> Html Msg
viewBody model =
    case model.selectedTab of
        0 ->
            div []
                [ h2 [ margin 10 24 ] [ text "Welcome to this humble page." ]
                , p [ margin 24 24 ] aboutMeText
                , viewCounter model
                ]

        1 ->
            cvGrid

        _ ->
            text "404"


aboutMeText : List (Html msg)
aboutMeText =
    [ text "This little page is made with Elm! At the moment there is not much to see here. In the meantime take a look at "
    , a [ href "https://www.dropbox.com/s/7jsn4f4n6a05jbh/resume.pdf?dl=0" ]
        [ text "my resume" ]
    , text " or maybe "
    , a [ href "https://github.com/SimSmith/SimSmith.github.io" ] [ text "the source code" ]
    , text " for this page."
    ]


margin : Int -> Int -> Attribute msg
margin top lef =
    style [ ( "margin", toString top ++ "px " ++ toString lef ++ "px" ) ]


viewCounter : Model -> Html Msg
viewCounter model =
    div
        [ margin 24 24 ]
        [ text ("Confusion count: " ++ toString model.count)
        , Button.render Mdl
            [ 0 ]
            model.mdl
            [ Options.onClick Increase
            , css "margin" "0 12px"
            ]
            [ text "Increase" ]
        , Button.render Mdl
            [ 1 ]
            model.mdl
            [ Options.onClick Reset ]
            [ text "Reset" ]
        ]


cvGrid : Html a
cvGrid =
    grid []
        [ cell [ size All 12, css "text-align" "center" ]
            [ h1 [] [ text "To be continued..." ] ]
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Eduacation" ]
            , text "2010 – 2013:"
            , ul []
                [ li [] [ text "Matematisk spetsutbildning Leonardo" ]
                , li [] [ text "Ehrensvärdska gymnasiet, Karlskrona" ]
                ]
            , text "2013 – present:"
            , ul []
                [ li [] [ text "Datateknik (300 hp)" ]
                , li [] [ text "Chalmers University of Technology, Gothenbrg" ]
                ]
            , text "2016 – present:"
            , ul []
                [ li [] [ text "Computer Science – algorithms, languages and logic" ]
                , li [] [ text "Master program at Chalmers University of Technology, Gothenbrg" ]
                ]
            ]
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Work Experience" ]
            , p []
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
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Software Skills" ]
            , text "Advanced:"
            , ul []
                [ li [] [ text "Java" ]
                , li [] [ text "Haskell" ]
                ]
            , text "Intermediate:"
            , ul []
                [ li []
                    [ text <|
                        "C, C#, C++, CSS, Elm, git, HTML, LaTeX, "
                            ++ "LibGDX, PostgreSQL, OpenGL, Scala"
                    ]
                ]
            , text "Basic:"
            , ul []
                [ li []
                    [ text <|
                        "Assembly, Android, AngularJS, Bootstrap, Erlang, "
                            ++ "iOS, Javascript, JSON, Kotlin, Linux, MacOS, "
                            ++ "Mathematica, MATLAB, MySQL, PHP, Python, Rust, "
                            ++ "Unity 3D, Windows"
                    ]
                ]
            ]
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Interests" ]
            , text <|
                "I have a wide area of interests at the moment from "
                    ++ "functional programming to algorithms about machine "
                    ++ "learning or computer graphics. But whatevery I do, "
                    ++ "there is always a part about creative problem solving."
            ]
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Teaching" ]
            , p []
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
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Public Projects" ]
            , text "2016:"
            , ul []
                [ li []
                    [ text "Chalmers Bachelor Thesis ("
                    , a [ href "http://www.lib.chalmers.se/en/publishing/to-publish/student-theses/" ]
                        [ text "lib.chalmers.se" ]
                    , text ")"
                    ]
                , li [] [ text "Abstract Visualization of Algorithms and Data Structures" ]
                ]
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


bStyle : List (Options.Style a) -> List (Options.Style a)
bStyle more =
    List.append
        [ css "text-sizing" "border-box"
        , css "overflow" "auto"
        , css "background-color" "#BDBDBD"
        , css "height" "200px"
        , css "padding-left" "8px"
        , css "padding-top" "4px"
        , css "color" "white"
        ]
        more
