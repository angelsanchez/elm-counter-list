module Orders.OrderEdit exposing ( view )

import Html exposing ( Html, div, text, button, img, h1 )
import Html.Events exposing ( onClick )
import Html.Attributes exposing ( src, class )
import Orders.Messages exposing ( Msg ( ChangeOrderItemCount, FinishOrder, ResetOrder ) )
import Orders.Models exposing ( OrderItem )

view : List OrderItem -> Html Msg
view order =
    div []
        [ h1 [] [ text "Edit Order" ]
        , div [] [ orderListView order ]
        , button [ onClick ResetOrder, class "btn" ] [ text "Reset" ]
        , button [ onClick FinishOrder, class "btn" ] [ text "Finish" ]
        ]

orderListView : List OrderItem -> Html Msg
orderListView orders =
    div []
        ( List.map orderItemCounterView orders )

orderItemCounterView : OrderItem -> Html Msg
orderItemCounterView orderItem =
    div [ class "orderItemCounter" ]
        [ div [ class "count" ] [ text (toString orderItem.count) ]
        , img [ src orderItem.image ] [ ]
        , div [ class "name" ] [ text orderItem.name ]
        , button [ onClick ( ChangeOrderItemCount orderItem -1 ) ] [ text "-" ]
        , button [ onClick ( ChangeOrderItemCount orderItem 1 ) ] [ text "+" ]
        ]
