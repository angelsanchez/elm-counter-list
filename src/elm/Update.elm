module Update exposing (..)

import Messages exposing (Msg(OrderMsg))
import Models exposing (Model)
import Orders.Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OrderMsg subMsg ->
            let
                ( updatedOrder, cmd ) =
                    Orders.Update.update subMsg model.order
            in
                ( { model | order = updatedOrder }, Cmd.map OrderMsg cmd )
