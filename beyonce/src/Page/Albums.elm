module Page.Albums exposing (Album, decodeAlbum, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode exposing (Decoder, field, map4, string)
import Video exposing (youtubeVideo)


type alias Album =
    { name : String
    , thumbnail : String
    , releaseDate : String
    , video : String
    }


decodeAlbum : Decoder Album
decodeAlbum =
    map4 Album
        (field "collectionName" string)
        (field "artworkUrl100" string)
        (field "releaseDate" string)
        (field "url" string)


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
        , youtubeVideo a.video
        , hr [] []
        ]
