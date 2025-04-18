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
import Html.Attributes exposing (attribute, class, tabindex)
import Html.Events exposing (onClick)
import Process
import Task



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
    , animating : Bool
    , removed : Bool
    , animationClass : String
    }


slideInNoticeInit : SlideInNoticeModel
slideInNoticeInit =
    { visible = False
    , email = ""
    , animating = False
    , removed = True -- Start fully removed
    , animationClass = ""
    }



-- UPDATE


type Msg
    = ShowNotice
    | DismissNotice
    | FinishExitAnimation
    | UpdateEmail String
    | SubmitEmail


slideInNoticeUpdate : Msg -> SlideInNoticeModel -> ( SlideInNoticeModel, Cmd Msg )
slideInNoticeUpdate msg model =
    case msg of
        ShowNotice ->
            ( { model
                | visible = True
                , animating = True
                , removed = False
                , animationClass = "animate__animated animate__slideInUp"
              }
            , Cmd.none
            )

        DismissNotice ->
            ( { model
                | animating = True
                , animationClass = "animate__animated animate__slideOutDown"
              }
            , delayFinishExit
            )

        FinishExitAnimation ->
            ( { model
                | visible = False
                , animating = False
                , removed = True
                , animationClass = ""
              }
            , Cmd.none
            )

        UpdateEmail newEmail ->
            ( { model | email = newEmail }, Cmd.none )

        SubmitEmail ->
            ( { model | email = "" }, Cmd.none )


delayFinishExit : Cmd Msg
delayFinishExit =
    Task.perform (\_ -> FinishExitAnimation) (Process.sleep 500)



-- VIEW


slideInNoticeView : Config -> SlideInNoticeModel -> Html Msg
slideInNoticeView config model =
    if model.removed then
        Html.text ""

    else
        div
            [ class ("slide-in-notice " ++ model.animationClass)
            , attribute "role" "alert"
            , attribute "aria-live" "assertive"
            , tabindex -1
            ]
            [ dismissButton
            , noticeTitle config.title
            , noticeForm config model
            , maybePrivacyText config.privacyText
            ]


dismissButton : Html Msg
dismissButton =
    Button.uiButton
        { label = "Dismiss Notification"
        , iconName = Just "xmark"
        , iconPosition = Nothing
        , onClick = DismissNotice
        , classes = [ "bellroy-button--float" ]
        }


noticeTitle : String -> Html Msg
noticeTitle titleText =
    div [ class "notice-title" ]
        [ text titleText ]


noticeForm : Config -> SlideInNoticeModel -> Html Msg
noticeForm config model =
    div [ class "notice-form" ]
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
            , classes = [ "" ]
            }
        ]


maybePrivacyText : Maybe (List (Html Msg)) -> Html Msg
maybePrivacyText maybePrivacy =
    case maybePrivacy of
        Just content ->
            div [ class "privacy-text" ] content

        Nothing ->
            Html.text ""
