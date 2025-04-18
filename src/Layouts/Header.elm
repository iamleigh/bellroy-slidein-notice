module Layouts.Header exposing (view)

import Html exposing (Html, div, img)
import Html.Attributes exposing (alt, class, src)


view : Html msg
view =
    div [ class "bellroy-header" ]
        [ img
            [ src "/images/bellroy-logo.svg"
            , alt "Bellroy Logo"
            , class "bellroy-logo"
            ]
            []
        ]
