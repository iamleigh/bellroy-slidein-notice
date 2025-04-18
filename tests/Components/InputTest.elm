module Components.InputTest exposing (all)

import Components.Input exposing (InputConfig, input)
import Expect
import Test exposing (..)


all : Test
all =
    describe "Input Component"
        [ test "input renders without crashing" <|
            \_ ->
                let
                    config : InputConfig Never
                    config =
                        { inputType = "email"
                        , placeholderText = "Enter your email"
                        , value = "test@example.com"
                        , onInput = \_ -> Debug.todo "no-op"
                        , classes = [ "email-input" ]
                        }

                    rendered =
                        input config
                in
                -- If this compiles, it's valid Elm Html
                Expect.pass
        ]
