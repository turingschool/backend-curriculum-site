---
layout: page
title: Iteration 2 - Placing Chips and Validating Four Across
---

_[Back to Connect Four Home](./index)_
_[Back to Requirements](./requirements)_

## Test Driven Development

In this iteration, you are required to use TDD to create your classes. Use the interaction pattern to determine what a method should do and write one or more tests to verify that expected behavior. Then you can implement the method. You should always write code with the purpose of making a test pass.

## Board

The Board class is responsible for keeping track of each cell on the board and validating 4 in a row. 

Follow the interaction pattern below to build out the functionality for placing a chip on the board:


### Place Chip On Board

```ruby
pry(main)> require './lib/cell'
# => true
pry(main)> require './lib/board'
# => true
pry(main)> a_cells = [Cell.new("A1"),Cell.new("A2"),Cell.new("A3"),Cell.new("A4"),Cell.new("A5"),Cell.new("A6")]
pry(main)> b_cells = [Cell.new("B1"),Cell.new("B2"),Cell.new("B3"),Cell.new("B4"),Cell.new("B5"),Cell.new("B6")]
pry(main)> c_cells = [Cell.new("C1"),Cell.new("C2"),Cell.new("C3"),Cell.new("C4"),Cell.new("C5"),Cell.new("C6")]
pry(main)> d_cells = [Cell.new("D1"),Cell.new("D2"),Cell.new("D3"),Cell.new("D4"),Cell.new("D5"),Cell.new("D6")]
pry(main)> e_cells = [Cell.new("E1"),Cell.new("E2"),Cell.new("E3"),Cell.new("E4"),Cell.new("E5"),Cell.new("E6")]
pry(main)> f_cells = [Cell.new("F1"),Cell.new("F2"),Cell.new("F3"),Cell.new("F4"),Cell.new("F5"),Cell.new("F6")]
pry(main)> g_cells = [Cell.new("G1"),Cell.new("G2"),Cell.new("G3"),Cell.new("G4"),Cell.new("G5"),Cell.new("G6")]
pry(main)> columns = {A: a_cells, B: b_cells, C: c_cells, D: d_cells, E: e_cells, F: f_cells, G: g_cells}
pry(main)> board = Board.new(columns)
pry(main)> board.place_chip("A", "X")
pry(main)> board.render_board
# => "A B C D E F G\n. . . . . . .\n. . . . . . .\n. . . . . . .\n. . . . . . .\n. . . . . . .\nX . . . . . ."
pry(main)> board.place_chip("A", "O")
pry(main)> board.render_board
# => "A B C D E F G\n. . . . . . .\n. . . . . . .\n. . . . . . .\n. . . . . . .\nO . . . . . .\nX . . . . . ."
pry(main)> board.place_chip("D", "X")
pry(main)> board.render_board
# => "A B C D E F G\n. . . . . . .\n. . . . . . .\n. . . . . . .\n. . . . . . .\nO . . . . . .\nX . . X . . ."
pry(main)> board.place_chip("C", "O")
pry(main)> board.render_board
# => "A B C D E F G\n. . . . . . .\n. . . . . . .\n. . . . . . .\n. . . . . . .\nO . . . . . .\nX . O X . . ."

```


### Validate 4 Across

