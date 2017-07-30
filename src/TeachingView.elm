module TeachingView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Material.Button as Button
import Material.Grid exposing (..)
import Material.Options as Options exposing (css)
import Model exposing (..)
import UpdateMsg exposing (..)


teachView : Model -> TeachJob -> Html Msg
teachView model job =
    case job of
        Intize ->
            intizeView

        SI ->
            siView

        Galaren ->
            galarenView

        _ ->
            overview model


overview : Model -> Html Msg
overview model =
    div []
        [ grid []
            [ cell
                [ size All 4
                , offset Desktop 4
                , offset Tablet 2
                , css "text-sizing" "border-box"
                , css "overflow" "auto"
                , css "padding-bottom" "2px"
                , css "padding-top" "10px"
                , css "text-align" "center"
                ]
                [ tBackButton model ]
            , intizeCell
            , siCell
            , galarenCell
            ]
        ]


intizeView : Html Msg
intizeView =
    jobView
        "October 2016 – May 2017"
        "Intize, Gothenburg"
        "Intize Mentor"
    <|
        "Intize is a non-profit organisation that provides mentorship "
            ++ "in mathematics. I am one of these voluntary mentors "
            ++ "and together we work towards a more educated world."


siView : Html Msg
siView =
    jobView
        "August 2014 – November 2014"
        "Chalmers University of Technology, Gothenburg"
        "Supplementary Instructor (SI leader)"
    <|
        "A leader of SI (supplemental instruction) in linear algebra "
            ++ "at Chalmers."


galarenView : Html Msg
galarenView =
    jobView
        "April 2013 – May 2013"
        "Galären (AcadeMedia Fria Grundskolor), Karskrona"
        "Programming teacher"
    <|
        "Teaching programming to curious kids from 12 to 16 years "
            ++ "old. Got recommended by a math teacher as a talented "
            ++ "guy and someone with spare time. All the pupils wished "
            ++ "to try programming as a voluntary subject in the end "
            ++ "of the school year and I made that possible."


jobView : String -> String -> String -> String -> Html Msg
jobView period place role body =
    grid []
        [ cell
            [ size All 4
            , offset Desktop 4
            , offset Tablet 2
            , Options.onClick <| ShowMore <| Teaching AllT
            , css "text-sizing" "border-box"
            , css "overflow" "auto"
            , css "background-color" "#DDDDEE"
            , css "padding-left" "8px"
            , css "padding-top" "10px"
            , css "text-align" "center"
            ]
            [ p []
                [ text period
                , br [] []
                , text place
                , br [] []
                , text role
                ]
            , text body
            , p [ style [ ( "color", "#AAAAAA" ) ] ]
                [ text "(press to return)" ]
            ]
        ]


tBackButton : Model -> Html Msg
tBackButton model =
    Button.render
        Mdl
        [ 3 ]
        model.mdl
        [ Options.onClick <| ShowMore None
        , Button.raised
        ]
        [ text "Back" ]


intizeCell : Cell Msg
intizeCell =
    headerCell
        Intize
        "Intize, Gothenburg"
        "October 2016 – May 2017"
        "Intize Mentor"


siCell : Cell Msg
siCell =
    headerCell
        SI
        "Chalmers University of Technology, Gothenburg"
        "August 2014 – November 2014"
        "Supplementary Instructor (SI leader)"


galarenCell : Cell Msg
galarenCell =
    headerCell
        Galaren
        "Galären (AcadeMedia Fria Grundskolor), Karskrona"
        "April 2013 – May 2013"
        "Programming teacher"


headerCell : TeachJob -> String -> String -> String -> Cell Msg
headerCell job place period role =
    cell
        [ size All 4
        , offset Desktop 4
        , offset Tablet 2
        , Options.onClick <| ShowMore <| Teaching job
        , css "text-sizing" "border-box"
        , css "overflow" "auto"
        , css "background-color" "#DDDDE5"
        , css "padding-left" "8px"
        , css "padding-top" "10px"
        , css "text-align" "center"
        ]
        [ h4 [] [ text place ]
        , p [] [ text period ]
        , h5 [] [ text role ]
        , p [ style [ ( "color", "#AAAAAA" ) ] ]
            [ text "(press me)" ]
        ]
