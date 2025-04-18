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
import Html exposing (Html, div, span, text, img)
import Html.Attributes exposing (attribute, class, tabindex, alt, src)
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
    , emailError : Maybe String
    }


slideInNoticeInit : SlideInNoticeModel
slideInNoticeInit =
    { visible = False
    , email = ""
    , animating = False
    , removed = True -- Start fully removed
    , animationClass = ""
    , emailError = Nothing
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
            if isValidEmail model.email then
                ( { model
                    | email = ""
                    , emailError = Nothing
                  }
                , slideOutAndClose
                )
            else
                ( { model
                    | emailError = Just "Please enter a valid email address."
                  }
                , Cmd.none
                )


delayFinishExit : Cmd Msg
delayFinishExit =
    Task.perform (\_ -> FinishExitAnimation) (Process.sleep 500)


isValidEmail : String -> Bool
isValidEmail email =
    -- very basic validation for now
    String.contains "@" email && String.contains "." email


slideOutAndClose : Cmd Msg
slideOutAndClose =
    Task.perform (\_ -> FinishExitAnimation) (Process.sleep 500)



-- VIEW


slideInNoticeView : Config -> SlideInNoticeModel -> Html Msg
slideInNoticeView config model =
    if model.removed then
        Html.text ""
    else
        div
            [ class ("bellroy-notice " ++ model.animationClass)
            , Html.Attributes.attribute "role" "alert"
            , Html.Attributes.attribute "aria-live" "assertive"
            , Html.Attributes.tabindex -1
            ]
            [ div [ class "bellroy-notice__container" ]
                [ imgElement "/images/bellroy-card.png" "Gift card wrapped with ribbon" [ "bellroy-notice__img--bottom" ]
                , div [ class "bellroy-notice__content" ]
                    [ dismissButton
                    , noticeTitle config.title
                    , noticeForm config model
                    , maybePrivacyText config.privacyText
                    ]
                , imgElement "/images/bellroy-magnets.png" "Box with magnets and pins" [ "bellroy-notice__img--top" ]
                ]
            ]




imgElement : String -> String -> List String -> Html msg
imgElement srcUrl altText additionalClasses =
    Html.img
        [ src srcUrl
        , alt altText
        , class ("bellroy-notice__img " ++ String.join " " additionalClasses)
        , Html.Attributes.attribute "aria-hidden" "true"
        ]
        []


dismissButton : Html Msg
dismissButton =
    Button.uiButton
        { label = "Dismiss Notification"
        , iconName = Just "xmark"
        , iconPosition = Nothing
        , onClick = DismissNotice
        , classes = [ "bellroy-button--float" ]
        , disabled = False
        }


noticeTitle : String -> Html Msg
noticeTitle titleText =
    div [ class "bellroy-notice__title" ]
        [ text titleText ]


noticeForm : Config -> SlideInNoticeModel -> Html Msg
noticeForm config model =
    div [ class "bellroy-form" ]
        [ Input.input
            { inputType = "email"
            , placeholderText = config.placeholder
            , value = model.email
            , onInput = UpdateEmail
            , classes =
                [ "bellroy-input"
                ]
                    ++ (case model.emailError of
                            Just _ -> [ "error" ] -- 🔥 Add error class dynamically
                            Nothing -> []
                       )
            }
        , Button.uiButton
            { label = config.submitText
            , iconName = Nothing
            , iconPosition = Nothing
            , onClick = SubmitEmail
            , classes = [ "bellroy-button" ]
            , disabled = model.email == "" -- 🔥 Disable if empty
            }
        , case model.emailError of
            Just err ->
                div [ class "bellroy-error", attribute "role" "alert" ]
                    [ text err ]

            Nothing ->
                Html.text ""
        ]


maybePrivacyText : Maybe (List (Html Msg)) -> Html Msg
maybePrivacyText maybePrivacy =
    case maybePrivacy of
        Just content ->
            div [ class "bellroy-notice__copy" ] content

        Nothing ->
            Html.text ""
