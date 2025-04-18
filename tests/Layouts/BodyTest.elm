module Layouts.BodyTest exposing (all)

import Components.Products exposing (viewList)
import Html exposing (text)
import Html.Attributes
import Layouts.Body exposing (view)
import Models.Product exposing (Product)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag, text)


type DummyMsg
    = DummyClick


all : Test
all =
    describe "Layouts.Body"
        [ test "renders welcome text and show notice button" <|
            \_ ->
                let
                    viewHtml =
                        view [] DummyClick False
                in
                Query.fromHtml viewHtml
                    |> Query.has
                        [ tag "div"
                        , Selector.class "bellroy-body"
                        ]
        , test "renders products list when provided" <|
            \_ ->
                let
                    products =
                        [ { name = "Slim Sleeve Wallet", price = "79.00", highlight = False, image = "/images/slim.png" }
                        , { name = "Note Sleeve Wallet", price = "89.00", highlight = True, image = "/images/note.png" }
                        ]

                    viewHtml =
                        view products DummyClick False
                in
                Query.fromHtml viewHtml
                    |> Query.has
                        [ tag "ul"
                        , Selector.class "bellroy-products"
                        ]
        , test "renders disabled button when noticeVisible is True" <|
            \_ ->
                let
                    viewHtml =
                        view [] DummyClick True
                in
                Query.fromHtml viewHtml
                    |> Query.has
                        [ tag "button"
                        , Selector.class "bellroy-button"
                        ]
        ]
