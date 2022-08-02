---
layout: page
title: Iteration 1 - Cell and Board Render
---

_[Back to Connect Four Home](./index)_
_[Back to Requirements](./requirements)_

## Test Driven Development

In this iteration, you are required to use TDD to create your classes. Use the interaction pattern to determine what a method should do and write one or more tests to verify that expected behavior. Then you can implement the method. You should always write code with the purpose of making a test pass.

## Cell 

A Cell object represents the space where a chip could be placed on the Connect 4 board. We will be able to read it's column letter and row number, as well as it's display value. It will also have behavior to fill in the cell with a new value.

The Cell class should follow this interaction pattern:

```ruby
pry(main)> require './lib/cell'
# => true
pry(main)> a1 = Cell.new("A1")
# => #<Cell:0x000000014a232490 @column="A", @filled=false, @placement="A1", @row=1, @value=".">
pry(main)> b3 = Cell.new("B3")
# => #<Cell:0x000000014a29b080 @column="B", @filled=false, @placement="B3", @row=3, @value=".">
pry(main)> a1.placement
# => "A1"
pry(main)> a1.column
# => "A"
pry(main)> a1.row
# => 1
pry(main)> a1.value
# => "."
pry(main)> a1.filled?
# => false
pry(main)> a1.fill("X")
# => "X"
pry(main)> a1.value
# => "X"
pry(main)> a1.filled?
# => true
pry(main)> b3.fill("O")
# => "O"
pry(main)> b3.value
# => "O"
pry(main)> b3.filled?
# => true
```

## Board

The Board class is responsible for keeping track of each cell on the board and validating 4 in a row. 

Follow the interaction pattern below to build out the board's display: 

### Board Display

```ruby 
[1] pry(main)> require './lib/chip'
=> true
[2] pry(main)> require './lib/cell'
=> true
[3] pry(main)> require './lib/board'
=> true
[4] pry(main)> a_cells = [Cell.new("A1"),Cell.new("A2"),Cell.new("A3"),Cell.new("A4"),Cell.new("A5"),Cell.new("A6")]
[5] pry(main)> b_cells = [Cell.new("B1"),Cell.new("B2"),Cell.new("B3"),Cell.new("B4"),Cell.new("B5"),Cell.new("B6")]
[6] pry(main)> c_cells = [Cell.new("C1"),Cell.new("C2"),Cell.new("C3"),Cell.new("C4"),Cell.new("C5"),Cell.new("C6")]
[7] pry(main)> d_cells = [Cell.new("D1"),Cell.new("D2"),Cell.new("D3"),Cell.new("D4"),Cell.new("D5"),Cell.new("D6")]
[8] pry(main)> e_cells = [Cell.new("E1"),Cell.new("E2"),Cell.new("E3"),Cell.new("E4"),Cell.new("E5"),Cell.new("E6")]
[9] pry(main)> f_cells = [Cell.new("F1"),Cell.new("F2"),Cell.new("F3"),Cell.new("F4"),Cell.new("F5"),Cell.new("F6")]
[10] pry(main)> g_cells = [Cell.new("G1"),Cell.new("G2"),Cell.new("G3"),Cell.new("G4"),Cell.new("G5"),Cell.new("G6")]
[11] pry(main)> columns = {A: a_cells, B: b_cells, C: c_cells, D: d_cells, E: e_cells, F: f_cells, G: g_cells}
[12] pry(main)> board = Board.new(columns)
=> #<Board:0x0000000138046418 @columns= {.....}>
[13] pry(main)> board.columns
=> {:A=>
  [#<Cell:0x000000012d347e38 @value=".", @filled=false, @column="A", @placement="A1", @row=1>,
   #<Cell:0x000000012d347d70 @value=".", @filled=false, @column="A", @placement="A2", @row=2>,
   #<Cell:0x000000012d347cd0 @value=".", @filled=false, @column="A", @placement="A3", @row=3>,
   #<Cell:0x000000012d347c08 @value=".", @filled=false, @column="A", @placement="A4", @row=4>,
   #<Cell:0x000000012d347b40 @value=".", @filled=false, @column="A", @placement="A5", @row=5>,
   #<Cell:0x000000012d347a78 @value=".", @filled=false, @column="A", @placement="A6", @row=6>],
 :B=>
  [#<Cell:0x000000012d385940 @value=".", @filled=false, @column="B", @placement="B1", @row=1>,
   #<Cell:0x000000012d385710 @value=".", @filled=false, @column="B", @placement="B2", @row=2>,
   #<Cell:0x000000012d385558 @value=".", @filled=false, @column="B", @placement="B3", @row=3>,
   #<Cell:0x000000012d3853f0 @value=".", @filled=false, @column="B", @placement="B4", @row=4>,
   #<Cell:0x000000012d3851c0 @value=".", @filled=false, @column="B", @placement="B5", @row=5>,
   #<Cell:0x000000012d3850f8 @value=".", @filled=false, @column="B", @placement="B6", @row=6>],
 :C=>
  [#<Cell:0x000000012d3a6eb0 @value=".", @filled=false, @column="C", @placement="C1", @row=1>,
   #<Cell:0x000000012d3a6de8 @value=".", @filled=false, @column="C", @placement="C2", @row=2>,
   #<Cell:0x000000012d3a6cf8 @value=".", @filled=false, @column="C", @placement="C3", @row=3>,
   #<Cell:0x000000012d3a6c08 @value=".", @filled=false, @column="C", @placement="C4", @row=4>,
   #<Cell:0x000000012d3a6b40 @value=".", @filled=false, @column="C", @placement="C5", @row=5>,
   #<Cell:0x000000012d3a6aa0 @value=".", @filled=false, @column="C", @placement="C6", @row=6>],
 :D=>
  [#<Cell:0x000000012d0f95c8 @value=".", @filled=false, @column="D", @placement="D1", @row=1>,
   #<Cell:0x000000012d0f8218 @value=".", @filled=false, @column="D", @placement="D2", @row=2>,
   #<Cell:0x000000012d0f3b00 @value=".", @filled=false, @column="D", @placement="D3", @row=3>,
   #<Cell:0x000000012d0f26d8 @value=".", @filled=false, @column="D", @placement="D4", @row=4>,
   #<Cell:0x000000012d0f25c0 @value=".", @filled=false, @column="D", @placement="D5", @row=5>,
   #<Cell:0x000000012d0f22c8 @value=".", @filled=false, @column="D", @placement="D6", @row=6>],
 :E=>
  [#<Cell:0x000000012d20c898 @value=".", @filled=false, @column="E", @placement="E1", @row=1>,
   #<Cell:0x000000012d20c028 @value=".", @filled=false, @column="E", @placement="E2", @row=2>,
   #<Cell:0x000000012d207e88 @value=".", @filled=false, @column="E", @placement="E3", @row=3>,
   #<Cell:0x000000012d207ca8 @value=".", @filled=false, @column="E", @placement="E4", @row=4>,
   #<Cell:0x000000012d207578 @value=".", @filled=false, @column="E", @placement="E5", @row=5>,
   #<Cell:0x000000012d206790 @value=".", @filled=false, @column="E", @placement="E6", @row=6>],
 :F=>
  [#<Cell:0x000000012d275820 @value=".", @filled=false, @column="F", @placement="F1", @row=1>,
   #<Cell:0x000000012d26ff38 @value=".", @filled=false, @column="F", @placement="F2", @row=2>,
   #<Cell:0x000000012d26fd80 @value=".", @filled=false, @column="F", @placement="F3", @row=3>,
   #<Cell:0x000000012d26f650 @value=".", @filled=false, @column="F", @placement="F4", @row=4>,
   #<Cell:0x000000012d26ecf0 @value=".", @filled=false, @column="F", @placement="F5", @row=5>,
   #<Cell:0x000000012d26e778 @value=".", @filled=false, @column="F", @placement="F6", @row=6>],
 :G=>
  [#<Cell:0x000000012d2cee20 @value=".", @filled=false, @column="G", @placement="G1", @row=1>,
   #<Cell:0x000000012d2cec18 @value=".", @filled=false, @column="G", @placement="G2", @row=2>,
   #<Cell:0x000000012d2ce970 @value=".", @filled=false, @column="G", @placement="G3", @row=3>,
   #<Cell:0x000000012d2ce718 @value=".", @filled=false, @column="G", @placement="G4", @row=4>,
   #<Cell:0x000000012d2ce010 @value=".", @filled=false, @column="G", @placement="G5", @row=5>,
   #<Cell:0x000000012d2cda70 @value=".", @filled=false, @column="G", @placement="G6", @row=6>]}
[16] pry(main)> board.render_board
=> "A B C D E F G\n. . . . . . .\n. . . . . . .\n. . . . . . .\n. . . . . . .\n. . . . . . .\n. . . . . . ."
```
