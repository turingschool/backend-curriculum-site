---
layout: page
title: Practice Paired Assessment
---

## M1 Backend Final Pairing Assessment

### Iteration 1

Clone the following repository:

`git clone git@github.com:turingschool-examples/candy_shop.git `

Use the tests in `ingredient_test.rb` to drive the development of the functionality described below.

```ruby
ingredient = Ingredient.new("Milk Chocolate", "10")
#=> <Ingredient...>
ingredient.name
#=> Milk Chocolate
ingredient.cost
#=> 10 (Integer)
```

### Iteration 2

Write your own tests to drive development, create a `Chocolate` class with the functionality described below.

```ruby
ingredient_1 = Ingredient.new("Milk Chocolate", "10")
ingredient_2 = Ingredient.new("Macadamia Nuts", "50")

chocolate = Chocolate.new("Chocolate Covered Macadamia Nuts", [ingredient_1, ingredient_2])
#=>  <Chocolate...>

chocolate.type
#=> "Chocolate Covered Macadamia Nuts"

chocolate.ingredients
#=> {"Milk Chocolate" => 10, "Macadamia Nuts" => 50}
```

### Iteration 3

Writing your own tests to drive development, create the functionality for the `Box` class described below.

```ruby
ingredient_1 = Ingredient.new("Milk Chocolate", "10")
ingredient_2 = Ingredient.new("Macadamia Nuts", "50")
ingredient_3 = Ingredient.new("Peanut Butter", "5")

chocolate_1 = Chocolate.new("Chocolate Covered Macadamia Nuts", [ingredient_1, ingredient_2])

chocolate_2 = Chocolate.new("Peanut Butter Cups", [ingredient_1, ingredient_3])

box = Box.new
#=> <Box...>

box.add_chocolate(chocolate_1)
#=> <Chocolate...>

box.add_chocolate(chocolate_2)
#=> <Chocolate...>

box.chocolates
#=> [chocolate_1, chocolate_2]

box.ingredient_list
#=> "Milk Chocolate, Macadamia Nuts, Peanut Butter"
```

### Iteration 4

Writing your own tests to drive development, add the following features to `Box`

```ruby
ingredient_1 = Ingredient.new("Milk Chocolate", "10")
ingredient_2 = Ingredient.new("Macadamia Nuts", "50")
ingredient_3 = Ingredient.new("Peanut Butter", "5")

chocolate_1 = Chocolate.new("Chocolate Covered Macadamia Nuts", [ingredient_1, ingredient_2])

chocolate_2 = Chocolate.new("Peanut Butter Cups", [ingredient_1, ingredient_3])

box = Box.new
#=> <Box...>

box.add_chocolate(chocolate_1)
#=> <Chocolate...>

box.add_chocolate(chocolate_2)
#=> <Chocolate...>

box.cost
#=> 65
```
