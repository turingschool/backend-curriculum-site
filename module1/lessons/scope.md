---
page: layout
title: Scope
length: 90
tags: methods, scopes, arguments, ruby
---

## Learning Goals

* Define scope
* Understand scope as it relates to local variables, methods, and instance variables
* Predict how variables will behave when multiple scopes are involved
* Be able to debug scope issues

## Vocabulary
* Scope
* Local Variable
* Method
* Instance Variable
* Global Scope
* Method Scope
* Block Scope
* Class Scope

## Warmup

Have you ever written code in one place, but have had trouble accessing it? What are some ways to solve those problems?

# Intro

**Scope** is what you have access to and where you have access to it.

Scope is the kind of thing that you think you don't need to know until it starts causing you trouble. Even then, it is generally unnecessary to know the rules of how scope works in Ruby. It's more important that when you see unexpected behavior, that scope of your variables/method names is one of the things on your list to check.

Today, we will be exploring several different elements of Ruby that have different scopes:

* Local Variables
* Methods
* Instance Variables

While you are working through these activities, copy and paste the code rather than typing it. It is important to discuss with your partner what you think will happen before you run each code snippet.

## Local Variables

When you create a variable like `x = 4`, you are creating a **local variable**. You create it using the **assignment operator** `=`. Local variables are available in whatever scope you define them. That's what local means in this context. It is local to where you define it. We will go through several different scopes where you could define a local variable:

* A **Method Scope**
* A **Block Scope**
* The **Global Scope**

Remember, the key to understanding how the local variable will behave is that **local variables are LOCAL to whatever scope you define them in**

## Exploration - Part 1

Work through the following examples with a partner. For each example, copy and paste the code into a playground.rb file rather than typing it to save time. Take a moment to examine the code individually, and then discuss with your partner what you think the output will be. Once you've had a moment to discuss, run the code and check your predictions. If your predictions were right or wrong, make sure to take a minute and try to make sense of and explain why the outcome was what it was.

Remember, what is important here is that you get a feel for where variables are available to you. You don't need to be able to quote the intricacies of scope verbatim. Some of these examples get weird and do things that you just shouldn't do... but we're going to do them and see what happens.

