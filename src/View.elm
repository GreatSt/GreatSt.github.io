module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Material
import Material.Button as Button
import Material.Options as Options exposing (css)
import Material.Layout as Layout
import Material.Color as Color
import Model exposing (..)
import UpdateMsg exposing (..)


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
        , tabs = ( [ text "Main", text "Extra" ], [ Color.background (Color.color Color.DeepOrange Color.S400) ] )
        , main = [ viewBody model ]
        }


viewBody : Model -> Html Msg
viewBody model =
    case model.selectedTab of
        0 ->
            viewCounter model

        1 ->
            h1 [ style [ ( "margin", "0 24px" ) ] ] [ text "To be continued..." ]

        _ ->
            text "404"


viewCounter : Model -> Html Msg
viewCounter model =
    div
        [ style [ ( "padding", "2rem" ) ] ]
        [ h1 [] [ text "Welcome to this humble page." ]
        , text ("Confusion count: " ++ toString model.count)

        {- We construct the instances of the Button component that we need, one
           for the increase button, one for the reset button. First, the increase
           button. The first three arguments are:

             - A Msg constructor (`Mdl`), lifting Mdl messages to the Msg type.
             - An instance id (the `[0]`). Every component that uses the same model
               collection (model.mdl in this file) must have a distinct instance id.
             - A reference to the elm-mdl model collection (`model.mdl`).

           Notice that we do not have to add fields for the increase and reset buttons
           separately to our model; and we did not have to add to our update messages
           to handle their internal events.

           Mdl components are configured with `Options`, similar to `Html.Attributes`.
           The `Options.onClick Increase` option instructs the button to send the `Increase`
           message when clicked. The `css ...` option adds CSS styling to the button.
           See `Material.Options` for details on options.
        -}
        , Button.render Mdl
            [ 0 ]
            model.mdl
            [ Options.onClick Increase
            , css "margin" "0 24px"
            ]
            [ text "Increase" ]
        , Button.render Mdl
            [ 1 ]
            model.mdl
            [ Options.onClick Reset ]
            [ text "Reset" ]
        ]
