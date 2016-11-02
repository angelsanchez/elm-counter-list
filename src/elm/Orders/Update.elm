module Orders.Update exposing ( .. )

import Orders.Models exposing ( OrderItem )
import Orders.Messages exposing ( Msg ( EditOrder, ChangeOrderItemCount, FinishOrder, ResetOrder ) )
import Navigation

update : Msg -> List OrderItem -> ( List OrderItem, Cmd Msg )
update message orders =
    case message of
        EditOrder ->
            ( orders, Navigation.newUrl "#editOrder" )

        FinishOrder ->
            ( orders, Navigation.newUrl "#" )

        ChangeOrderItemCount orderItem howMuch ->
            ( changeOrderItemCount orderItem howMuch orders, Cmd.none )

        ResetOrder ->
            ( Orders.Models.new, Cmd.none )

changeOrderItemCount : OrderItem -> Int -> List OrderItem -> List OrderItem
changeOrderItemCount orderToIncrement howMuch orders =
    let
        changeCount existingOrder =
            if existingOrder.name == orderToIncrement.name then
                { existingOrder | count = existingOrder.count + howMuch }
            else
                existingOrder
    in
        List.map changeCount orders
