module Layouts.Body exposing (view)

import Html exposing (Html, button, div, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


view : msg -> Bool -> Html msg
view showNoticeMsg noticeVisible =
    div [ class "bellroy-body" ]
        [ p [] [ text "Welcome to Bellroy! We craft slim wallets, stylish bags, and accessories to help you move smarter through the world." ]
        , button
            [ class "show-notice-button"
            , onClick showNoticeMsg
            , Html.Attributes.disabled noticeVisible
            ]
            [ text "Show Notice Again" ]
        ]
