module Main exposing (main)

import Browser
import Html exposing (Html, div)
import Components.SlideInNotice exposing (SlideInNoticeModel, Msg(..), slideInNoticeInit, slideInNoticeUpdate, slideInNoticeView)


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

view : Model -> Html Msg
view model =
    div []
        [ slideInNoticeView model
        ]


-- MAIN

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
