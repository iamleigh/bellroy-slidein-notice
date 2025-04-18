module Main exposing (main)

import Browser
import Components.SlideInNotice exposing (Config, Msg(..), SlideInNoticeModel, slideInNoticeInit, slideInNoticeUpdate, slideInNoticeView)
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)



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
            , span [ class "privacy-link" ] [ text "privacy policy" ]
            , text " and signing up to receive emails which you can opt out of at any time."
            ]
    }


view : Model -> Html Msg
view model =
    div []
        [ slideInNoticeView slideInNoticeConfig model
        ]



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
