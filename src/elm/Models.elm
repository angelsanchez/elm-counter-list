module Models exposing (..)

import Routing

import Orders.Models exposing ( OrderItem )

type alias Model =
    { route : Routing.Route
    , order : List OrderItem
    }

initialModel : Routing.Route -> Model
initialModel route =
    { route = route
    , order = Orders.Models.new
    }
