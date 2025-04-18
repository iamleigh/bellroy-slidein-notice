module Components.SlideInNotice exposing
    ( SlideInNoticeModel
    , Config
    , Msg(..)
    , slideInNoticeInit
    , slideInNoticeUpdate
    , slideInNoticeView
    )

import Html exposing (Html, button, div, input, span, text)
import Html.Attributes exposing (class, placeholder, type_, value)
import Html.Events exposing (onClick, onInput)


-- CONFIG

type alias Config =
    { title : String
    , placeholder : String
    , submitText : String
    , privacyText : List (Html Msg)
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
              button [ class "dismiss-button", onClick DismissNotice ] [ text "×" ]

              -- Title
            , div [ class "notice-title" ] [ text config.title ]

              -- Input and submit
            , div [ class "notice-form" ]
                [ input
                    [ class "email-input"
                    , type_ "email"
                    , placeholder config.placeholder
                    , value model.email
                    , onInput UpdateEmail
                    ]
                    []
                , button [ class "submit-button", onClick SubmitEmail ] [ text config.submitText ]
                ]

              -- Privacy note
            , div [ class "privacy-text" ] config.privacyText
            ]
    else
        Html.text ""
