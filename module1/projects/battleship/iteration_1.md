---
layout: page
title: Iteration 1 - Ships and Cells
---

_[Back to Battleship Home](./index)_
_[Back to Requirements](./requirements)_

## Test Driven Development

In this iteration, you are required to use TDD to create your classes. Use the interaction pattern to determine what a method should do and write one or more tests to verify that expected behavior. Then you can implement the method. You should always write code with the purpose of making a test pass.

## Ship

A Ship object will represent a single ship on the board. It will be able to keep track of how much health it has, take hits, and report if it is sunk or not. A ship should start off with health equal to it's length.

The Ship class should follow this interaction pattern:

```ruby
pry(main)> require './lib/ship'
#=> true

pry(main)> cruiser = Ship.new("Cruiser", 3)
#=> #<Ship:0x00007feb05112d10...>

pry(main)> cruiser.name
#=> "Cruiser"

pry(main)> cruiser.length
#=> 3

pry(main)> cruiser.health
#=> 3

pry(main)> cruiser.sunk?
#=> false

pry(main)> cruiser.hit

pry(main)> cruiser.health
#=> 2

pry(main)> cruiser.hit

pry(main)> cruiser.health
#=> 1

pry(main)> cruiser.sunk?
#=> false

pry(main)> cruiser.hit

pry(main)> cruiser.sunk?
#=> true
```

## Cell

A Cell object is a single cell on our board. A Cell can either contain a Ship or nothing.

```ruby
pry(main)> require './lib/ship'
# => true

pry(main)> require './lib/cell'
# => true

pry(main)> cell = Cell.new("B4")
# => #<Cell:0x00007f84f0ad4720...>

pry(main)> cell.coordinate
# => "B4"

pry(main)> cell.ship
# => nil

pry(main)> cell.empty?
# => true

pry(main)> cruiser = Ship.new("Cruiser", 3)
# => #<Ship:0x00007f84f0891238...>

pry(main)> cell.place_ship(cruiser)

pry(main)> cell.ship
# => #<Ship:0x00007f84f0891238...>

pry(main)> cell.empty?
# => false
```

Additionally, a cell knows when it has been fired upon. When it is fired upon, the cell's ship should be damaged if it has one:

```ruby
pry(main)> require './lib/ship'
# => true

pry(main)> require './lib/cell'
# => true

pry(main)> cell = Cell.new("B4")
# => #<Cell:0x00007f84f0ad4720...>

pry(main)> cruiser = Ship.new("Cruiser", 3)
# => #<Ship:0x00007f84f0891238...>

pry(main)> cell.place_ship(cruiser)

pry(main)> cell.fired_upon?
# => false

pry(main)> cell.fire_upon

pry(main)> cell.ship.health
# => 2

pry(main)> cell.fired_upon?
# => true
```

Finally, a Cell will have a method called `render` which returns a String representation of the Cell for when we need to print the board. A cell can potentially be rendered as:

* "." if the cell has not been fired upon.
* "M" if the cell has been fired upon and it does not contain a ship (the shot was a miss).
* "H" if the cell has been fired upon and it contains a ship (the shot was a hit).
* "X" if the cell has been fired upon and its ship has been sunk.

Additionally, we will include an optional boolean argument to indicate if we want to reveal a ship in the cell even if it has not been fired upon. This should render a cell that has not been fired upon and contains a ship as an "S". This will be useful for showing the user where they placed their ships and for debugging.

```ruby
pry(main)> cell_1 = Cell.new("B4")
# => #<Cell:0x00007f84f11df920...>

pry(main)> cell_1.render
# => "."

pry(main)> cell_1.fire_upon

pry(main)> cell_1.render
# => "M"

pry(main)> cell_2 = Cell.new("C3")
# => #<Cell:0x00007f84f0b29d10...>

pry(main)> cruiser = Ship.new("Cruiser", 3)
# => #<Ship:0x00007f84f0ad4fb8...>

pry(main)> cell_2.place_ship(cruiser)

pry(main)> cell_2.render
# => "."

# Indicate that we want to show a ship with the optional argument
pry(main)> cell_2.render(true)
# => "S"

pry(main)> cell_2.fire_upon

pry(main)> cell_2.render
# => "H"

pry(main)> cruiser.sunk?
# => false

pry(main)> cruiser.hit

pry(main)> cruiser.hit

pry(main)> cruiser.sunk?
# => true

pry(main)> cell_2.render
# => "X"
```
