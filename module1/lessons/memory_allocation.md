---
title: Memory Allocation
tags: ruby, memory, computer science
---

## What is Memory?

Computers need to be able to memorize something for the same reason that humans do: because they will need to access it later.

In some ways, computer memory is better than human memory. When the computer memorizes something, it won't forget it until we tell it to. You've never tried to open a saved document on your computer and it told you that it forgot it. Humans on the other hand forget things all the time.

But computer memory is also a lot less advanced than human memory because computers can't make connections. Humans make connections automatically ("Oh, that reminds me of this time...", "That smells just like my grandma's recipe..."). Computer's need to be told explicitly what memories are connected and how. That's what our code is for.

## Activity 1: Memorizing Strings

Memory is a lot like a column on a spreadsheet. There's many cells in that column for us to write whatever we want in there (let's pretend like formulas don't exist for this activity). Those cells also have a unique identifier. For example, the first cell in the second column of a spreadsheet is labeled B1. Memory works very similarly. It is a long list of cells for us to store things in, and we can look up those cells with a unique identifier that is called the **Memory Address**.

In order to illustrate this, you are going to create a spreadsheet as an anology to what is happening in the computer. Head to [Google Drive](https://drive.google.com/) and create a new spreadsheet by clicking on the "New" button in the top left, then click on Google Sheets. When your new sheet opens, click on the blue "Share" button in the top right of the Sheet, name your Sheet "Memory Allocation", and in the new window click on "Get shareable link". At the end of this activity, you will submit that link to your instructors.

In cell A1, type the header "variable", in cell B1, type the header "memory address", and in cell C1, type the header "memory". Make these headers bold. Column C is our memory. Each cell represents a chunk of memory for us to store things in. Column B will hold the memory address that uniquely identifies that chunk of memory. Column A hold the variable name that we use in Ruby to reference that memory.

Create a new file called `memory.rb` and add this code to it:

```ruby
string_one = "hello"
string_two = "goodbye"

puts "string_one memory address is #{string_one.object_id}"
puts "string_one value is #{string_one.inspect}"

puts "string_two memory address is #{string_two.object_id}"
puts "string_two value is #{string_two.inspect}"
```

Run this code. You should see two different memory addresses printed out (we are using the method `object_id` to get the object's memory address). In cell A2 in your Sheet, put the variable name `string_one`. In cell B2, put the memory address for string_one that was printed out. In cell C2, put the value that was printed out (include the quotes). Do the same for `string_two`. Your Sheet should look like this, with different memory addresses:

![Imgur](https://i.imgur.com/mcegzwT.png)

In this example, we have created two different String Objects, or "Instances of the String Class". In order to hold these two different values, Ruby has set aside two completely separate boxes of memory to hold our data. These boxes of memory are represented in column C. Notice in our spreadsheet the two different rows being taken up, indicating two cells of memory. Setting aside memory for us to use is called **Memory Allocation**.

Column B represents the memory addresses that uniquely identify those spaces of memory. The actual values of the memory addresses are unimportant, but what is important is that the memory addresses are unique for each row, each box of memory.

Column C represents the variable names that we use in Ruby to reference those spaces in memory. If we wanted to get the value "hello" in this example, we wouldn't say "Hey Ruby, get me the object stored in memory address 70125675941940". We say, "Hey Ruby, get me the object stored in `string_one`". Variables give us access to Objects stored in memory.

Now let's see what happens when the two variables hold the same data. Change your code to this:

```ruby
string_one = "hello"
string_two = "hello"

puts "string_one memory address is #{string_one.object_id}"
puts "string_one value is #{string_one.inspect}"

puts "string_two memory address is #{string_two.object_id}"
puts "string_two value is #{string_two.inspect}"
```

**Turn and Talk**: Do you expect the two strings to still have different memory addresses?

<br />
<br />
<br />
<br />
<br />
<br />
<br />

Run this code, and you'll notice that even though `string_one` and `string_two` have the same value, they each have unique object id's. This is illustrating what it really means to be an "Object" or "Instance" in Ruby (remember, these words mean the same thing). Despite their identical values, they are separate entities.

Update your Sheet's cell C3 with the new value for `string_two`.

Run this code a couple more times and notice that the memory addresses are different every time. So it doesn't really matter what the exact memory address is. What is important is that each time this code is run, Ruby is allocating two unique spaces in memory to hold our data.

At this point, we've determined that Ruby is allocating memory for each of these strings. But what can we do with those spaces in memory? Can we change what they hold? Let's try it. Change your code to this:


```ruby
string_one = "hello"
string_two = "hello"

puts "string_one initial memory address is #{string_one.object_id}"
puts "string_one initial value is #{string_one.inspect}"

string_one << " world"

puts "string_one new memory address is #{string_one.object_id}"
puts "string_one new value is #{string_one.inspect}"
```

**Turn and Talk**: Do you expect `string_one` to have a different memory address after the shovel?

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

Compare the `string_one` initial memory_address and the new memory_address and notice that they are exactly the same! Not only can Ruby set aside these boxes of memory, but we can also change what is inside them. Update your Sheet's row for `string_one` with the new value being stored in memory after the shovel.

Let's make a slight change to the code. Instead of using the shovel `<<`, let's create the string "hello world" using the assignment operator `=`.

```ruby
string_one = "hello"
string_two = "hello"

puts "string_one initial memory address is #{string_one.object_id}"
puts "string_one initial value is #{string_one.inspect}"

string_one = "hello world"

puts "string_one new memory address is #{string_one.object_id}"
puts "string_one new value is #{string_one.inspect}"
```

**Turn and Talk**: Do you expect `string_one` to have a different memory address after the assignment?

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />


Compare the `string_one` initial memory address and the new memory address and notice that they are NOT the same! Instead of using that box of memory that we already allocated for string_one, Ruby sliced out a new chunk of memory to put the new value of `"hello world"`. Why did this behave different than the shovel? The key is that we used the assignment operator `=`. Every time you use the assignment operator `=`, Ruby allocates a new chunk of memory to be used.

Because Ruby allocated a new space of memory, we need a new row in our Sheet. In cell A4, put the variable name `string_one`. In cell B4, put the new memory address that was printed out. In cell C4, put the new value being stored in that space of memory.

Your sheet should now have two variables named `string_one`, so which one will Ruby use? You have probably come across this a couple times in your code. When we reassign a variable, the old value is lost because we no longer have a variable to reference it. It goes poof, into the ether of the computer. The technical jargon for this is that the old memory is "garbage collected". Delete row 2 from your Sheet. Your Sheet should look like this:

![Imgur](https://i.imgur.com/WYXk4wG.png)


**Check for Understanding**

Answer the following questions in your Sheet:

* What is Memory?
* What is Memory Allocation?
* What is a Memory Address?
* What is an Object in terms of memory?
* What is a variable?
* What happens when we use the assignment operator `=` in terms of memory allocation?

**Bonus Activities**:

* Does the behavior we saw in the activity apply to shortcuts that use the assignment operator like `+=`, `-=`, `*=`, etc? Update your code so that it changes `string_one` to `"hello world"` using `+=` instead of `=` and observe what happens.

* In the activity, we used the shovel `<<` operator to change an Object without changing where it was stored in memory. This is called a **mutating** method. Methods that change where the object is stored are called **nonmutating**. Research other **mutating** methods and see if you can recreate the behavior we observed with the shovel.

## Activity 2: Creating our own Objects

We've started to get a feel for how Ruby works with memory. Let's now dive a little deeper and see what happens when we create our own objects. Create a new tab in your Sheet by clicking on the `+` icon in the lower left corner of your Sheet. Change the names of these tabs to "Strings" and "Objects" respectively. To change the name, double click on the tab. Do the same setup you did for the Strings activity. Label Column A "variable", Column B "memory address", and Column C "memory".

Change your `memory.rb` file to this:

```ruby
class Taco
end

taco_1 = Taco.new
taco_2 = Taco.new

puts "taco_1 memory address is #{taco_1.object_id}"
puts "taco_1 value is #{taco_1.inspect}"

puts "taco_2 memory address is #{taco_2.object_id}"
puts "taco_2 value is #{taco_2.inspect}"
```

You should see output similar to this:

```
taco_1 memory address is 70135104802680
taco_1 value is #<Taco:0x00007f9334041ef0>
taco_2 memory address is 70135104802660
taco_2 value is #<Taco:0x00007f9334041ec8>
```

In cell A2 of your sheet, put "taco_1" for the variable name. Copy and paste the memory address that was printed out and put it in cell B2. In cell C2, copy and paste the entire value printed out for taco_1.inspect. In the example above, it would be `#<Taco:0x00007f9334041ef0>`. Do the same for taco_2. Your Sheet should look something like this:

![Imgur](https://i.imgur.com/4RXlrbH.png)

`#<Taco:0x00007f9334041ef0>` means "A Taco Object". Don't worry too much about the Hexadecimal number that is printed after the colon. All you need to know is that it is very similar to the memory address, uniquely identifying the Object.

This is behaving the same way as our Strings. Even though these two Tacos seem the same, they are taking up two different spots in memory. The difference is that instead of holding String objects, our memory is now holding Taco objects.

Let's make our Tacos a little more spicy. We are going to forget about the second Taco for now, so delete row 3 from your Sheet. Update your code to this:

```ruby
class Taco
  def initialize(filling)
    @filling = filling
  end
end

spicy_sausage = "Chorizo"
taco_1 = Taco.new(spicy_sausage)

puts "taco_1 memory address is #{taco_1.object_id}"
puts "taco_1 value is #{taco_1.inspect}"

puts "spicy_sausage memory address is #{spicy_sausage.object_id}"
puts "spicy_sausage value is #{spicy_sausage.inspect}"
```

Run this code and update your Sheet with the spicy_sausage variable name, memory address, and value in memory. Notice that the value printed out for `taco_1` now shows the instance variable `filling`. Update cell C2 with this new value stored in memory.

So the Taco object is somehow storing the value "Chorizo" in an instance variable, but we also have a variable called `spicy_sausage` that is also holding that value "Chorizo". So the question is, are there two different spaces in memory being allocated for the string "Chorizo"? Did our Taco object make a copy of the "Chorizo" string? Let's find out. Update your code to this:

```ruby
class Taco
  attr_reader :filling

  def initialize(filling)
    @filling = filling
  end
end

spicy_sausage = "Chorizo"
taco_1 = Taco.new(spicy_sausage)

puts "taco_1 memory address is #{taco_1.object_id}"
puts "taco_1's value is #{taco_1.inspect}"

puts "taco_1.filling memory address is #{taco_1.filling.object_id}"
puts "taco_1.filling value is #{taco_1.filling.inspect}"

puts "spicy_sausage memory address is #{spicy_sausage.object_id}"
puts "spicy_sausage's value is #{spicy_sausage.inspect}"
```

**Turn and Talk**: Will `taco_1.filling` have the same memory address as `spicy_sausage`?

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

Compare the two different memory addresses and notice that they are the same! Even though this string "Chorizo" is being stored in two different places in our code, it is still only one string in memory. So how do we update our Sheet? Since we know that the there is only one space of memory being taken up, we don't need to add a new row to our sheet. All we need to do is update cell A3 to not only have `spicy_sausage` as a variable name, but also `@filling`. Update your Sheet to look like this:

![Imgur](https://i.imgur.com/CsWH4FQ.png)

This is a very important concept: we can access the same object stored in memory through many different variables. We say that we have two different **pointers** to the same Object. In this case, there is only one memory location storing "Chorizo", but there are two variables that can access it.

Let's see if we get the same behavior when we create another class. Update your code to this:

```ruby
class Taco
  attr_reader :filling

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

puts "taco_1.filling memory address is #{taco_1.filling.object_id}"
puts "taco_1.filling value is #{taco_1.filling.inspect}"

puts "spicy_sausage memory address is #{spicy_sausage.object_id}"
puts "spicy_sausage's value is #{spicy_sausage.inspect}"
```

**Turn and Talk** Before you run the code, how might you have to update your Sheet?

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

Run this code and you will see the same behavior as with Strings. The `@filling` instance variable inside `taco_1` is pointing to the same spot in memory as the `spicy_sausage` variable. The only difference is that that spot in memory is holding a `Filling` object instead of a string. Update your Sheet's cell C3 with the new value for that `spicy_sausage` and `@filling` are pointing to. Update your Sheet's cell C2 for the new value that `taco_1` is pointing to.

So if these two different variables are pointing to the same spot in memory, if we change one, do we change the other? Let's try it:

```ruby
class Taco
  attr_reader :filling

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
puts "Initial value of taco_1's filling is #{taco_1.filling.inspect}"

taco_1.filling.name = "Carne Asada"

puts "New value of spicy_sausage is #{spicy_sausage.inspect}"
puts "New value of taco_1's filling is #{taco_1.filling.inspect}"
```

**Turn and Talk**: Will spicy_sausage and taco_1.filling have the same name after `taco_1.filling.name = "Carne Asada"`?

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

Run this code and you will see that changing `taco_1.filling` changed `spicy_sausage`. This can be a very intimidating concept at first, but it is very important. These variable names are ways of referencing Objects that live in memory. You can have many different variable names that reference the same Object. When we change one, we change them all.

In your Sheet, update cell C3 with the new value for `spicy_sausage` AND `@filling`. Your sheet should look like this:

![Imgur](https://i.imgur.com/XsInit9.png)

Notice how you only changed one space of memory, but you affected both variables that point to it.

You may be wondering why these two variables still point to the same thing even though we used the assignment operator `=`. In the first activity we saw that using the assignment operator `=` allocates new memory, so why didn't we see that here? It is because we used the assignment operator on `taco_1.filling.name` and not `taco_1.filling`. We reassigned the string that the Filling object was holding, not the Filling object itself. Let's illustrate that with another example:

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
puts "Initial value of taco_1's filling is #{taco_1.filling.inspect}"

taco_1.filling = Filling.new("Carne Asada")

puts "New value of spicy_sausage is #{spicy_sausage.inspect}"
puts "New value of taco_1's filling is #{taco_1.filling.inspect}"
```

Compare the new values of `spicy_sausage` and `taco_1.filling` and you will see that there are in fact two different objects now.

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
