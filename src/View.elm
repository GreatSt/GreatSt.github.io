module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, href, style)
import Material.Options as Options exposing (css)
import Material
import Material.Button as Button
import Material.Color as Color
import Material.Layout as Layout
import Model exposing (..)
import CvView exposing (..)
import UpdateMsg exposing (..)


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
            cvGrid model

        _ ->
            h1 [] [ text "404" ]


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
