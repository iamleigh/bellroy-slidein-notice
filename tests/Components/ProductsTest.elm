module Components.ProductsTest exposing (all)

import Components.Products exposing (viewList)
import Models.Product exposing (Product)
import Test exposing (Test, describe, test)
import Expect
import Html
import Test.Html.Query as Query
import Test.Html.Selector exposing (class, tag, text)


all : Test
all =
    describe "Components.Products"
        [ test "renders loading text when product list is empty" <|
            \_ ->
                let
                    view : Html.Html msg
                    view =
                        viewList []
                in
                Query.fromHtml view
                    |> Query.has
                        [ tag "p"
                        , text "Loading products..."
                        ]
        , test "renders a list of products" <|
            \_ ->
                let
                    view : Html.Html msg
                    view =
                        viewList
                            [ { name = "Wallet", price = "79.00", highlight = False, image = "/images/wallet.jpg" }
                            , { name = "Backpack", price = "199.00", highlight = True, image = "/images/backpack.jpg" }
                            ]
                in
                Query.fromHtml view
                    |> Query.has
                        [ tag "ul"
                        , class "bellroy-products" -- ✅ Correctly closed now
                        ]
        ]
