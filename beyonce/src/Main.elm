module Main exposing (main)

import Html exposing (Html, a, div, hr, li, program, text, ul)
import Html.Attributes exposing (href, id)
import Html.Events exposing (onClick)
import Navigation exposing (..)
import Routing as Routing exposing (Route)


type Msg
    = UrlChange Location --| Sent by the runtime when the url changes
    | NewUrl String --| Sent when we click a menu link to change the url


{-| For this simple case, we just use a model which stores the current page
-}
type Model
    = Home
    | About
    | Albums



-- `init`, `update` and `view` are the three core functions required by the Elm
-- runtime. We supply implementations for these when defining our program
-- in the `main` function.


init : Location -> ( Model, Cmd Msg )
init _ =
    ( Home, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange l ->
            case Routing.parseLocation l of
                Routing.NotFound ->
                    ( model, Cmd.none )

                Routing.Home ->
                    ( Home, Cmd.none )

                Routing.About ->
                    ( About, Cmd.none )

                Routing.Albums ->
                    ( Albums, Cmd.none )

        NewUrl url ->
            ( model, Navigation.newUrl url )


view : Model -> Html Msg
view model =
    div [ id "root" ]
        [ viewNavbar
        , hr [] []
        , text (toString model)
        ]


viewNavbar : Html Msg
viewNavbar =
    div []
        [ ul []
            (List.map viewLink
                [ ( Routing.Home, "Beyonce" )
                , ( Routing.About, "About" )
                , ( Routing.Albums, "Albums" )
                ]
            )
        ]


viewLink : ( Route, String ) -> Html Msg
viewLink ( route, txt ) =
    let
        url =
            Routing.routeToUrl route
    in
    li [] [ a [ href url, onClick (NewUrl url) ] [ text txt ] ]


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = view
        }
