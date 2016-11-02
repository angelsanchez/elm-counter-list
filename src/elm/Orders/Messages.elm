module Orders.Messages exposing (..)

import Orders.Models exposing ( OrderItem )

type Msg =
    EditOrder
    | ChangeOrderItemCount OrderItem Int
    | FinishOrder
    | ResetOrder
