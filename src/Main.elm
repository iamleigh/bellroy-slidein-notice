module Main exposing (Msg(..), Flags, Model, init, main, update)

import Browser
import Browser.Events
import Components.SlideInNotice exposing (Config, Msg(..), SlideInNoticeModel, slideInNoticeInit, slideInNoticeUpdate, slideInNoticeView)
import Html exposing (Html, div, text)
import Html.Attributes exposing (class, id)
import Http
import Json.Decode as Decode
import Layouts.Body as Body
import Layouts.Header as Header
import Models.Product exposing (Product)
import Process
import Task



-- MODEL


type alias Model =
    { slideInNotice : SlideInNoticeModel
    , products : List Product
    }


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { slideInNotice = slideInNoticeInit
      , products = []
      }
    , Cmd.batch [ showAfterDelay, fetchProducts ]
    )


showAfterDelay : Cmd Msg
showAfterDelay =
    Task.perform (\_ -> SlideInNoticeMsg ShowNotice) (Process.sleep 1500)


fetchProducts : Cmd Msg
fetchProducts =
    Http.get
        { url = "/data/products.json"
        , expect = Http.expectJson FetchProducts (Decode.list Models.Product.productDecoder)
        }



-- MESSAGES (Msg)


type Msg
    = SlideInNoticeMsg Components.SlideInNotice.Msg
    | KeyPressed String
    | FetchProducts (Result Http.Error (List Product))



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SlideInNoticeMsg slideInMsg ->
            let
                ( updatedSlideIn, slideInCmd ) =
                    slideInNoticeUpdate slideInMsg model.slideInNotice
            in
            ( { model | slideInNotice = updatedSlideIn }
            , Cmd.map SlideInNoticeMsg slideInCmd
            )

        FetchProducts (Ok products) ->
            ( { model | products = products }, Cmd.none )

        FetchProducts (Err _) ->
            -- In case fetching fails, just keep products empty
            ( model, Cmd.none )

        KeyPressed key ->
            if key == "Escape" then
                let
                    ( updatedSlideIn, slideInCmd ) =
                        slideInNoticeUpdate Components.SlideInNotice.DismissNotice model.slideInNotice
                in
                ( { model | slideInNotice = updatedSlideIn }
                , Cmd.map SlideInNoticeMsg slideInCmd
                )

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
            , Html.a [ class "privacy-link" ] [ text "privacy policy" ]
            , text " and signing up to receive emails which you can opt out of at any time."
            ]
    }


view : Model -> Html Msg
view model =
    div [ id "app", class "bellroy-ui" ]
        [ div [ class "bellroy-page" ]
            [ Header.view
            , Body.view model.products (SlideInNoticeMsg ShowNotice) model.slideInNotice.visible
            ]
        , Html.map SlideInNoticeMsg (slideInNoticeView slideInNoticeConfig model.slideInNotice)
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.Events.onKeyDown (Decode.map KeyPressed keyDecoder)


keyDecoder : Decode.Decoder String
keyDecoder =
    Decode.field "key" Decode.string



-- MAIN


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
