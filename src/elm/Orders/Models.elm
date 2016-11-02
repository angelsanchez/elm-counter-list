module Orders.Models exposing (..)

type alias OrderItem =
    { image : String
    , name : String
    , count : Int
    , kind : String
    }

imagesPath = "static/images/"

new : List OrderItem
new =
    [ { name = "Coffee & Milk", image = imagesPath ++ "coffee_milk.jpg", count = 0, kind = "toDrink" }
    , { name = "Tea", image = imagesPath ++ "tea.jpg", count = 0, kind = "toDrink" }
    , { name = "Cortado", image = imagesPath ++ "cortado.jpg", count = 0, kind = "toDrink" }
    , { name = "Water", image = imagesPath ++ "water.jpg", count = 0, kind = "toDrink" }
    , { name = "Toasted bread with tomato and olive oil", image = imagesPath ++ "tosted_bread_tomato.png", count = 0, kind = "toEat" }
    , { name = "Slice of Spanish tortilla", image = imagesPath ++ "slice_spanish_tortilla.jpg", count = 0, kind = "toEat" }
    ]
