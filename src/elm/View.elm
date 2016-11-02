module View exposing ( .. )

import Html exposing ( Html, div )
import Html.App
import Messages exposing ( Msg (..) )
import Models exposing ( Model )
import Routing exposing ( Route (..) )
import NotFoundPage.View
import Orders.OrderDetail
import Orders.OrderEdit

view : Model -> Html Msg
view model =
    div []
        [ page model ]

page : Model -> Html Msg
page model =
    case model.route of
        OrderDetailRoute ->
            Html.App.map OrderMsg ( Orders.OrderDetail.view model.order )

        OrderEditRoute ->
            Html.App.map OrderMsg ( Orders.OrderEdit.view model.order )

        NotFoundRoute ->
            NotFoundPage.View.view
