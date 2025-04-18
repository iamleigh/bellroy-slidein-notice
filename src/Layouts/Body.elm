module Layouts.Body exposing (view)

import Html exposing (Html, button, div, p, text)
import Html.Attributes exposing (class, disabled)
import Html.Events exposing (onClick)
import Components.Products exposing (viewList)
import Models.Product exposing (Product)


view : List Product -> msg -> Bool -> Html msg
view products showNoticeMsg noticeVisible =
    div [ class "bellroy-body" ]
        [ p []
            [ text "Welcome to Bellroy! We craft slim wallets, stylish bags, and accessories to help you move smarter through the world." ]

        , viewList products

        , button
            [ class "bellroy-button"
            , onClick showNoticeMsg
            , disabled noticeVisible
            ]
            [ text "Show Notice Again" ]
        ]
