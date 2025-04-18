module Components.SlideInNoticeTest exposing (all)

import Components.SlideInNotice exposing (Msg(..), SlideInNoticeModel, slideInNoticeInit, slideInNoticeUpdate)
import Expect
import Test exposing (..)


all : Test
all =
    describe "Components.SlideInNotice"
        [ describe "slideInNoticeUpdate"
            [ test "ShowNotice makes the notice visible" <|
                \_ ->
                    let
                        ( updatedModel, _ ) =
                            slideInNoticeUpdate ShowNotice slideInNoticeInit
                    in
                    Expect.equal True updatedModel.visible

            , test "DismissNotice hides the notice and clears the email" <|
                \_ ->
                    let
                        ( updatedModel, _ ) =
                            slideInNoticeUpdate DismissNotice
                                { slideInNoticeInit | visible = True, email = "test@example.com", hasError = True, loading = True }
                    in
                    Expect.all
                        [ \model -> Expect.equal "" model.email
                        , \model -> Expect.equal False model.loading
                        , \model -> Expect.equal False model.hasError
                        , \model -> Expect.equal True model.animating
                        ]
                        updatedModel

            , test "UpdateEmail updates the email field" <|
                \_ ->
                    let
                        ( updatedModel, _ ) =
                            slideInNoticeUpdate (UpdateEmail "hello@world.com") slideInNoticeInit
                    in
                    Expect.equal "hello@world.com" updatedModel.email

            , test "SubmitEmail with valid email starts loading" <|
                \_ ->
                    let
                        ( updatedModel, _ ) =
                            slideInNoticeUpdate SubmitEmail { slideInNoticeInit | email = "valid@email.com" }
                    in
                    Expect.equal True updatedModel.loading

            , test "SubmitEmail with invalid email sets error" <|
                \_ ->
                    let
                        ( updatedModel, _ ) =
                            slideInNoticeUpdate SubmitEmail { slideInNoticeInit | email = "invalidemail" }
                    in
                    Expect.equal True updatedModel.hasError

            , test "FinishSuccessfulSubmit resets email and loading" <|
                \_ ->
                    let
                        ( updatedModel, _ ) =
                            slideInNoticeUpdate FinishSuccessfulSubmit
                                { slideInNoticeInit | email = "test@example.com", loading = True }
                    in
                    Expect.all
                        [ \model -> Expect.equal "" model.email
                        , \model -> Expect.equal False model.loading
                        , \model -> Expect.equal True model.animating
                        ]
                        updatedModel
            ]
        ]
