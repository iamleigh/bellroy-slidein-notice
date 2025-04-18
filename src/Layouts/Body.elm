module Layouts.Body exposing (view)

import Html exposing (Html, button, div, p, text)
import Html.Attributes exposing (class, disabled)
import Html.Events exposing (onClick)
import Models.Product exposing (Product)


-- VIEW


view : List Product -> msg -> Bool -> Html msg
view products showNoticeMsg noticeVisible =
    div [ class "bellroy-body" ]
        [ div [ class "products" ]
            (List.map viewProduct products)

        , p []
            [ text "Welcome to Bellroy! We craft slim wallets, stylish bags, and accessories to help you move smarter through the world." ]

        , button
            [ class "bellroy-button"
            , onClick showNoticeMsg
            , disabled noticeVisible
            ]
            [ text "Show Notice Again" ]
        ]


viewProduct : Product -> Html msg
viewProduct product =
    div [ class "product-item" ]
        [ p [] [ text product.name ]
        , p [] [ text ("$" ++ product.price) ]
        ]
