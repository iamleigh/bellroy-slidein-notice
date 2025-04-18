module Main exposing (init, main, update)

import Browser
import Components.SlideInNotice exposing (Config, Msg(..), SlideInNoticeModel, slideInNoticeInit, slideInNoticeUpdate, slideInNoticeView)
import Html exposing (Html, div, img, p, text)
import Html.Attributes exposing (alt, class, id, src)
import Layouts.Body as Body
import Layouts.Header as Header
import Process
import Task
import Time exposing (Posix)



-- MODEL


type alias Model =
    SlideInNoticeModel


init : Model
init =
    slideInNoticeInit


showAfterDelay : Cmd Msg
showAfterDelay =
    Task.perform (\_ -> ShowNotice) (Process.sleep 1500)



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( slideInNoticeUpdate msg model, Cmd.none )



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
    div [ id "app", class "bellroy-ui" ]
        [ div [ class "bellroy-page" ]
            [ Header.view
            , Body.view
            ]
        , div [ class "bellroy-notice" ]
            [ slideInNoticeView slideInNoticeConfig model ]
        ]



-- MAIN


type alias Flags =
    ()


main : Program Flags Model Msg
main =
    Browser.element
        { init = \_ -> ( init, showAfterDelay )
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
