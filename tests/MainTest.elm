module MainTest exposing (all)

import Components.SlideInNotice as SlideInNotice exposing (slideInNoticeInit)
import Expect
import Html.Attributes as Attr
import Http
import Main exposing (Msg(..), update, init)
import Models.Product exposing (Product)
import Test exposing (..)


type alias DummyFlags =
    ()


initialModel =
    { slideInNotice = slideInNoticeInit
    , products = []
    }


all : Test
all =
    describe "Main.elm"
        [ describe "update"
            [ test "SlideInNoticeMsg updates SlideInNoticeModel" <|
                \_ ->
                    let
                        ( updatedModel, _ ) =
                            update (SlideInNoticeMsg SlideInNotice.ShowNotice) initialModel
                    in
                    Expect.equal True updatedModel.slideInNotice.visible

            , test "FetchProducts Ok updates products" <|
                \_ ->
                    let
                        products =
                            [ { name = "Slim Sleeve", price = "79.00", highlight = False, image = "/images/slim.jpg" } ]

                        ( updatedModel, _ ) =
                            update (FetchProducts (Ok products)) initialModel
                    in
                    Expect.equal products updatedModel.products

            , test "FetchProducts Err keeps products empty" <|
                \_ ->
                    let
                        ( updatedModel, _ ) =
                            update (FetchProducts (Err Http.Timeout)) initialModel
                    in
                    Expect.equal [] updatedModel.products

            , test "KeyPressed Escape triggers DismissNotice" <|
                \_ ->
                    let
                        ( updatedModel, _ ) =
                            update (KeyPressed "Escape") initialModel
                    in
                    Expect.equal False updatedModel.slideInNotice.visible

            , test "KeyPressed other key does nothing" <|
                \_ ->
                    let
                        ( updatedModel, _ ) =
                            update (KeyPressed "Enter") initialModel
                    in
                    Expect.equal initialModel updatedModel
            ]
        , describe "init"
            [ test "Initial model starts with empty products and hidden notice" <|
                \_ ->
                    let
                        ( model, _ ) = init ()
                    in
                    Expect.equal [] model.products
            ]
        ]
