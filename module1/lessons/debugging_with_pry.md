## Pry

In your terminal, enter the command:

`gem install pry`

You should see output saying Pry was successfully installed. If you got an error instead, ask an instructor for help before moving on.

Pry is very similar to IRB. Enter the command `pry` into your terminal and you should see a prompt like `[1] pry(main)>`. This is a REPL, which stands for Read, Evaluate, Print, Loop. This means that Pry will read whatever you type in, evaluate it, and print out the evaluation known as the **return value**. It will do all three of those things in a continuous loop. Try entering some Ruby code into Pry that you may already know, for example:

```ruby
[1] pry(main)> greeting = "hello"
=> "hello"
[2] pry(main)> place = "world"
=> "world"
[3] pry(main)> "#{greeting} #{place}"
=> "hello world"
```

The value printed after the `=>` is the **return value** of the previous line of code.
