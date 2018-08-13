module Page.Albums exposing (Album, view)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Album =
    { name : String
    , thumbnail : String
    , releaseDate : String
    , video : String
    }


view : List Album -> Html msg
view albums =
    section []
        [ h1 [] [ text "Albums" ]
        , div []
            (List.map viewAlbum albums)
        ]


viewAlbum : Album -> Html msg
viewAlbum a =
    div []
        [ h2 [] [ text a.name ]
        , img [ src a.thumbnail ] []
        , p [] [ text ("Release date: " ++ a.releaseDate) ]
        , hr [] []
        ]