```ruby
pry(main)> require './lib/cell'
# => true
pry(main)> require './lib/board'
# => true
pry(main)> a_cells = [Cell.new("A1"),Cell.new("A2"),Cell.new("A3"),Cell.new("A4"),Cell.new("A5"),Cell.new("A6")]
pry(main)> b_cells = [Cell.new("B1"),Cell.new("B2"),Cell.new("B3"),Cell.new("B4"),Cell.new("B5"),Cell.new("B6")]
pry(main)> c_cells = [Cell.new("C1"),Cell.new("C2"),Cell.new("C3"),Cell.new("C4"),Cell.new("C5"),Cell.new("C6")]
pry(main)> d_cells = [Cell.new("D1"),Cell.new("D2"),Cell.new("D3"),Cell.new("D4"),Cell.new("D5"),Cell.new("D6")]
pry(main)> e_cells = [Cell.new("E1"),Cell.new("E2"),Cell.new("E3"),Cell.new("E4"),Cell.new("E5"),Cell.new("E6")]
pry(main)> f_cells = [Cell.new("F1"),Cell.new("F2"),Cell.new("F3"),Cell.new("F4"),Cell.new("F5"),Cell.new("F6")]
pry(main)> g_cells = [Cell.new("G1"),Cell.new("G2"),Cell.new("G3"),Cell.new("G4"),Cell.new("G5"),Cell.new("G6")]
pry(main)> columns = {A: a_cells, B: b_cells, C: c_cells, D: d_cells, E: e_cells, F: f_cells, G: g_cells}
pry(main)> board = Board.new(columns)
pry(main)> c3 = board.columns[:C][2]
# => #<Cell:0x0000000130333ae8 @column="C", @filled=false, @placement="C3", @row=3, @value=".">
pry(main)> e2 = board.columns[:E][1]
# => #<Cell:0x0000000130333f98 @column="E", @filled=false, @placement="E2", @row=2, @value=".">
pry(main)> board.row_for(c3)
# => [#<Cell:0x0000000130333cc8 @column="A", @filled=false, @placement="A3", @row=3, @value=".">,
 #<Cell:0x0000000130333bd8 @column="B", @filled=false, @placement="B3", @row=3, @value=".">,
 #<Cell:0x0000000130333ae8 @column="C", @filled=false, @placement="C3", @row=3, @value=".">,
 #<Cell:0x00000001303339f8 @column="D", @filled=false, @placement="D3", @row=3, @value=".">,
 #<Cell:0x0000000130333908 @column="E", @filled=false, @placement="E3", @row=3, @value=".">,
 #<Cell:0x0000000130333818 @column="F", @filled=false, @placement="F3", @row=3, @value=".">,
 #<Cell:0x0000000130333728 @column="G", @filled=false, @placement="G3", @row=3, @value=".">]
pry(main)> board.row_for(e2)
# => [#<Cell:0x0000000130228e50 @column="A", @filled=false, @placement="A2", @row=2, @value=".">,
 #<Cell:0x0000000130228b08 @column="B", @filled=false, @placement="B2", @row=2, @value=".">,
 #<Cell:0x0000000130228518 @column="C", @filled=false, @placement="C2", @row=2, @value=".">,
 #<Cell:0x0000000130228248 @column="D", @filled=false, @placement="D2", @row=2, @value=".">,
 #<Cell:0x0000000130333f98 @column="E", @filled=false, @placement="E2", @row=2, @value=".">,
 #<Cell:0x0000000130333ea8 @column="F", @filled=false, @placement="F2", @row=2, @value=".">,
 #<Cell:0x0000000130333db8 @column="G", @filled=false, @placement="G2", @row=2, @value=".">]
pry(main)> board.column_for(c3)
# => [#<Cell:0x000000013022b100 @column="C", @filled=false, @placement="C1", @row=1, @value=".">,
 #<Cell:0x0000000130228518 @column="C", @filled=false, @placement="C2", @row=2, @value=".">,
 #<Cell:0x0000000130333ae8 @column="C", @filled=false, @placement="C3", @row=3, @value=".">,
 #<Cell:0x0000000130333458 @column="C", @filled=false, @placement="C4", @row=4, @value=".">,
 #<Cell:0x0000000130332dc8 @column="C", @filled=false, @placement="C5", @row=5, @value=".">,
 #<Cell:0x0000000130332738 @column="C", @filled=false, @placement="C6", @row=6, @value=".">]
pry(main)> board.column_for(e2)
# => [#<Cell:0x000000013022a520 @column="E", @filled=false, @placement="E1", @row=1, @value=".">,
 #<Cell:0x0000000130333f98 @column="E", @filled=false, @placement="E2", @row=2, @value=".">,
 #<Cell:0x0000000130333908 @column="E", @filled=false, @placement="E3", @row=3, @value=".">,
 #<Cell:0x0000000130333278 @column="E", @filled=false, @placement="E4", @row=4, @value=".">,
 #<Cell:0x0000000130332be8 @column="E", @filled=false, @placement="E5", @row=5, @value=".">,
 #<Cell:0x0000000130332558 @column="E", @filled=false, @placement="E6", @row=6, @value=".">]
pry(main)> board.diagonal_for(c3)
# => [#<Cell:0x0000000130328058 @column="A", @filled=false, @placement="A1", @row=1, @value=".">,
 #<Cell:0x0000000130228b08 @column="B", @filled=false, @placement="B2", @row=2, @value=".">,
 #<Cell:0x0000000130333ae8 @column="C", @filled=false, @placement="C3", @row=3, @value=".">,
 #<Cell:0x0000000130333368 @column="D", @filled=false, @placement="D4", @row=4, @value=".">,
 #<Cell:0x0000000130332be8 @column="E", @filled=false, @placement="E5", @row=5, @value=".">,
 #<Cell:0x0000000130332468 @column="F", @filled=false, @placement="F6", @row=6, @value=".">]
pry(main)> board.diagonal_for(e2)
# => [#<Cell:0x000000013022a9f8 @column="D", @filled=false, @placement="D1", @row=1, @value=".">,
 #<Cell:0x0000000130333f98 @column="E", @filled=false, @placement="E2", @row=2, @value=".">,
 #<Cell:0x0000000130333818 @column="F", @filled=false, @placement="F3", @row=3, @value=".">,
 #<Cell:0x0000000130333098 @column="G", @filled=false, @placement="G4", @row=4, @value=".">]


# Check for connect 4 in a column:
pry(main)> a1 = board.columns[:A][0]
pry(main)> a2 = board.columns[:A][1]
pry(main)> a3 = board.columns[:A][2]
pry(main)> a4 = board.columns[:A][3]
pry(main)> column_a = board.column_for(a1) # we could have also used any cell from column A here.
pry(main)> a1.fill("X")
pry(main)> a2.fill("X")
pry(main)> a3.fill("X")
pry(main)> board.check_for_four(column_a)
# => false
pry(main)> a4.fill("X")
pry(main)> board.check_for_four(column_a)
# => true

# Check for connect 4 in a row:
pry(main)> b1 = board.columns[:B][0]
pry(main)> c1 = board.columns[:C][0]
pry(main)> d1 = board.columns[:D][0]
pry(main)> e1 = board.columns[:E][0]
pry(main)> b1.fill("O")
pry(main)> c1.fill("O")
pry(main)> d1.fill("O")
pry(main)> row_1 = board.row_for(e1) # we could have also used any cell from row 1 here.
pry(main)> board.check_for_four(row_1)
# => false
pry(main)> e1.fill("O")
pry(main)> board.check_for_four(row_1)
# => true

# Check for connect 4 in a diagonal:
pry(main)> b2 = board.columns[:B][1]
pry(main)> c3 = board.columns[:C][2]
pry(main)> d4 = board.columns[:D][3]
pry(main)> b2.fill("X")
pry(main)> c3.fill("X")
pry(main)> diagonal = board.diagonal_for(d4) # we coul dhave also used any cell that woul dhave been on this diagonal.
pry(main)> board.check_for_four(diagonal)
# => false
pry(main)> d4.fill("X")
pry(main)> board.check_for_four(diagonal)
# => true
```

