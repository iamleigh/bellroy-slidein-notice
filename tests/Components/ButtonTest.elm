module Components.ButtonTest exposing (all)

import Components.Button exposing (IconPosition(..), uiButton)
import Expect
import Html.Attributes
import Html.Events
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (class, tag, text)


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
                            }
                in
                Query.fromHtml view
                    |> Query.has
                        [ tag "button"
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
                            }
                in
                Query.fromHtml view
                    |> Query.has
                        [ tag "button"
                        , class "download-button"
                        , tag "span"
                        , class "fa-solid"
                        , class "fa-xs"
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
                            }
                in
                Query.fromHtml view
                    |> Query.has
                        [ tag "button"
                        , class "next-button"
                        , tag "span"
                        , class "fa-solid"
                        , class "fa-xs"
                        , class "fa-arrow-right"
                        ]
        , test "renders a button with only an icon and no label" <|
            \_ ->
                let
                    view =
                        uiButton
                            { label = ""
                            , iconName = Just "xmark"
                            , iconPosition = Nothing
                            , onClick = DummyClick
                            , classes = [ "icon-button" ]
                            }
                in
                Query.fromHtml view
                    |> Query.has
                        [ tag "button"
                        , class "icon-button"
                        , tag "span"
                        , class "fa-solid"
                        , class "fa-xs"
                        , class "fa-xmark"
                        ]
        ]



-- Dummy message for simulating button clicks


type DummyMsg
    = DummyClick
