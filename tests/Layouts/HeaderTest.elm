module Layouts.HeaderTest exposing (all)

import Expect
import Html.Attributes
import Layouts.Header exposing (view)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag, attribute)


all : Test
all =
    describe "Layouts.Header"
        [ test "renders a header with Bellroy logo" <|
            \_ ->
                Query.fromHtml view
                    |> Query.has
                        [ tag "div"
                        , Selector.class "bellroy-header"
                        , tag "img"
                        , Selector.class "bellroy-header__logo"
                        , attribute (Html.Attributes.alt "Bellroy Logo")
                        , attribute (Html.Attributes.src "/images/bellroy-logo.svg")
                        ]
        ]
