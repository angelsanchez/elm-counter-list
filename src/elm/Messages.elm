module Messages exposing (..)

import Orders.Messages

type Msg
    = OrderMsg Orders.Messages.Msg
