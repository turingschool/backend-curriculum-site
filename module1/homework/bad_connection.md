---
title: Bad Connection
tags: projects
---

# Bad Connection

This small challenge is adapted from Chris Pine's "Learn to Program".

## Premise

Write a program which can imitate a Customer Service Representative whose phone connection is bad with these rules:

* If you don't input anything (just hit enter) they respond with `HELLO?!`
* If you ask a question with any lower-case letters, they respond with
`I AM HAVING A HARD TIME HEARING YOU.`
* If you ask a question in all upper-case letters, they respond with
`NO, THIS IS NOT A PET STORE`
* The first time you say `GOODBYE!` they say `ANYTHING ELSE I CAN HELP WITH?`
* The second time you say `GOODBYE!` they say `THANK YOU FOR CALLING!` and the program
exits.
* To run the program, you would enter in your command line:
```
ruby bad_connection.rb
```


## Example

```
HELLO, THIS IS A GROCERY STORE!
> hi, do you have rice?
I AM HAVING A HARD TIME HEARING YOU.
> I SAID HI, DO YOU HAVE RICE?
NO, THIS IS NOT A PET STORE
>
HELLO?!
> Goodbye!
I AM HAVING A HARD TIME HEARING YOU.
> GOODBYE!
ANYTHING ELSE I CAN HELP WITH?
> GOODBYE!
THANK YOU FOR CALLING!
```

## Template

```ruby
ready_to_quit = false
puts "HELLO, THIS IS A GROCERY STORE!"

input = gets.chomp
until ready_to_quit
  # Your code here
end

puts "THANK YOU FOR CALLING!"
```

In your code you'll definitely need to use `if` and likely an `elsif` and `else`.
Whenever you're ready to exit the program, set `ready_to_quit` to `true`.

Also remember that `gets` is the "inverse" method of `puts` -- while `puts` outputs information to the terminal, `gets` captures information from the user by presenting a command prompt and allowing them to type input.

## Iteration 1 

Build a program the meets the above functionality 

## Iteration 2 

Refactor your program to use methods while maintaining above functionality  

## Iteration 3 

Refactor your program to use Classes as well as methods while maintaining above functionality  

## Iteration 4  

Add the following functionality to your program. 
When I input `print log`, it prints out a summary of the conversation noting the input correlated to output and a count of how many times an output has be given.   
This may look something like this: 
```
HELLO?!
* ['', '', '']
* 3 times

I'M HAVING A HARD TIME HEARING YOU.  
* ['do you sell carrots?', 'Do you sell carrots?']
* 2 times

NO, THIS IS NOT A PET STORE 
* ['DO YOU SELL CARROTS?', 'CARROTS', 'DO YOU HAVE ANY APPLES?', 'APPLES!', 'I WOULD LIKE SOME APPLES!' ]
* 5 times

ANYTHING ELSE I CAN HELP YOU WITH?
* ['GOODBYE1']
* 1 time
```
