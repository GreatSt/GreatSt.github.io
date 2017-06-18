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
            grids

        _ ->
            text "404"


aboutMeText : List (Html msg)
aboutMeText =
    [ text "This little page is made with Elm! At the moment there is not much to see here. In the meantime take a look at "
    , a [ href "https://www.dropbox.com/s/7jsn4f4n6a05jbh/resume.pdf?dl=0" ] [ text "my resume" ]
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


grids : Html a
grids =
    grid []
        [ cell [ size All 12, css "text-align" "center" ]
            [ h1 [] [ text "To be continued..." ] ]
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Eduacation" ] ]
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Work Experience" ] ]
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Software Skills" ] ]
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Interests" ] ]
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Teaching" ] ]
        , cell (bStyle [ size Desktop 4, size Tablet 4, size Phone 4 ])
            [ h4 [] [ text "Public Projects" ] ]
        , cell (bStyle [ size All 12 ])
            [ h4 [] [ text "Communication Skills" ] ]
        ]


bStyle : List (Options.Style a) -> List (Options.Style a)
bStyle more =
    List.append
        [ css "text-sizing" "border-box"
        , css "background-color" "#BDBDBD"
        , css "height" "200px"
        , css "padding-left" "8px"
        , css "padding-top" "4px"
        , css "color" "white"
        ]
        more
