module Route exposing (Route(..), fromUrl, routeToString)

import Browser.Navigation as Nav
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, int, oneOf, s, string)


{-| Routes supported by the app.
-}
type Route
    = Home
    | About
    | Albums


{-| Called when the browser Url changes to obtain the corresponding Route.
-}
fromUrl : Url -> Maybe Route
fromUrl url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Parser.parse parser


parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map Home Parser.top
        , Parser.map About (s "about")
        , Parser.map Albums (s "albums")
        ]


{-| Render links from Routes
-}
routeToString : Route -> String
routeToString r =
    case r of
        Home ->
            "#/"

        About ->
            "#/about"

        Albums ->
            "#/albums"
