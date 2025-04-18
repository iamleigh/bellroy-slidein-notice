module Layouts.Header exposing (view)

import Html exposing (Html, div, img)
import Html.Attributes exposing (class, src, alt)


view : Html msg
view =
    div [ class "bellroy-header" ]
        [ img
            [ src "/assets/images/bellroy-logo.svg"
            , alt "Bellroy Logo"
            , class "bellroy-logo"
            ]
            []
        ]
