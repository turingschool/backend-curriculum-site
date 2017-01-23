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

input = gets
until ready_to_quit
  # Your code here
end

puts "THANK YOU FOR CALLING!"
```

In your code you'll definitely need to use `if` and likely an `elsif` and `else`.
Whenever you're ready to exit the program, set `ready_to_quit` to `true`.

Also remember that `gets` is the "inverse" method of `puts` -- while `puts` outputs information to the terminal, `gets` captures information from the user by presenting a command prompt and allowing them to type input.
