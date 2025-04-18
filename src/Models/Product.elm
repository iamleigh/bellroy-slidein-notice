module Models.Product exposing (Product, productDecoder)

import Json.Decode as Decode exposing (Decoder)


type alias Product =
    { name : String
    , price : String
    , highlight : Bool
    , image : String
    }


productDecoder : Decoder Product
productDecoder =
    Decode.map4 Product
        (Decode.field "name" Decode.string)
        (Decode.field "price" Decode.string)
        (Decode.field "highlight" Decode.bool)
        (Decode.field "image" Decode.string)
