---
title: Memory Allocation
tags: ruby, memory, computer science
---

## Learning Goals
* Develop a mental model for how memory works
* Explain how memory works in Ruby

## What is Memory?

Computers need to be able to memorize something for the same reason that humans do: because they will need to access it later.

In some ways, computer memory is better than human memory. When the computer memorizes something, it won't forget it until we tell it to. You've never tried to open a saved document on your computer and it told you that it forgot it. Humans on the other hand forget things all the time.

But computer memory is also a lot less advanced than human memory because computers can't make connections. Humans make connections automatically ("Oh, that reminds me of this time...", "That smells just like my grandma's recipe..."). Computer's need to be told explicitly what memories are connected and how. That's what our code is for.

## Activity 1: Objects in Memory

Memory is a lot like a column on a spreadsheet. There's many cells in that column for us to write whatever we want in there (let's pretend like formulas don't exist for this activity). Those cells also have a unique identifier. For example, the first cell in the second column of a spreadsheet is labeled B1. Memory works very similarly. It is a long list of cells for us to store things in, and we can look up those cells with a unique identifier that is called the **Memory Address**.

In order to illustrate this, you are going to create a spreadsheet as an analogy to what is happening in the computer. Head to [Google Drive](https://drive.google.com/) and create a new spreadsheet by clicking on the "New" button in the top left, then click on Google Sheets. When your new sheet opens, click on the blue "Share" button in the top right of the Sheet, name your Sheet "Memory Allocation", and in the new window click on "Get shareable link". At the end of this activity, you will submit that link to your instructors.

In cell A1, type the header "variable", in cell B1, type the header "memory address", and in cell C1, type the header "memory". Make these headers bold. Column C is our memory. Each cell represents a chunk of memory for us to store things in. Column B will hold the memory address that uniquely identifies that chunk of memory. Column A hold the variable name that we use in our Ruby program to reference that memory.

Create a new file called `memory.rb` and add this code to it:

```ruby
class Taco
  attr_accessor :type
  def initialize(type)
    @type = type
  end
end

taco_1 = Taco.new("Al Pastor")
taco_2 = Taco.new("Carnitas")

puts "taco_1 memory address is #{taco_1.object_id}"
puts "taco_1 value is #{taco_1.inspect}"

puts "taco_2 memory address is #{taco_2.object_id}"
puts "taco_2 value is #{taco_2.inspect}"
```

You should see output similar to this:

```
taco_1 memory address is 70135104802680
taco_1 value is #<Taco:0x00007f9334041ef0 @type="Al Pastor">
taco_2 memory address is 70135104802660
taco_2 value is #<Taco:0x00007f9334041ec8 @type="Carnitas">
```

In cell A2 of your sheet, put "taco_1" for the variable name. Copy and paste the memory address that was printed out and put it in cell B2. In cell C2, copy and paste the entire value printed out for taco_1.inspect. In the example above, it would be `#<Taco:0x00007f9334041ef0 @type="Al Pastor">`. Do the same for taco_2. Your Sheet should look something like this:

![Imgur](https://i.imgur.com/OCUSw1O.png)

`#<Taco:0x00007f8129061880 @type="Al Pastor">` means "A Taco Object". It also shows us the value of the object's instance variables. Don't worry too much about the Hexadecimal number that is printed after the colon. All you need to know is that it is very similar to the memory address, uniquely identifying the Object.

In this example, we have created two different Taco Objects, or "Instances of the Taco Class". In order to hold these two different values, Ruby has set aside two completely separate boxes of memory to hold our data. These boxes of memory are represented in column C. Notice that in our spreadsheet, two different rows are taken up, indicating two cells of memory. Setting aside memory for us to use is called **Memory Allocation**.

Column B represents the memory addresses that uniquely identify those spaces of memory. The actual values of the memory addresses are unimportant, but what is important is that the memory addresses are unique for each row, each box of memory.

Column A represents the variable names that we use in Ruby to reference those spaces in memory. If we wanted to get the first Taco Object in this example, we wouldn't say "Hey Ruby, get me the object stored in memory address 70096357887040". We say, "Hey Ruby, get me the object stored in `taco_1`". Variables give us access to Objects stored in memory.

Now let's see what happens when the two variables hold the same data. Change your code to this:

```ruby
class Taco
  attr_accessor :type
  def initialize(type)
    @type = type
  end
end

taco_1 = Taco.new("Al Pastor")
taco_2 = Taco.new("Al Pastor")

puts "taco_1 memory address is #{taco_1.object_id}"
puts "taco_1 value is #{taco_1.inspect}"

puts "taco_2 memory address is #{taco_2.object_id}"
puts "taco_2 value is #{taco_2.inspect}"
```

**Turn and Talk**: Do you expect the two Tacos to have different memory addresses?

<br />
<br />
<br />
<br />
<br />
<br />
<br />

Run this code, and you'll notice that even though `taco_1` and `taco_2` have the same value, they each have unique object id's. This is illustrating what it really means to be an "Object" or "Instance" in Ruby (remember, these words mean the same thing). Despite their identical values, they are separate entities.

Update your Sheet's cell C3 with the new value for `taco_2`.

Run this code a couple more times and notice that the memory addresses are different every time. So it doesn't really matter what the exact memory address is. What is important is that each time this code is run, Ruby is allocating two unique spaces in memory to hold our data.

At this point, we've determined that Ruby is allocating memory for each of these objects. But what can we do with those spaces in memory? Can we change what they hold? Let's try it. Change your code to this:


```ruby
class Taco
  attr_accessor :type
  def initialize(type)
    @type = type
  end
end

taco_1 = Taco.new("Al Pastor")
taco_2 = Taco.new("Al Pastor")

puts "taco_1 initial memory address is #{taco_1.object_id}"
puts "taco_1 initial value is #{taco_1.inspect}"

taco_1.type = "Carnitas"

puts "taco_1 new memory address is #{taco_1.object_id}"
puts "taco_1 new value is #{taco_1.inspect}"
```

**Turn and Talk**: Do you expect `taco_1` to have a different memory address after we change the `type`?

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

Compare the initial memory_address and the new memory_address and notice that they are exactly the same! Not only can Ruby set aside these boxes of memory, but we can also change what is inside them. Update your Sheet's row for `taco_1` with the new value being stored in memory after we change the `type`.

Let's make a slight change to the code. Instead of setting the `type` with the assignment operator `=`, we are going to use `.new`:

```ruby
class Taco
  attr_accessor :type
  def initialize(type)
    @type = type
  end
end

taco_1 = Taco.new("Al Pastor")
taco_2 = Taco.new("Al Pastor")

puts "taco_1 initial memory address is #{taco_1.object_id}"
puts "taco_1 initial value is #{taco_1.inspect}"

taco_1 = Taco.new("Carnitas")

puts "taco_1 new memory address is #{taco_1.object_id}"
puts "taco_1 new value is #{taco_1.inspect}"
```

**Turn and Talk**: Do you expect `taco_1` to have a different memory address after the `.new`?

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />


Compare the initial memory address and the new memory address and notice that they are NOT the same! Instead of using that box of memory that we already allocated for `taco_1`, Ruby sliced out a new chunk of memory to put the new Taco Object. Why did this behave different? The key is that we called `.new`. Every time you call `.new`, Ruby allocates a new chunk of memory for a newly instantiated object.

Because Ruby allocated a new space of memory, we need a new row in our Sheet. In cell A4, put the variable name `taco_1`. In cell B4, put the new memory address that was printed out. In cell C4, put the new value being stored in that space of memory.

Your sheet should now have two variables named `taco_1`, so which one will Ruby use? You have probably come across this a couple times in your code. When we reassign a variable, the old value is lost because we no longer have a variable to reference it. It goes poof, into the ether of the computer. The technical term for this is that the old memory is **garbage collected**. Delete row 2 from your Sheet to simulate the garbage collection. Your Sheet should look like this:

![Imgur](https://i.imgur.com/jHW2VFO.png)


**Check for Understanding**

Answer the following questions in your Sheet:

* What is Memory?
* What is Memory Allocation?
* What is a Memory Address?
* What is an Object in terms of memory?
* What is a variable?
* What happens when we call `.new`?
* What is garbage collection?

## Activity 2: Objects in Objects

We've started to get a feel for how Ruby works with memory. Let's now dive a little deeper and see what happens when we use multiple classes. Create a new tab in your Sheet by clicking on the `+` icon in the lower left corner of your Sheet. Add the variable, memory_address, and memory headers just like in the first activity.

Change your `memory.rb` file to this:


```ruby
class Taco
  attr_accessor :filling

  def initialize(filling)
    @filling = filling
  end
end

class Filling
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

spicy_sausage = Filling.new("Chorizo")
taco_1 = Taco.new(spicy_sausage)

puts "taco_1 memory address is #{taco_1.object_id}"
puts "taco_1's value is #{taco_1.inspect}"

puts "@filling memory address is #{taco_1.filling.object_id}"
puts "@filling value is #{taco_1.filling.inspect}"

puts "spicy_sausage memory address is #{spicy_sausage.object_id}"
puts "spicy_sausage's value is #{spicy_sausage.inspect}"
```

**Turn and Talk**: Will `@filling` have the same memory address as `spicy_sausage`?

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

Run this code and you should see output like this:

```
taco_1 memory address is 70159993816600
taco_1's value is #<Taco:0x00007f9ecb048c30 @filling=#<Filling:0x00007f9ecb048c58 @name="Chorizo">>
@filling memory address is 70159993816620
@filling value is #<Filling:0x00007f9ecb048c58 @name="Chorizo">
spicy_sausage memory address is 70159993816620
spicy_sausage's value is #<Filling:0x00007f9ecb048c58 @name="Chorizo">
```

Notice that the memory addresses for `@filling` and `spicy_sausage` are the same! Even though this Filling object is being stored in two different places in our code, it is still only one object in memory.

Update your Sheet with the variable names, memory addresses, and values in memory. You should have one row for the Taco object, and one row for the Filling object. Because both `spicy_sausage` and the Taco's instance variable `@filling` are referencing the same Filling object, you should have two entries in the column for the variable that references the Filling object (separate them with a comma). Your Sheet should look something like this:

![Imgur](https://i.imgur.com/jVCFG64.png)

This is a very important concept: we can access the same object stored in memory through many different variables. We say that we have two different **pointers** to the same Object. In this case, there is only one memory location storing the Filling, but there are two variables that can access it.

So if these two different variables are pointing to the same spot in memory, if we change one, do we change the other? Let's try it:

```ruby
class Taco
  attr_accessor :filling

  def initialize(filling)
    @filling = filling
  end
end

class Filling
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

spicy_sausage = Filling.new("Chorizo")
taco_1 = Taco.new(spicy_sausage)

puts "Initial value of spicy_sausage is #{spicy_sausage.inspect}"
puts "Initial value of @filling is #{taco_1.filling.inspect}"

taco_1.filling.name = "Carne Asada"

puts "New value of spicy_sausage is #{spicy_sausage.inspect}"
puts "New value of @filling is #{taco_1.filling.inspect}"
```

**Turn and Talk**: Will changing `taco_1.filling.name` change `spicy_sausage`?

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

Run this code and you will see that changing `taco_1.filling.name` changed `spicy_sausage.name`. This can be a very intimidating concept at first, but it is very important. These variable names are ways of referencing Objects that live in memory. You can have many different variable names that reference the same Object. When we change an Object, all the variables that point to it will see the change.

In your Sheet, update cell C3 with the new value for `spicy_sausage` AND `@filling`. Your sheet should look like this:

![Imgur](https://i.imgur.com/I6cQ5Zj.png)

Notice how you only changed one space of memory, but you affected both variables that point to it.

**Check for Understanding**

Answer the following questions in your Sheet based on this code:

```ruby
class Car
  attr_accessor :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end
end

class Person
  attr_accessor :car

  def initialize(car)
    @car = car
  end
end

camry = Car.new("Toyota", "Camry")
person = Person.new(camry)
```

* How many Car Objects are created?
* How many Person Objects are created?
* How many different variables point to the Car Object?
* How many different variables point to the Person Object?
* If we called `person.car.model = "Rav 4"`, what would you see if you printed the variable `camry`?
* If we called `camry.make = "Honda"`, what would you see if you printed `person.car`?
* If we called `camry = Car.new("Honda", "Civic")`, what would you see if you printed `person.car`?
