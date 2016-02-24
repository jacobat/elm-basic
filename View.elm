module View where

import String
import Html -- exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (targetValue, on)

type Action = Click | UpdateString String

-- View

children address model =
  [
    Html.h1 [] [ Html.text "Heading" ],
    Html.text "Hello world",
    Html.br [] [],
    Html.text (toString model.clicks),
    Html.br [] [],
    Html.input [ value model.input, on "input" targetValue (\str -> Signal.message address (UpdateString str)) ] [ ],
    Html.text (toString (String.length model.input))
  ]

view address model =
  let
      childNodes = children address model
  in
      Html.div [ id "container" ] childNodes

