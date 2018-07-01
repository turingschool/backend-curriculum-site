---
page: layout
title: Methods, Arguments, Blocks, and Scopes
length: 90
tags: methods, scopes, arguments, ruby
---

## Learning Goals

* Define scope
* Predict how variables will behave when multiple scopes are involved
* Be able to debug scope issues

## Vocabulary
* Scope
* Local Variable
* Global Scope
* Method Scope
* Block Scope

# Lesson

**Scope** - What you have access to and where you have access to it.

Scope is the kind of thing that you think you don't need to know until it starts causing you trouble. Even then, it is generally unnecessary to know the rules of how scope works in Ruby. It's more important that when you see unexpected behavior, that scope of your variables/method names is one of the things on your list to check.

While you are working through these activities, copy and paste the code rather than typing it. It is important to discuss with your partner what you think will happen before you run each code snippet.

## Global Scope

Create a file called `scope.rb` on your machine and add the following code:

```ruby
  x = 10
  puts x
```

**Turn and Talk**: What output do you expect to see when you run this file?

Run the file (`ruby scope.rb`) and see if your expectations were correct.

In this example, `x` is functioning as a **local variable**. We created it using the **assignment operator** `=`.

So far we have not created any additional **scopes** such as classes, methods, blocks, etc. We refer to this as **global scope**. `x` is currently defined in the **global scope**. This is also sometimes referred to as "top-level scope".

Now change the code to this:

```ruby
  x = 10
  puts x
  puts y
```

**Turn and Talk**: What output do you expect to see when you run this file?

<br>
<br>

You should see output similar to this:

```
scope.rb:3:in `<main>': undefined local variable or method `y' for main:Object (NameError)
```

It's important to note that your errors could look different depending on certain factors such as what version of Ruby you are running. The information could be in a different order, or it could use slightly different wording.

Error messages like these can be very intimidating. Let's break this down:

`scope.rb:3` is telling you the line where the error occurred. Ruby tried to execute that line and encountered an error.

`in <main>` is telling you what method was executing when the error occurred. Since we didn't put our code in a method, we say it was executing in the `main` method.

These two pieces of information are giving you *context* for where and when the error occurred.

`undefined local variable or method 'y' for main:Object (NameError)` is your actual error.

`undefined local variable or method 'y'` means that Ruby tried to find something called `y`, but couldn't find anything. It doesn't know what `y` is.

`for main:Object` is the **Scope** where Ruby tried to look for `y`. This `main:Object` scope is the **Global Scope**.

`(NameError)` is the technical name for the error that occurred. It's not quite as useful as the other information.

**Turn and Talk**: In your own words, what is this output telling you?

There are two ways to fix an error like this. We either need to make a **local variable** or method `y`, or we need to remove that call to `y`. Let's try the former. Create a **local variable** `y` like this:

```ruby
  x = 10
  puts x
  y = 20
  puts y
```

**Turn and Talk**: What output do you expect to see when you run this file?

Now let's create a method `y`. Change your code to this:

```ruby
  x = 10
  puts x
  def y
    20
  end
  puts y
```

**Turn and Talk**: What output do you expect to see when you run this file?

Remember the original error that you saw when y wasn't defined? It said undefined local variable or method 'y'. From Ruby's perspective looking up a variable or looking up a method are very similar things (though there are differences we will get into below!). Here, we're using a method named y instead of a variable named y. The method only has one line, and since methods return their last line in Ruby, the value (20) is what is being returned from that method.

It's also important to note that Ruby reads your file sequentially. Change your code to this:

```ruby
  x = 10
  puts x
  puts y
  y = 20
```

**Turn and Talk**: What output do you expect to see when you run this file?

**Check for Understanding**:

* What is **scope**?
* What is a **local variable**?
* How do you create a **local variable**?
* What is **global scope**?
* In your own words, what is `vehicle.rb:29:in '<main>': undefined local variable or method 'start' for main:Object (NameError)` telling you?

## Method Scopes

Change `scope.rb` to this:

```ruby
  def print_variable
    x = 4
    puts x
  end

  print_variable
```

**Turn and Talk**: What output do you expect to see when you run this file?

Now change `scope.rb` to this:

```ruby
  def print_variable
    x = 4
    puts x
  end

  x = 2
  print_variable
```

**Turn and Talk**: What output do you expect to see when you run this file?

In this example, there are *two different* local variables called `x`. One of them is defined in the **global scope** on line 6: `x = 2`. The other one is defined inside the `print_variable` method on line 2: `x = 4`, in the **method scope**.

**method scopes** are independent from surrounding scopes. Local variables defined within the **method scope** are not available in surrounding scopes, and local variables defined in surrounding scopes are not available within the **method scope**.

In this example, the **method scope** of the `print_variable` method is independent from the surrounding **global scope**. This means that local variables defined in the **global scope** cannot be seen in the `print_variable` method, and vice versa.

Remember, what is important here is that you get a feel for where variables are available to you. You don't need to be able to quote the intricacies of scope verbatim.

To Illustrate this, change `scope.rb` to this:

```ruby
  def print_variable
    puts x
  end

  x = 2
  print_variable
```

**Turn and Talk**: What output do you expect to see when you run this file?

Now, change `scope.rb` to this:

```ruby
  def print_variable
    x = 4
    puts x
  end

  print_variable
  puts x
