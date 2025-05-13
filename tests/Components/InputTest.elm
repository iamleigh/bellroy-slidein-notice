module Components.InputTest exposing (all)

import Components.Input exposing (input)
import Expect
import Html
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (class, tag, disabled)


all : Test
all =
    describe "Components.Input"
        [ test "renders enabled input with correct classes" <|
            \_ ->
                let
                    view : Html.Html String
                    view =
                        input
                            { inputType = "email"
                            , placeholderText = "Enter your email"
                            , value = "test@example.com"
                            , onInput = identity
                            , classes = [ "custom-input" ]
                            , disabled = False
                            }
                in
                Query.fromHtml view
                    |> Query.has
                        [ tag "input"
                        , class "bellroy-input"
                        , class "custom-input"
                        , disabled False
                        ]

        , test "renders disabled input" <|
            \_ ->
                let
                    view : Html.Html String
                    view =
                        input
                            { inputType = "email"
                            , placeholderText = "Disabled input"
                            , value = "disabled"
                            , onInput = identity
                            , classes = []
                            , disabled = True
                            }
                in
                Query.fromHtml view
                    |> Query.has
                        [ tag "input"
                        , class "bellroy-input"
                        , disabled True
                        ]
        ]
