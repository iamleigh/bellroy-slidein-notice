module Components.SlideInNotice exposing
    ( Config
    , Msg(..)
    , SlideInNoticeModel
    , slideInNoticeInit
    , slideInNoticeUpdate
    , slideInNoticeView
    )

import Components.Button as Button
import Components.Input as Input
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)



-- CONFIG


type alias Config =
    { title : String
    , placeholder : String
    , submitText : String
    , privacyText : Maybe (List (Html Msg))
    }



-- MODEL


type alias SlideInNoticeModel =
    { visible : Bool
    , email : String
    }


slideInNoticeInit : SlideInNoticeModel
slideInNoticeInit =
    { visible = True
    , email = ""
    }



-- UPDATE


type Msg
    = DismissNotice
    | UpdateEmail String
    | SubmitEmail


slideInNoticeUpdate : Msg -> SlideInNoticeModel -> SlideInNoticeModel
slideInNoticeUpdate msg model =
    case msg of
        DismissNotice ->
            { model | visible = False }

        UpdateEmail newEmail ->
            { model | email = newEmail }

        SubmitEmail ->
            -- You could later do something smarter, like send the email somewhere
            { model | email = "" }



-- VIEW


slideInNoticeView : Config -> SlideInNoticeModel -> Html Msg
slideInNoticeView config model =
    if model.visible then
        div [ class "slide-in-notice" ]
            [ -- Dismiss button
              Button.uiButton
                { label = "Close Notice"
                , iconName = Just "xmark"
                , iconPosition = Nothing
                , onClick = DismissNotice
                , classes = [ "dismiss-button" ]
                }

            -- Title
            , div [ class "notice-title" ] [ text config.title ]

            -- Input and submit
            , div [ class "notice-form" ]
                [ Input.input
                    { inputType = "email"
                    , placeholderText = config.placeholder
                    , value = model.email
                    , onInput = UpdateEmail
                    , classes = [ "email-input" ]
                    }
                , Button.uiButton
                    { label = config.submitText
                    , iconName = Nothing
                    , iconPosition = Nothing
                    , onClick = SubmitEmail
                    , classes = [ "submit-button" ]
                    }
                ]

            -- Privacy note (only if it exists)
            , case config.privacyText of
                Just privacyContent ->
                    div [ class "privacy-text" ] privacyContent

                Nothing ->
                    Html.text ""
            ]

    else
        Html.text ""
