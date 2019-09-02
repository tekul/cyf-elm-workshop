module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (Html, a, div, hr, li, text, ul)
import Html.Attributes exposing (href, id)
import Html.Events exposing (onClick)
import Route exposing (Route)
import Url exposing (Url)


type Msg
    = ChangedUrl Url --| Sent by the runtime when the url changes
    | ClickedLink Browser.UrlRequest --| Sent when we click a menu link to change the url


{-| For this simple case, we just use a model which stores the current page
-}
type Model
    = Model Nav.Key Page


type Page
    = Home
    | About
    | Albums



-- `init`, `update` and `view` are the three core functions required by the Elm
-- runtime. We supply implementations for these when defining our program
-- in the `main` function.


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    ( Model navKey Home, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ((Model navKey page) as model) =
    case msg of
        ChangedUrl url ->
            let
                newPage =
                    case Route.fromUrl url of
                        Nothing ->
                            page

                        Just route ->
                            case route of
                                Route.Home ->
                                    Home

                                Route.About ->
                                    About

                                Route.Albums ->
                                    Albums
            in
            ( Model navKey newPage, Cmd.none )

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl navKey (Url.toString url) )

                Browser.External url ->
                    ( model, Nav.load url )


view : Model -> Document Msg
view model =
    { title = "Beyonce"
    , body =
        [ viewNavbar
        , hr [] []
        , text (Debug.toString model)
        ]
    }


viewNavbar : Html Msg
viewNavbar =
    div []
        [ ul []
            (List.map viewLink
                [ ( Route.Home, "Beyonce" )
                , ( Route.About, "About" )
                , ( Route.Albums, "Albums" )
                ]
            )
        ]


viewLink : ( Route, String ) -> Html Msg
viewLink ( route, txt ) =
    let
        url =
            Route.routeToString route
    in
    li [] [ a [ href url ] [ text txt ] ]


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }
