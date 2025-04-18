module Models.Product exposing (Product, productDecoder)

import Json.Decode as Decode exposing (Decoder)


type alias Product =
    { name : String
    , price : String
    }


productDecoder : Decoder Product
productDecoder =
    Decode.map2 Product
        (Decode.field "name" Decode.string)
        (Decode.field "price" Decode.string)
