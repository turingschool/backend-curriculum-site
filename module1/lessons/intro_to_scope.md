---
page: layout
title: Methods, Arguments, Blocks, and Scopes
length: 90
tags: methods, scopes, arguments, ruby
---

## Learning Goals

* Define scope
* Identify benefits of scope
* Predict how variables will behave when multiple scopes are involved

## Slides

Available [here](../slides/intro_to_scope)

## Warmup

What will the following code snippet output?

```ruby
def print_vars(x, y)
  x = 12
  puts "x: " + x.to_s
  puts "y: " + y.to_s
end

x = 1
y = 5

print_vars(x, y)
print_vars(y, x)

x = 14

print_vars(x, y)

while x < 16
  puts x + y
  x += 1
end

puts x
```

## Lesson

Variable scope is what controls what you have access to where. Scope is the kind of thing that you think you don't need to know until it starts causing you trouble. Even then, it is generally unnecessary to the rules of how scope works in Ruby. It's more important that when you see unexpected behavior that scope of your variables/method names is one of the things on your list to check.

### Global scope

Let's start with the most basic code structure we could look at in ruby
— a single file with some statements executing in top-level scope.

Create a file called `global_scope.rb` on your machine:

```
touch global_scope.rb
```

Open the file in your text editor so we can work on it.

Let's add some very basic code:

```ruby
  x = 10
  puts "x is #{x}"
  x += 20
  puts "x is #{x}"
```

Before running the file, state briefly in your head what output you
expect to see. Then run the file (`ruby global_scope.rb`) and see if
your expectations were correct.

In this trivial example `x` is functioning as a local variable. So far
we have not added any methods, classes, blocks, or other structures that
would create additional scopes, so we might say that `x` is currently
defined in the "global" or top-level scope.

__Methods in Global Scope__

While we most often define methods on objects in ruby, we can define
them in the global scope as well, just as we defined the local variable
`x` in the example above.

### Method Scopes and Arguments

Let's add some lines to the bottom of `global_scope.rb`:

```ruby
  def print_doubled_value(x)
    puts "double the value #{x} is #{x * 2}"
  end

  print_doubled_value(x)
```

Again, consider what you expect this code to do, and then run it.

So far so good — we can probably guess pretty easily how this example will
behave.

Let's add another example using the new `print_doubled_value` method:

```ruby
  y = 27
  print_doubled_value(y)
```

Does this code behave as you expect? Consider the 2 uses of the variable
`x` in our current example — we have a variable called `x` in the top
level scope which begins as `10` and is then incremented to `30`.

But inside of the `print_doubled_value` method, we see another usage of `x`,
this one apparently changing each time the method is called.

This illustrates one of the important behaviors of methods in ruby --
they create new scopes with an independent set of variables from
whatever scope surrounds the method.

In this case the `x` which appears in the definition of our method
(`def print_doubled_value(x)`) is an __argument__ to the method,
and as such it becomes a new local variable available within the
scope of the method.

To get fancy, we might say that the variable `x` is _bound_ by the
method `print_doubled_value` -- other definitions of variables named `x`
may exist, but within `print_doubled_value` they are irrelevant, since
the method's own definition of this variable supersedes any other
definitions.

Enough theory, let's look at another example. Redefine
`print_doubled_value` and call it like so:

```ruby
def print_doubled_value(x)
  orig = x
  x = x * 2
  puts "double the value #{orig} is #{x}"
  puts "inner x is now: #{x}"
end

print_doubled_value(x)
puts "outer x is still: #{x}"
```

What output do you expect from this code? Think especially about the
output about "inner" and "outer" values of x:

`inner x is now: ??`

`outer x is still: ??`

We can see from this example that modifying the value of `x` inside of
the method has no effect on the value of `x` outside of the method.

This behavior holds true even when (as in this example) the outer
variable and the inner (method) variable _have the same name_!

