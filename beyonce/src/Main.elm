module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (Html, a, div, hr, li, text, ul)
import Html.Attributes exposing (href, id)
import Html.Events exposing (onClick)
import Page.About as AboutPage
import Page.Albums as AlbumsPage exposing (Album)
import Page.Home as HomePage
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
    | Albums (List Album)


testAlbums : List Album
testAlbums =
    [ { name = "Lemonade"
      , thumbnail = "http://is1.mzstatic.com/image/thumb/Music20/v4/23/c1/9e/23c19e53-783f-ae47-7212-03cc9998bd84/source/100x100bb.jpg"
      , releaseDate = "2016-04-25T07:00:00Z"
      , video = "https://www.youtube.com/embed/PeonBmeFR8o?rel=0&amp;controls=0&amp;showinfo=0"
      }
    , { name = "Dangerously In Love"
      , thumbnail = "http://is1.mzstatic.com/image/thumb/Music/v4/18/93/6d/18936d85-8f6b-7597-87ef-62c4c5211298/source/100x100bb.jpg"
      , releaseDate = "2003-06-24T07:00:00Z"
      , video = "https://www.youtube.com/embed/ViwtNLUqkMY?rel=0&amp;controls=0&amp;showinfo=0"
      }
    ]



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
                                    Albums testAlbums
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
