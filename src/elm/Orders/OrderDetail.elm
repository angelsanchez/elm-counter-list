module Orders.OrderDetail exposing ( view )

import Html exposing ( Html, div, text, button, ul, li, h1 )
import Html.Events exposing ( onClick )
import Html.Attributes exposing ( class )

import Orders.Models exposing ( OrderItem )
import Orders.Messages exposing ( Msg ( EditOrder ) )

view : List OrderItem -> Html Msg
view order =
    div []
        [ h1 [] [ text "ELM Morning Coffee" ]
        , button [ onClick EditOrder, class "btn" ] [ text "Edit Order" ]
        , ul [ class "orderDetailList" ] [ orderListView order ]
        ]

orderListView : List OrderItem -> Html Msg
orderListView orders =
    let
        filteredOrderItems = List.filter (\order -> order.count > 0) orders
    in
        div []
            ( List.map orderView filteredOrderItems )

orderView : OrderItem -> Html Msg
orderView orderItem =
    li [] [ text ((toString orderItem.count) ++ " " ++ orderItem.name) ]