```

**Turn and Talk**: What output do you expect to see when you run this file?

How does this apply to arguments? Change `scope.rb` to this:

```ruby
  def print_variable(x)
    puts x
  end

  x = 4
  print_variable(x)
```

**Turn and Talk**: What output do you expect to see when you run this file?

This is very similar. There are *two different* `x`s in this example, except this time instead of creating a local variable inside the method using the **assignment operator** `=`, we are creating it using an **argument**. They both behave the same way.


Just like before, that argument is only available in the **method scope** of the `print_variable` method.

To Illustrate this, change `scope.rb` to this:

```ruby
  def print_variable(x)
    puts x
  end

  print_variable(2)
  puts x
```

**Turn and Talk**: What output do you expect to see when you run this file?

What about other methods? Change `scope.rb` to this:

```ruby
  def print_variable
    puts x
  end

  def x
    2
  end

  print_variable
```

**Turn and Talk**: What output do you expect to see when you run this file?

Methods behave differently than variables. **Method scope** doesn't prevent you from accessing other methods that are defined in the same scope. This example works because both of these methods are defined in the **global scope**

**Check for Understanding**:

* What is **method scope**?
* When you define a method, what variables do you have access to within that method?
* When you define a method, what methods do you have access to within that method?
* When you create a variable inside a method, where do you have access to that variable?
* If you have a method

```ruby
def cook_pizza(toppings)
  #code
end
```
where do you have access to `toppings`?

## Block Scope

We now know that methods create method scopes which which are independent from their parent scope. How does this apply to **block scope**?

Change `scope.rb` to this:

```ruby
greeting = "Hello World!"
numbers = [1,2,3]
numbers.each do |number|
  puts greeting
end
```

**Turn and Talk**: What output do you expect to see when you run this file?

This is behaving different from the method scope. **Block scope** CAN access variables from a surrounding scope.

Change `scope.rb` to this:

```ruby
numbers = [1,2,3]
numbers.each do |number|
  farewell = "Goodbye!"
end
puts farewell
```

**Turn and Talk**: What output do you expect to see when you run this file?

Just like with method scope, **block scope** does not allow other scopes to access variables created within the **block scope**. Here we are trying to access the `farewell` variable in the global scope, but it was created in the **block scope**.

What about the **block variable** `number`? The **block variable** functions very similarly to a method argument — each time the block is executed, a new value will be supplied for `number`. Let's see if it behaves the same way in terms of scope.

Change `scope.rb` to this:

```ruby
numbers = [1,2,3]
numbers.each do |number|
  farewell = "Goodbye!"
end
puts number
```

**Turn and Talk**: What output do you expect to see when you run this file?

Now we are going to experiment a bit. Normally, we don't want to have multiple variables named the same to avoid confusion, but in the following examples we are going to try it just to see what happens. Remember, the goal is to get a feel for how scope works in Ruby. Try this:

```ruby
numbers = [1,2,3]
number = 0
numbers.each do |number|
  puts number
end
```

**Turn and Talk**: What output do you expect to see when you run this file?

What about this?

```ruby
numbers = [1,2,3]
numbers.each do |number|
  number = 0
  puts number
end
```

**Turn and Talk**: What output do you expect to see when you run this file?

Or this?

```ruby
numbers = [1,2,3]
def number
  0
end
numbers.each do |number|
  puts number
end
```

**Turn and Talk**: What output do you expect to see when you run this file?

**Check for Understanding**

* What is **block scope**?
* Compare and contract **block scope** with **method scope**

## Objects

Change `scope.rb` to this:

```ruby
class Person
  def greeting
    "Hello!"
  end
end

person = Person.new
puts person.greeting
```

**Turn and Talk**: What output do you expect to see when you run this file?


Change `scope.rb` to this:

```ruby
class Person
  def greeting
    "Hello!"
  end
end

greeting
```

**Turn and Talk**: What output do you expect to see when you run this file?

The `greeting` method is not available in the global scope. When you create a class, only an instance of that class can call that method. That is why the previous example worked, but this one did not.

Use what you've learned about scope to predict the output of the following examples.

Change `scope.rb` to this:

```ruby
class Person
  def greeting
    name = "Bob Ross"
    "Hello, my name is " + name
  end
end

person = Person.new
puts person.greeting
```

**Turn and Talk**: What output do you expect to see when you run this file?

Change `scope.rb` to this:

```ruby
class Person
  def greeting
    name = "Bob Ross"
    "Hello, my name is " + name
  end
end

person = Person.new
puts person.greeting
puts name
```

**Turn and Talk**: What output do you expect to see when you run this file?


Change `scope.rb` to this:

```ruby
class Person
  def greeting
    "Hello, my name is " + name
  end
end

name = "Bob Ross"
person = Person.new
puts person.greeting
```

**Turn and Talk**: What output do you expect to see when you run this file?

Change `scope.rb` to this:

```ruby
class Person
  def greeting(name)
    "Hello, my name is " + name
  end
end

name = "Bob Ross"
person = Person.new
puts person.greeting(name)
```

**Turn and Talk**: What output do you expect to see when you run this file?

**Check for Understanding**:

* How does scope apply to objects?
* How might scope relate to Minitest files?

## Conclusion

Scope is a pretty complicated topic, especially in Ruby. While it's not important to know every rule of scope, it is important to know when you create a variable or method, where you have access to it, and what it has access to. Scope can also get much more complicated when you have many things named the same, so the easiest solution is to give each thing its own unique name.
