module MainTest exposing (all)

import Expect
import Test exposing (..)
import Main exposing (init, update)
import Components.SlideInNotice exposing (Msg(..))


all : Test
all =
    describe "Main.elm"
        [ test "Initial model should be visible with empty email" <|
            \_ ->
                Expect.equal
                    { visible = True, email = "" }
                    init
        , test "DismissNotice hides the slide-in notice" <|
            \_ ->
                let
                    updatedModel =
                        update DismissNotice { visible = True, email = "someone@example.com" }
                in
                Expect.equal False updatedModel.visible
        , test "UpdateEmail changes the email field" <|
            \_ ->
                let
                    updatedModel =
                        update (UpdateEmail "new@example.com") { visible = True, email = "" }
                in
                Expect.equal "new@example.com" updatedModel.email
        , test "SubmitEmail clears the email field" <|
            \_ ->
                let
                    updatedModel =
                        update SubmitEmail { visible = True, email = "hello@domain.com" }
                in
                Expect.equal "" updatedModel.email
        ]
