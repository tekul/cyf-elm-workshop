module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (Html, a, div, hr, li, text, ul)
import Html.Attributes exposing (href, id)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Json
import Page.About as AboutPage
import Page.Albums as AlbumsPage exposing (Album, decodeAlbum)
import Page.Home as HomePage
import Route exposing (Route)
import Url exposing (Url)


type Msg
    = ChangedUrl Url --| Sent by the runtime when the url changes
    | ClickedLink Browser.UrlRequest --| Sent when we click a menu link to change the url
    | AlbumsLoaded (Result Http.Error (List Album))


{-| For this simple case, we just use a model which stores the current page
-}
type Model
    = Model Nav.Key Page


type Page
    = Home
    | About
    | Albums (List Album)



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
            case Route.fromUrl url of
                Nothing ->
                    ( model, Cmd.none )

                Just route ->
                    case route of
                        Route.Home ->
                            ( Model navKey Home, Cmd.none )

                        Route.About ->
                            ( Model navKey About, Cmd.none )

                        Route.Albums ->
                            ( Model navKey (Albums []), fetchAlbums )

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl navKey (Url.toString url) )

                Browser.External url ->
                    ( model, Nav.load url )

        AlbumsLoaded result ->
            case page of
                Albums _ ->
                    case result of
                        Ok albums ->
                            ( Model navKey (Albums albums), Cmd.none )

                        Err _ ->
                            ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )


albumsUrl : String
albumsUrl =
    "https://rawgit.com/rarmatei/f5ae92ac93d9716affab822a3f54f95b/raw/e62641b3f5ddd12c4fe34aa0912488224594e5a7/beyonce-albums.json"


fetchAlbums : Cmd Msg
fetchAlbums =
    Http.get
        { url = albumsUrl
        , expect = Http.expectJson AlbumsLoaded (Json.list decodeAlbum)
        }


view : Model -> Document Msg
view model =
    { title = "Beyonce"
    , body =
        [ viewNavbar
        , hr [] []
        , viewPage model
        ]
    }


viewPage : Model -> Html msg
viewPage ((Model _ page) as model) =
    case page of
        Home ->
            HomePage.view

        About ->
            AboutPage.view

        Albums albums ->
            AlbumsPage.view albums


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
