module Components.Product exposing (view)

import Html exposing (Html, div, img, li, p, span, text)
import Html.Attributes exposing (alt, class, src)
import Models.Product exposing (Product)


view : Product -> Html msg
view product =
    li [ class "bellroy-product" ]
        [ div [ class "bellroy-product__image" ]
            (imageSection product)
        , p [ class "bellroy-product__name" ]
            [ text product.name ]
        , p [ class "bellroy-product__price" ]
            [ text ("$" ++ product.price) ]
        ]


imageSection : Product -> List (Html msg)
imageSection product =
    let
        baseImage =
            img
                [ src product.image
                , alt product.name
                , class "bellroy-product__img"
                ]
                []
    in
    if product.highlight then
        [ baseImage
        , span [ class "bellroy-product__tag" ] [ text "Value Set" ]
        ]
    else
        [ baseImage ]
