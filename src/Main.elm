module Main exposing (main)

import Browser
import Html exposing (Html, div, text)

main : Program () () ()
main =
    Browser.sandbox
        { init = ()
        , update = \_ model -> model
        , view = \_ -> div [] [ text "Hello, Bellroy!" ]
        }
