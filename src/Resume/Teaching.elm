module Resume.Teaching exposing (..)

import Animation
import Html exposing (..)
import Html.Attributes exposing (style)
import Material.Button as Button
import Material.Grid exposing (..)
import Material.Options as Options exposing (css)
import Resume.ModelMsg exposing (..)


update : TeachJob -> Model -> ( Model, Cmd Msg )
update job model =
    ( { model | chosenCard = Teach job }, Cmd.none )


subscriptions : Model -> (Msg -> m) -> Sub m
subscriptions model msgFn =
    Sub.map msgFn <|
        Animation.subscription Animate
            [ model.style.intize.text
            , model.style.si.text
            ]


overview : Model -> Html Msg
overview model =
    div []
        [ backButton model
        , grid []
            [ intizeCell model
            , siCell model
            , galarenCell model
            ]
        ]


backButton : Model -> Html Msg
backButton model =
    grid []
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
            [ Button.render
                MdlMsg
                [ 3 ]
                model.mdl
                [ Options.onClick <| ShowMore None
                , Button.raised
                ]
                [ text "Back" ]
            ]
        ]


intizeCell : Model -> Cell Msg
intizeCell model =
    let
        card1 =
            [ h4 [] [ text "Intize, Gothenburg" ]
            , p [] [ text "October 2016 – May 2017" ]
            , h5 [] [ text "Intize Mentor" ]
            , p [ style [ ( "color", "#AAAAAA" ) ] ]
                [ text "(press me)" ]
            ]

        card content =
            cell
                ([ size All 4
                 , offset Desktop 4
                 , offset Tablet 2
                 , Options.onClick <| FancyAnim Intize
                 , css "text-sizing" "border-box"
                 , css "overflow" "auto"
                 , css "background-color" "#DDDDE5"
                 , css "padding-left" "8px"
                 , css "padding-top" "10px"
                 , css "text-align" "center"
                 ]
                    ++ List.map (Options.attribute)
                        (Animation.render model.style.intize.card)
                )
                [ content ]

        card2 period place role body =
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
    in
        card <|
            div (Animation.render model.style.intize.text) <|
                case model.chosenCard of
                    Teach Intize ->
                        card2 "October 2016 – May 2017"
                            "Intize, Gothenburg"
                            "Intize Mentor"
                        <|
                            "Intize is a non-profit organisation that provides mentorship "
                                ++ "in mathematics. I am one of these voluntary mentors "
                                ++ "and together we work towards a more educated world."

                    _ ->
                        card1


siCell : Model -> Cell Msg
siCell model =
    let
        card1 =
            [ h4 [] [ text "Chalmers University of Technology, Gothenburg" ]
            , p [] [ text "August 2014 – November 2014" ]
            , h5 [] [ text "Supplementary Instructor (SI leader)" ]
            , p [ style [ ( "color", "#AAAAAA" ) ] ]
                [ text "(press me)" ]
            ]

        card content =
            cell
                ([ size All 4
                 , offset Desktop 4
                 , offset Tablet 2
                 , Options.onClick <| FancyAnim SI
                 , css "text-sizing" "border-box"
                 , css "overflow" "auto"
                 , css "background-color" "#DDDDE5"
                 , css "padding-left" "8px"
                 , css "padding-top" "10px"
                 , css "text-align" "center"
                 ]
                    ++ List.map (Options.attribute)
                        (Animation.render model.style.si.card)
                )
                [ content ]

        card2 period place role body =
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
    in
        card <|
            div (Animation.render model.style.si.text) <|
                case model.chosenCard of
                    Teach SI ->
                        card2 "August 2014 – November 2014"
                            "Chalmers University of Technology, Gothenburg"
                            "Supplementary Instructor (SI leader)"
                        <|
                            "A leader of SI (supplemental instruction) in linear algebra "
                                ++ "at Chalmers."

                    _ ->
                        card1


galarenCell : Model -> Cell Msg
galarenCell model =
    let
        card content =
            cell
                ([ size All 4
                 , offset Desktop 4
                 , offset Tablet 2
                 , Options.onClick <| SwitchText Galaren
                 , css "text-sizing" "border-box"
                 , css "overflow" "auto"
                 , css "background-color" "#DDDDE5"
                 , css "padding-left" "8px"
                 , css "padding-top" "10px"
                 , css "text-align" "center"
                 ]
                )
                [ content ]

        card1 =
            [ h4 [] [ text "Galären (AcadeMedia Fria Grundskolor), Karskrona" ]
            , p [] [ text "April 2013 – May 2013" ]
            , h5 [] [ text "Programming teacher" ]
            , p [ style [ ( "color", "#AAAAAA" ) ] ]
                [ text "(press me)" ]
            ]

        card2 period place role body =
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
    in
        card <|
            div [] <|
                case model.chosenCard of
                    Teach Galaren ->
                        card2 "April 2013 – May 2013"
                            "Galären (AcadeMedia Fria Grundskolor), Karskrona"
                            "Programming teacher"
                        <|
                            "Teaching programming to curious kids from 12 to 16 years "
                                ++ "old. Got recommended by a math teacher as a talented "
                                ++ "guy and someone with spare time. All the pupils wished "
                                ++ "to try programming as a voluntary subject in the end "
                                ++ "of the school year and I made that possible."

                    _ ->
                        card1
