module Video exposing (youtubeVideo)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Encode


youtubeVideo : String -> Html msg
youtubeVideo url =
    iframe
        [ width 560
        , height 315
        , src (url ++ "?modestbranding=1;controls=0;showinfo=0;rel=0")
        ]
        []
