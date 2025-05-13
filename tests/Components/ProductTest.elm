module Components.ProductTest exposing (all)

import Components.Product exposing (view)
import Expect
import Html exposing (Html)
import Models.Product exposing (Product)
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (class, tag, text)


all : Test
all =
    describe "Components.Product"
        [ test "renders product without highlight" <|
            \_ ->
                let
                    product : Product
                    product =
                        { name = "Slim Sleeve Wallet"
                        , price = "$79.00"
                        , image = "/images/slim-sleeve.png"
                        , highlight = False
                        }

                    rendered : Html msg
                    rendered = view product
                in
                Query.fromHtml rendered
                    |> Query.has
                        [ tag "li"
                        , class "bellroy-products__item"
                        , tag "img"
                        , class "bellroy-product__img"
                        , tag "p"
                        , class "bellroy-product__name"
                        , text "Slim Sleeve Wallet"
                        , class "bellroy-product__price"
                        , text "$79.00"
                        ]
        , test "renders product with highlight (Value Set tag)" <|
            \_ ->
                let
                    product : Product
                    product =
                        { name = "Note Sleeve Wallet"
                        , price = "$89.00"
                        , image = "/images/note-sleeve.png"
                        , highlight = True
                        }

                    rendered : Html msg
                    rendered = view product
                in
                Query.fromHtml rendered
                    |> Query.has
                        [ tag "li"
                        , class "bellroy-products__item"
                        , tag "img"
                        , class "bellroy-product__img"
                        , tag "p"
                        , class "bellroy-product__name"
                        , text "Note Sleeve Wallet"
                        , class "bellroy-product__price"
                        , text "$89.00"
                        , tag "span"
                        , class "bellroy-product__tag"
                        , text "Value Set"
                        ]
        ]
