module Components.ButtonTest exposing (all)

import Components.Button exposing (IconPosition(..), uiButton)
import Expect
import Html.Events exposing (onClick)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (class, tag, text)


type DummyMsg
    = DummyClick


all : Test
all =
    describe "Components.Button"
        [ test "renders a button with label only" <|
            \_ ->
                let
                    view =
                        uiButton
                            { label = "Click Me"
                            , iconName = Nothing
                            , iconPosition = Nothing
                            , onClick = DummyClick
                            , classes = [ "my-button" ]
                            , disabled = False
                            }
                in
                Query.fromHtml view
                    |> Query.has
                        [ tag "button"
                        , class "bellroy-button"
                        , class "my-button"
                        , text "Click Me"
                        ]
        , test "renders a button with an icon on the left" <|
            \_ ->
                let
                    view =
                        uiButton
                            { label = "Download"
                            , iconName = Just "download"
                            , iconPosition = Just IconLeft
                            , onClick = DummyClick
                            , classes = [ "download-button" ]
                            , disabled = False
                            }
                in
                Query.fromHtml view
                    |> Query.has
                        [ tag "button"
                        , class "bellroy-button"
                        , class "download-button"
                        , tag "span"
                        , class "fa-solid"
                        , class "fa-download"
                        ]
        , test "renders a button with an icon on the right" <|
            \_ ->
                let
                    view =
                        uiButton
                            { label = "Next"
                            , iconName = Just "arrow-right"
                            , iconPosition = Just IconRight
                            , onClick = DummyClick
                            , classes = [ "next-button" ]
                            , disabled = False
                            }
                in
                Query.fromHtml view
                    |> Query.has
                        [ tag "button"
                        , class "bellroy-button"
                        , class "next-button"
                        , tag "span"
                        , class "fa-solid"
                        , class "fa-arrow-right"
                        ]
        , test "renders a button with only an icon and no label" <|
            \_ ->
                let
                    view =
                        uiButton
                            { label = "Dismiss"
                            , iconName = Just "xmark"
                            , iconPosition = Nothing
                            , onClick = DummyClick
                            , classes = [ "icon-button" ]
                            , disabled = False
                            }
                in
                Query.fromHtml view
                    |> Query.has
                        [ tag "button"
                        , class "bellroy-button"
                        , class "bellroy-button--icon"
                        , class "icon-button"
                        , tag "span"
                        , class "fa-solid"
                        , class "fa-xmark"
                        ]
        ]
