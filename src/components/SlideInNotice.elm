module Components.SlideInNotice exposing (SlideInNoticeModel, Msg(..), slideInNoticeView, slideInNoticeInit, slideInNoticeUpdate)

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


-- MODEL

type alias SlideInNoticeModel =
    { visible : Bool }


slideInNoticeInit : SlideInNoticeModel
slideInNoticeInit =
    { visible = True }


-- UPDATE

type Msg
    = DismissNotice


slideInNoticeUpdate : Msg -> SlideInNoticeModel -> SlideInNoticeModel
slideInNoticeUpdate msg model =
    case msg of
        DismissNotice ->
            { model | visible = False }


-- VIEW

slideInNoticeView : SlideInNoticeModel -> Html Msg
slideInNoticeView model =
    if model.visible then
        div [ class "slide-in-notice" ]
            [ div [ class "notice-text" ] [ text "For exclusive deals, new releases, and surprise treats, subscribe now!" ]
            , button [ class "dismiss-button", onClick DismissNotice ] [ text "X" ]
            ]
    else
        -- When not visible, render nothing
        Html.text ""
