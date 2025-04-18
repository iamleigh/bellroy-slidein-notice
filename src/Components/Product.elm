module Components.Product exposing (viewProduct)

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Models.Product exposing (Product)


viewProduct : Product -> Html msg
viewProduct product =
    div [ class "bellroy-product" ]
        [ p [] [ text product.name ]
        , p [] [ text (product.price) ]
        ]
