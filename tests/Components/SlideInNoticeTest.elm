module Components.SlideInNoticeTest exposing (all)

import Expect
import Test exposing (..)
import Components.SlideInNotice exposing (slideInNoticeUpdate, SlideInNoticeModel, Msg(..))


all : Test
all =
    describe "SlideInNotice update logic"
        [ test "DismissNotice hides the notice" <|
            \_ ->
                let
                    initialModel =
                        { visible = True, email = "user@example.com" }

                    updatedModel =
                        slideInNoticeUpdate DismissNotice initialModel
                in
                Expect.equal False updatedModel.visible
        , test "UpdateEmail changes email" <|
            \_ ->
                let
                    initialModel =
                        { visible = True, email = "" }

                    updatedModel =
                        slideInNoticeUpdate (UpdateEmail "new@email.com") initialModel
                in
                Expect.equal "new@email.com" updatedModel.email
        ]
