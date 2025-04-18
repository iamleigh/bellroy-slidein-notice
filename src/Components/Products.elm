module Components.Products exposing (viewList)

import Html exposing (Html, ul, p, text)
import Html.Attributes exposing (class)
import Models.Product exposing (Product)
import Components.Product exposing (view)


viewList : List Product -> Html msg
viewList products =
    if List.isEmpty products then
        p [] [ text "Loading products..." ]
    else
        ul [ class "bellroy-products" ]
            (List.map view products)
