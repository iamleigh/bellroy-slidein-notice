module Utils.Email exposing (isValid)


isValid : String -> Bool
isValid email =
    -- very basic validation for now
    String.contains "@" email && String.contains "." email
