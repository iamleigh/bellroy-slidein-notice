module Layouts.Body exposing (view)

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)


view : Html msg
view =
    div [ class "bellroy-body" ]
        [ p [] [ text "Welcome to Bellroy! We craft slim wallets, stylish bags, and accessories to help you move smarter through the world." ]
        ]
