module Main exposing (init, main, update)

import Browser
import Browser.Events
import Components.SlideInNotice exposing (Config, Msg(..), SlideInNoticeModel, slideInNoticeInit, slideInNoticeUpdate, slideInNoticeView)
import Html exposing (Html, div, img, p, text)
import Html.Attributes exposing (alt, class, id, src)
import Json.Decode as Decode
import Layouts.Body as Body
import Layouts.Header as Header
import Process
import Task



-- MODEL


type alias Model =
    SlideInNoticeModel


init : Model
init =
    slideInNoticeInit


showAfterDelay : Cmd Msg
showAfterDelay =
    Task.perform (\_ -> SlideInNoticeMsg ShowNotice) (Process.sleep 1500)



-- MESSAGES (Msg)


type Msg
    = SlideInNoticeMsg Components.SlideInNotice.Msg
    | KeyPressed String



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SlideInNoticeMsg slideInMsg ->
            let
                ( updatedSlideIn, slideInCmd ) =
                    slideInNoticeUpdate slideInMsg model
            in
            ( updatedSlideIn, Cmd.map SlideInNoticeMsg slideInCmd )

        KeyPressed key ->
            if key == "Escape" then
                let
                    ( updatedModel, slideInCmd ) =
                        slideInNoticeUpdate Components.SlideInNotice.DismissNotice model
                in
                ( updatedModel, Cmd.map SlideInNoticeMsg slideInCmd )
            else
                ( model, Cmd.none )



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
            , Body.view (SlideInNoticeMsg ShowNotice) model.visible
            ]
        , Html.map SlideInNoticeMsg (slideInNoticeView slideInNoticeConfig model)
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.Events.onKeyDown (Decode.map KeyPressed keyDecoder)


keyDecoder : Decode.Decoder String
keyDecoder =
    Decode.field "key" Decode.string



-- MAIN


type alias Flags =
    ()


main : Program Flags Model Msg
main =
    Browser.element
        { init = \_ -> ( init, showAfterDelay )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
