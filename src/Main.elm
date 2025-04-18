module Main exposing (main, init, update)

import Browser
import Components.SlideInNotice exposing (Config, Msg(..), SlideInNoticeModel, slideInNoticeInit, slideInNoticeUpdate, slideInNoticeView)
import Html exposing (Html, div, img, p, text)
import Html.Attributes exposing (class, id, src, alt)
import Layouts.Header as Header
import Layouts.Body as Body



-- MODEL


type alias Model =
    SlideInNoticeModel


init : Model
init =
    slideInNoticeInit



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    slideInNoticeUpdate msg model



-- VIEW


slideInNoticeConfig : Config
slideInNoticeConfig =
    { title = "For exclusive deals, new releases, and surprise treats..."
    , placeholder = "Enter your email address"
    , submitText = "SUBMIT"
    , privacyText =
        Just
            [ text "You're consenting to our "
            , Html.span [ class "privacy-link" ] [ text "privacy policy" ]
            , text " and signing up to receive emails which you can opt out of at any time."
            ]
    }


view : Model -> Html Msg
view model =
    div [ id "bellroy-page" ]
        [ Header.view
        , Body.view
        , div [ class "bellroy-notice" ]
            [ slideInNoticeView slideInNoticeConfig model ]
        ]



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
