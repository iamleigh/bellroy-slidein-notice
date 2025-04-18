module Components.Products exposing (viewList)

import Components.Product exposing (view)
import Html exposing (Html, p, text, ul)
import Html.Attributes exposing (class)
import Models.Product exposing (Product)


viewList : List Product -> Html msg
viewList products =
    if List.isEmpty products then
        p [] [ text "Loading products..." ]

    else
        ul [ class "bellroy-products" ]
            (List.map view products)
