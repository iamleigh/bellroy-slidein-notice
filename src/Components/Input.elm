module Components.Input exposing (InputConfig, input)

import Html exposing (Html, input)
import Html.Attributes exposing (class, disabled, placeholder, type_, value)
import Html.Events exposing (onInput)



-- TYPES


type alias InputConfig msg =
    { inputType : String
    , placeholderText : String
    , value : String
    , onInput : String -> msg
    , classes : List String
    , disabled : Bool
    }



-- VIEW


input : InputConfig msg -> Html msg
input config =
    Html.input
        [ class (String.join " " ("bellroy-input" :: config.classes))
        , type_ config.inputType
        , placeholder config.placeholderText
        , value config.value
        , onInput config.onInput
        , disabled config.disabled
        ]
        []
