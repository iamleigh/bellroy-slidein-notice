module Components.Button exposing (ButtonConfig, IconPosition(..), uiButton)

import Html exposing (Html, button, span, text)
import Html.Attributes exposing (attribute, class)
import Html.Events exposing (onClick)



-- TYPES


type IconPosition
    = IconLeft
    | IconRight


type alias ButtonConfig msg =
    { label : String
    , iconName : Maybe String
    , iconPosition : Maybe IconPosition
    , onClick : msg
    , classes : List String
    , disabled : Bool
    }



-- VIEW


uiButton : ButtonConfig msg -> Html msg
uiButton config =
    let
        -- Build the icon view if exists
        iconView : Maybe String -> Html string
        iconView maybeIconName =
            case maybeIconName of
                Just name ->
                    let
                        baseClass : String
                        baseClass =
                            "fa-solid fa-" ++ name

                        spinClass : String
                        spinClass =
                            if name == "spinner" then
                                "fa-spin"

                            else
                                ""
                    in
                    span
                        [ class (String.join " " [ baseClass, spinClass ])
                        , attribute "aria-hidden" "true"
                        ]
                        []

                Nothing ->
                    text ""

        -- Label view
        labelView : Html msg
        labelView =
            span [ class "button-label" ] [ text config.label ]

        -- Arrange icon + label according to position
        contents : List (Html msg)
        contents =
            case ( config.iconName, config.iconPosition ) of
                ( Just _, Just IconLeft ) ->
                    [ iconView config.iconName, labelView ]

                ( Just _, Just IconRight ) ->
                    [ labelView, iconView config.iconName ]

                ( Just _, Nothing ) ->
                    [ iconView config.iconName ]

                ( Nothing, _ ) ->
                    [ labelView ]

        -- Extra attributes for accessibility
        extraAttributes : List (Html.Attribute msg)
        extraAttributes =
            case ( config.iconName, config.iconPosition ) of
                ( Just _, Nothing ) ->
                    -- Icon only → add aria-label
                    [ attribute "aria-label" config.label ]

                _ ->
                    -- Normal button → no extra aria attributes
                    []

        -- Dynamically build the classes
        baseClasses : List String
        baseClasses =
            [ "bellroy-button" ]
                ++ (case ( config.iconName, config.iconPosition ) of
                        ( Just _, Nothing ) ->
                            [ "bellroy-button--icon" ]

                        _ ->
                            []
                   )
                ++ config.classes
    in
    button
        ([ class (String.join " " baseClasses)
         , onClick config.onClick
         ]
            ++ (if config.disabled then
                    [ Html.Attributes.disabled True ]

                else
                    []
               )
        )
        contents
