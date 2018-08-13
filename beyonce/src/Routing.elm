module Routing exposing (Route(..), parseLocation, routeToUrl)

import Navigation exposing (Location)
import UrlParser as Url exposing (s)


{-| Routes supported by the app.

NotFound takes care of the case where the user types an invalid path
in the address bar and it cannot be parsed into one of the supported
Routes. Otherwise we would be forced to return `Maybe Route` from
`parseLocation`.

-}
type Route
    = Home
    | About
    | Albums
    | NotFound


{-| Called when the browser location changes to obtain the correspoding Route.

We use the hash portion of the URL, but it is also possible to use `parsePath`.
If we do that though, we also need to make sure that our `onClick` events for
setting a new URL are also configured to prevent the browser's default
behaviour of sending a new request to the server.

-}
parseLocation : Location -> Route
parseLocation location =
    case Url.parseHash route location of
        Just route ->
            route

        Nothing ->
            NotFound


route : Url.Parser (Route -> a) a
route =
    Url.oneOf
        [ Url.map Home Url.top
        , Url.map About (s "about")
        , Url.map Albums (s "albums")
        ]


{-| Render links from Routes
-}
routeToUrl : Route -> String
routeToUrl r =
    case r of
        Home ->
            "#/"

        About ->
            "#/about"

        Albums ->
            "#/albums"

        NotFound ->
            "/not_found_shouldnt_happen"
