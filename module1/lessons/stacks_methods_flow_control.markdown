Data Structures

* Linked List 
  * Arrays
  * Stacks
  * Queues
  
* Trees
  * Binary
  
* Graphs (Trie Tree)

## Stacks

* Last-In, First-Out (LIFO)
  * Like a 'stack' of dishes
* Add -> 'push'
* Remove (destructively) -> 'pop'
* Look at the top ->  'top' or 'peak'

### In Ruby
* Arrays have many methods (push & pop, first & last provided)
* Array to implement a stack 
[1,2,3] => 

3
2
1
--
stack

* Whitespace = hierarchy 
* Execution = pointer, like finger; linear top-to-bottom, perhaps with loops mixed in 
* Imperative programming = top-to-bottom, line-by-line (instructions; type your own line numbers)
  * Evil GOTO (choose-your-own-adventure); must have an exit if you're referring to previous lines
  
* Parse Time v. Execution Time 
  * Parse - defining methods that could be used later (defining stuff, like classes) (I know how to do this _if it's invoked later_)
  * when method is invoked, it is run immediately (executed)
  * when class (or method or data type) is closed, then things are executed
  
* Frame = methods, what variables passed in, when you're done, return to line 10
  * Virtual machine - call method = invoke & add a frame to stack (when done, return to line 2)
  * Return value given back to first frame & 2nd frame is popped off
  * Stack = how virtual machine keeps track methods that are invoked
  
* Stack trace 
```
Things went wrong!
  a.rb 26
  b.rb 2
  c.rb 10
```

```
stack level too deep! 
  too many frames deep = overflow
```

Shadow frame before init 
  * `main` frame (sassy = cat1); thread; owner of all execution in program (doesn't help except line #s)
    * enters stack when file is run 
  * then 'init' frame added to stack (when Cat.new("Siamese") executed)
  * local vars that hold instances only available to the main frame
  * then @name = 'Siamese' added to stack
  * then chance.chase(sassy) == chance.chase(cat1)
    dr = 'woof'
    cat.be_chased(self) == cat.be_chased(dog1) (each frame has a definition of self; owner of frame)
  * Ruby = pass by value (not by reference); find value of sassy, not reference
  

* Local vars = belong to & only visible in frame