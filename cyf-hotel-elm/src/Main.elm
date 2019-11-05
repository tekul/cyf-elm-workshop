module Main exposing (main, subscriptions)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Booking =
    { id : Int
    , title : String
    , firstName : String
    , surname : String
    , email : String
    , roomId : Int
    }


type alias Model =
    { search : String
    , bookings : List Booking
    }


type Msg
    = NoOp


init : () -> ( Model, Cmd Msg )
init _ =
    let
        hardCodedBookings =
            [ Booking 1 "Mr" "Mozafar" "Smith" "msmith@cyf-hotel.com" 2
            , Booking 2 "Ms" "Mimi" "Haider" "mhaider@cyf-hotel.com" 5
            , Booking 3 "Ms" "Meriem" "Mcleod" "mmcleod@cyf-hotel.com" 8
            ]
    in
    ( Model "" hardCodedBookings, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ header [ class "h-12 p-3 bg-gray-900 font-bold text-xl text-white tracking-wide" ] [ text "CYF Hotel" ]
        , div [ class "container mx-auto bg-gray-100 pt-3" ]
            [ viewSearchForm
            ]
        ]


viewSearchForm : Html msg
viewSearchForm =
    div [ class "w-full md:w-2/3" ]
        [ h1 [ class "text-2xl font-medium" ] [ text "Search bookings" ]
        , Html.form [ class "mt-2" ]
            [ label [ class "block text-gray-700 font-medium mb-2", for "customerName" ] [ text "Customer name" ]
            , div [ class "flex" ]
                [ input [ id "customerName", class "shadow border rounded w-full py-2 px-3 mr-2 text-gray-700 leading-tight focus:outline-none focus:shadow-outline", type_ "text", placeholder "Customer name" ] []
                , button [ class "bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow" ] [ text "Search" ]
                ]
            ]
        ]


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
