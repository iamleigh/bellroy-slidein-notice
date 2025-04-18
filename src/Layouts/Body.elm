module Layouts.Body exposing (view)

import Html exposing (Html, div, button, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


view : msg -> Html msg
view showNoticeMsg =
    div [ class "bellroy-body" ]
        [ p [] [ text "Welcome to Bellroy! We craft slim wallets, stylish bags, and accessories to help you move smarter through the world." ]
        , button
            [ class "show-notice-button"
            , onClick showNoticeMsg
            ]
            [ text "Show Notice Again" ]
        ]
