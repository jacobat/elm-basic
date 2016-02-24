module Main where

import Plop
import Mouse
import View

-- Model

type alias Model = {
  input : String,
      clicks : Int
      }

initial_model = {
    clicks = 0,
    input = "Type here"
  }

type alias Action = View.Action

-- Update

clicks : Signal Action
clicks = Signal.map (\_ -> View.Click) Mouse.clicks

update : Action -> Model -> Model
update action model =
  case action of
    View.Click -> { model | clicks = model.clicks + 1 }
    View.UpdateString str -> { model | input = str }

mainSignal : Signal Action
mainSignal = Signal.merge clicks mailbox.signal

current_model : Signal Model
current_model = Signal.foldp update initial_model mainSignal

-- Main

mailbox : Signal.Mailbox Action
mailbox = Signal.mailbox (View.UpdateString initial_model.input)

main = Signal.map (View.view mailbox.address) current_model

port the_model : Signal Model
port the_model = current_model