The method's variable of the name `x` is completely independent of the
global scope's method of the name `x`, so any modifications we make
within the method have no effect on the outer variable.

Let's consider another example. Add a new `combine_variables` method to
your file:

```ruby
a = 4
b = 12
def combine_variables(x)
  puts "inner x is: #{x}"
  puts "and outer b is: #{b}"
end
combine_variables(a)
```

How does this code match your expectations?

We might have expected some output like:

```ruby
inner x is: 4
and outer b is: 12
```

But what actually happens? We should get an error similar to:

```ruby
global_scope.rb:29:in `combine_variables': undefined local variable or method `b' for main:Object (NameError)
	from global_scope.rb:31:in `<main>'
```

What does this error show us about method scopes?

Not only do they have independent versions of any variables that might
have existed in their parent scope, but they can't even access other
variables from the parent scope.

This can be a common source of confusion when you're new to ruby so make
a note: method's __can't__ access local variables in their parent scope.

### Blocks

We saw earlier that methods create new scopes which lack the ability to
reference local variables in their parent scope. But methods aren't the
only things that can create scopes.

Another common way that we create new scopes in ruby is by using blocks.
You've seen blocks many times by now, especially when using enumerables:

```ruby
[1,2,3].each { |num| puts "num is #{num}" }
num is 1
num is 2
num is 3
=> [1,2,3]
```

Note that the `num` block variable functions very similarly to a method
argument — each time the block is executed, a new value will be supplied
for `num`

Do blocks have the same behavior when it comes to scopes and arguments?
Let's find out. Add some more code to the bottom of our `global_scopes.rb` file:

(this file is starting to get a bit messy, but such is the price of
learning)

```ruby
ingredients = ["flour", "water", "yeast", "salt"]
method = "measure"

def unit
  ["teaspoon", "cup", "pinch"].sample
end

ingredients.each do |ingredient|
  puts "#{method} one #{unit} #{ingredient}"
end
```

There are quite a few pieces in play here — 2 local variables, a method,
and a block variable! What output do you think it will produce?

Holy cavorting closures batman! Unlike the method example we saw before,
which blew up when trying to refer to an adjacent local variable, this
code works just fine.

This is due to the ability of blocks to create what is called a
"closure." Unlike a method scope, which captures its arguments but
ignores surrounding local variables, a closure "closes over" those
variables and allows them to be referenced from the inner scope.

But how do blocks handle collisions between variables? Let's try an
example. More code!

### Blocks with Overlapping Inner/Outer Variables

```ruby
new_ingredients = ["banana", "chocolate chips"]
temperature = 375
method = "bake"

new_ingredients.each do |ingredient|
  method = "mix"
  puts "#{method} the #{ingredient} at #{temperature} degrees"
end

puts method
```

What happens to our variables each time the block is executed?
Especially of interest in this example are the `temperature` and `method`
variables.

In this case we see that the block variable `temperature` "shadows" the
outer variable of the same name within the block. But what happens to
`temperature` after the block is done?

And what about `method`? How does it change during the execution of the
block?

The ability of blocks to refer to surrounding local variables is
powerful, but it can also be potentially dangerous. We should to pay close
attention to what variables we modify within a block to avoid
accidentally modifying the wrong thing.

## Independent Practice 
![Scope Playground](https://docs.google.com/drawings/d/e/2PACX-1vRH4j8dzxyHxgLgOQ2x6JSOuEQb32cMKZvuQRMjbLPrXAM9lx47qVrdL7ddPnI11hhZsr3vnQKZfyfa/pub?w=954&h=770) 

Make a T-chart for each method.   
What does it have access to? What does it not have access to?   
Turn to a neighbor and explain why or why not.   

## Summary

* Define scope in your own words
* What are some of the benefits of scope?
* What will the following code snippet output?

```ruby
def doubler(x)
  doubled = x * y
  puts doubled
end

def y
  2
end

x = 4

doubler(x)
```

## Video

[Video](https://vimeo.com/129376008)
