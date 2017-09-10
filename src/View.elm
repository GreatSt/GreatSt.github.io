module View exposing (view)

import Extra
import Html exposing (..)
import Html.Attributes exposing (class, href, style)
import Markdown
import Material
import Material.Button as Button
import Material.Color as Color
import Material.Grid as Grid exposing (Device(..), grid, cell)
import Material.Layout as Layout
import Material.Options as Options exposing (css)
import Model exposing (..)
import Resume
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
        , Layout.onSelectTab setTab
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
            ( [ text "Main", text "Résumé", text "Extra" ]
            , [ Color.background (Color.color Color.DeepOrange Color.S400) ]
            )
        , main = [ viewBody model ]
        }


viewBody : Model -> Html Msg
viewBody model =
    case model.selectedTab of
        0 ->
            grid []
                [ cell
                    [ Grid.offset Desktop 4
                    , Grid.size All 4
                    , Grid.offset Tablet 2
                    ]
                    [ homeText
                    , br [] []
                    , viewCounter model
                    ]
                ]

        1 ->
            Resume.view model.resumeModel
                |> Html.map (ResumeMsg)

        2 ->
            Extra.view model.extraModel
                |> Html.map (ExtraMsg)

        _ ->
            h1 [] [ text "404" ]


homeText : Html msg
homeText =
    Markdown.toHtml [] """
## Welcome to this humble page

This little page is a project to evaluate [Elm](http://elm-lang.org/) and to
present myself. The site is still under development, but by all means, have a
gander. Look at the source code
[here](https://github.com/SimSmith/SimSmith.github.io), if that is you butter.
"""


viewCounter : Model -> Html Msg
viewCounter model =
    div []
        [ text ("Confusion count: " ++ toString model.count)
        , br [] []
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