[View Global Scope Examples 1-5 Here](https://gist.github.com/megstang/1c51aa919cc082e9c3ceb1114cc57747)

### Global Scope - Part 1 Debrief

Let's look at this code:

```ruby
x = 10
puts x
```

Every time you create a class, method, or block you create a new **scope**. Anything that is not inside one of those is in a default scope known as the **global scope** (sometimes referred to as "top-level scope"). Every program has exactly 1 **global scope**. Since we will almost always write code that is contained in a class or method, working in the **global scope** is rare, but it does happen.

`x` is currently defined in the **global scope**, so it is available in the global scope (and nowhere else).


## Exploration - Part 2

[View Method Scope Examples 6-9 Here](https://gist.github.com/megstang/e239c2dd61704e404f7c323416a97db7)

### Method Scope - Part 2 Debrief

If we create a method, we are creating a new scope called a **method** scope:

```ruby
x = 10
def print_variable
  puts x
end
print_variable
```

Remember, local variables are local to whatever **scope** you define them in. Because `x` is defined in the global scope, trying to call it in the `print_variable` **method scope** will throw an error. This works the other way around:

```ruby
def print_variable
  x = 10
  puts x
end
print_variable
puts x
```

When `x` is defined in the **method scope**, it is not available in the **global scope**.

It's also important to note that Ruby reads through a scope sequentially. So if something hasn't been defined in the scope before you try to call it, it will throw an error:

```ruby
puts x
x = 10
```

## Exploration - Part 3

[View Argumet Scope Examples 10-13 Here](https://gist.github.com/megstang/258b44b1ceb30d22d1df7a0c39bb0d63)

### Arguments - Part 3 Debrief

An argument implicitly creates a local variable. So if you define an argument on a method, you are essentially creating a local variable.

```ruby
def print_variable(x)
puts x
end

print_variable(4)
```

The argument `x` on the `print_variable` method creates a local variable inside that method. When we call `print_variable(4)`, we are giving that variable `x` the value of `4`. It is as if `x = 4` is happening in the background.

Arguments allow us to pass data between scopes.

## Exploration - Part 4

[View Block Scope Examples 14-19 Here](https://gist.github.com/megstang/b2a97b1151facb99ac01e6811f49cb25)

### Block Scope - Part 4 Debrief

**Block Scope** refers to what is available inside a block (everything between the `do` and `end`). Remember what we've been saying: **local variables** are local to wherever you define them. But blocks are special. Blocks *DO* allow you to access variables created outside of them, however, they work the same as methods in that any local variable created *inside* the block is local to the block. This applies to the block variable as well. You can think of a block variable like an argument to the block.

```ruby
numbers = [1,2,3]
total = 0
numbers.each do |number|
  greeting = "hello"
  total += number
end

p total
```

In this example, we'll see that even though we created `total` outside the block, it is still available inside the block. However, if we try to print the variable `greeting` or the block variable `number` after the block we will get an error.

A block is a type of **closure**. It encloses the surrounding variables. That isn't essential information, but it's nice to know.

## Methods

In the previous activity, we learned that methods create a scope called the **method scope**. But methods also have a scope (where you can and can't call a method). Methods behave similarly to local variables in that **methods are available in whatever scope you define them in**. However, methods have one additional special ability: **methods are available to other methods in the same scope**. This is sometimes referred to as the "sister scope".

## Methods in the Global Scope

Let's revisit our example from earlier. Change `scope.rb` to the following, run the file, and examine the error.

```ruby
x = 10
puts x
puts y
```

The error is undefined local variable *or* method `y`. From Ruby's perspective looking up a variable or looking up a method are very similar things. Before we defined a local variable to fix this problem. Let's define a method:

```ruby
def y
20
end
puts y
```

But just like with local variables, methods need to have been defined in the scope before you call them:

```ruby
puts y
def y
  20
end
```

This will throw an error because when we call `y` on line 1, `y` hasn't been defined yet.

Methods can call other methods in the same scope:


```ruby
def print_variable
  puts y
end

def y
  20
end

print_variable
```

This is how calling a method is different than calling a local variable. The above example works, but if we change `y` to a local variable:

```ruby
def print_variable
  puts y
end

y = 20

print_variable
```

It will throw an error.

### Class Scope

**Class Scope** is another kind of scope that refers to what is available in a class (everything in between the `class` and its corresponding `end`). Just like with methods defined in the global scope, methods defined in a class have access to the other methods in that class:

```ruby
class Person
  def greeting
    "Hello! My name is #{name}"
  end

  def name
    "Bob Ross"
  end
end

person = Person.new
puts person.greeting
```

In this example, the `name` method can be called from the `greeting` method because they are both defined in the `Person` class. You can't call a method defined in a class from outside the class:

```ruby
class Person
  def greeting
    "Hello! My name is #{name}"
  end

  def name
    "Bob Ross"
  end
end

person = Person.new
puts greeting
```

## Instance Variables

Instance variables are available within the class scope. This includes any methods within the class:

```ruby
class Person
  def initialize(name)
    @name = name
  end

  def greeting
    "Hello! My name is #{@name}"
  end
end

person = Person.new("Bob Ross")
p person.greeting
```

Contrast this with the following example where we try to access an instance variable defined in the class outside of the class, and vice versa:

```ruby
class Person
  def initialize(name)
    @name = name
  end

  def greeting
    "Hello! My name is #{@name}. I am a #{@job}."
  end
end

@job = "Painter"
person = Person.new("Bob Ross")
p person.greeting
p @name
```

Notice that unlike local variables and methods, when an instance variable is out of scope, Ruby won't give you an error. Instead, that instance variable will default to `nil`. This can be very dangerous.

## Turn & Talk

* What is scope?
* For each of the following types of scope, what are the Ruby keywords that begin and end the scope?
  * Method Scope
  * Block Scope
  * Class Scope
  * Global Scope

## Activity

Clone [this repository](https://github.com/turingschool-examples/scope_exercise)

Follow the instructions in the README.

### Exit Ticket

You'll have 10 minutes to complete the exit ticket independently.

## Conclusion

Scope is a pretty complicated topic, especially in Ruby. While it's not important to know every rule of scope, it is important to know when you create a variable or method, where you have access to it, and what it has access to. Scope can also get much more complicated when you have many things named the same, so the easiest solution is to give each thing its own unique name.
