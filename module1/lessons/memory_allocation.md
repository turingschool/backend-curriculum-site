---
title: Memory Allocation
tags: ruby, memory, computer science
---

## What is Memory?

Computers need to be able to memorize something for the same reason that humans do: because they will need to access it later.

In some ways, computer memory is better than human memory. When the computer memorizes something, it won't forget it until we tell it to. You've never tried to open a saved document on your computer and it told you that it forgot it. Humans on the other hand forget things all the time.

But computer memory is also a lot less advanced than human memory because computers can't make connections. Humans make connections automatically ("Oh, that reminds me of this time...", "That smells just like my grandma's recipe..."). Computer's need to be told explicitly what memories are connected and how. That's what our code is for.

## Activity 1: Memorizing Strings

Memory is a lot like a column on a spreadsheet. There's many cells in that column for us to write whatever we want in there (let's pretend like formulas don't exist for this activity). Those cells also have a unique identifier. For example, the first cell in the second column of a spreadsheet is labeled B1. Memory works very similarly. It is a long list of cells for us to store things in, and we can look up those cells with a unique identifier that is called the **object_id**.

In order to illustrate this, you are going to create a spreadsheet as an anology to what is happening in the computer. Head to [Google Drive](https://drive.google.com/) and create a new spreadsheet by clicking on the "New" button in the top left, then click on Google Sheets. When your new sheet opens, click on the blue "Share" button in the top right of the Sheet, name your Sheet "Memory Allocation", and in the new window click on "Get shareable link". At the end of this activity, you will submit that link to your instructors.

In cell A1, type the header "variable", in cell B1, type the header "object_id", and in cell C1, type the header "memory". Make these headers bold. Column C is our memory. Each cell represents a chunk of memory for us to store things in. Column A holds the variable name we use to reference that memory in our Ruby code. Column B will hold the object_id that uniquely identifies that chunk of memory.

Create a new file called `memory.rb` and add this code to it:

```ruby
string_one = "hello"
string_two = "goodbye"

puts "string_one object id is #{string_one.object_id}"
puts "string_two object id is #{string_two.object_id}"

```

Rub this code. You should see two different object_ids printed out. In cell A2 in your Sheet, put the variable name `string_one`. In cell B2, puts the object_id for string_one that was printed out. In cell C2, put `"hello"` (include the quotes). Your Sheet should look like this, with different object_ids:

![Imgur](https://i.imgur.com/NEGOdj8.png)

In this example, we have created two different String Objects, or "Instances of the String Class". Notice in our spreadsheet the two different rows being taken up, indicating two cells of memory. Ruby has set aside these two completely separate boxes of memory to hold our data. The actual value of the object_id is unimportant, but what is important is that this object_id is unique for each row, each box of memory. When we want to reference this data in our Ruby code, we do it with the variable names `string_one` and `string_two`.

Setting aside memory is called **Memory Allocation**. Ruby is reserving these spots in memory to hold data.

Now let's see what happens when the two variables hold the same data. Change your code to this:

```ruby
string_one = "hello"
string_two = "hello"

puts "string_one object id is #{string_one.object_id}"
puts "string_two object id is #{string_two.object_id}"

```

**Turn and Talk**: Do you expect the object_ids to be the same, or different?

<br />
<br />
<br />
<br />
<br />
<br />
<br />

Run this code, and you'll notice that even though `string_one` and `string_two` have the same value, they each have unique object id's. This is illustrating what it really means to be an "Object" or "Instance" in Ruby (remember, these words mean the same thing). Despite their identical values, they are separate entities.

Run this code a couple more times and notice that the object_ids are different every time. So it doesn't really matter what the exact object_id is. What is important is that each time this code is run, Ruby is allocating two unique spaces in memory to hold our data.

At this point, we've determined that Ruby is allocating memory for each of these strings. But what can we do with those spaces in memory? Can we change what they hold? Let's try it. Change your code to this:


```ruby
string_one = "hello"
string_two = "goodbye"

puts "string_one object id is #{string_one.object_id}"
puts "string_two object id is #{string_two.object_id}"

string_one << " world"
puts "string_one new object_id is #{string_one.object_id}"
puts "string_one new value is #{string_one}"
```

**Turn and Talk**: Do you expect `string_one` to have a different object_id after the shovel?

<br />
<br />
<br />
<br />
<br />
<br />
<br />

Compare the `string_one` initial object_id and the new object_id and notice that they are exactly the same! Not only can Ruby set aside these boxes of memory, but we can also change what is inside them. Update your Sheet's row for `string_one` with the new value being stored in memory.

Let's make a slight change to the code. Instead of using the shovel `<<`, let's create the string "hello world" using the assignment operator `=`.

```ruby
string_one = "hello"
string_two = "goodbye"

puts "string_one object id is #{string_one.object_id}"
puts "string_two object id is #{string_two.object_id}"

string_one = "hello world"
puts "string_one new object_id is #{string_one.object_id}"
puts "string_one new value is #{string_one}"
```

**Turn and Talk**: Do you expect `string_one` to have a different object_id after the assignment?

<br />
<br />
<br />
<br />
<br />
<br />
<br />


Compare the `string_one` initial object_id and the new object_id and notice that they are NOT the same! Instead of using that box of memory that we already allocated for string_one, Ruby sliced out a new chunk of memory to put the new value of `"hello world"`. Why did this behave different than the shovel? The key is that we used the assignment operator `=`. Every time you use the assignment operator `=`, Ruby allocates a new chunk of memory to be used. Update your Sheet's row for `string_one` with the new object_id.

**Check for Understanding**

Answer the following questions in your Sheet:

* What is Memory?
* What is Memory Allocation?
* What is an object_id
* What is an Object in terms of memory?
* What is a variable?
* What happens when we use the assignment operator `=` in terms of memory allocation?

**Bonus Activity**:

Does the behavior we saw in the activity apply to shortcuts that use the assignment operator like `+=`, `-=`, `*=`, etc? Update your code so that it changes `string_one` to `"hello world"` using `+=` instead of `=` and observe what happens.

## Activity 2: Creating our own Objects

We've started to get a feel for how Ruby works with memory. Let's now dive a little deeper and see what happens when we create our own objects. Create a new tab in your Sheet by clicking on the `+` icon in the lower left corner of your Sheet. Change the names of these tabs to "Strings" and "Objects" respectively. To change the name, double click on the tab. Do the same setup you did for the Strings activity. Label Column A "variable", Column B "object_id", and Column C "memory".

Change your `memory.rb` file to this:

```ruby
class Taco
end

taco_1 = Taco.new
taco_2 = Taco.new

puts "taco_1 object_id is #{taco_1.object_id}"
puts "taco_1 is #{taco_1.inspect}"

puts "taco_2 object_id is #{taco_2.object_id}"
puts "taco_2 is #{taco_2.inspect}"
```

You should see output similar to this:

```
taco_1 object_id is 70311047362240
taco_1 is #<Taco:0x00007fe52200ed80>
taco_2 object_id is 70311047362220
taco_2 is #<Taco:0x00007fe52200ed58>
```

In cell A2 of your sheet, put "taco_1" for the variable name. Copy and paste the object_id that was printed out and put it in cell B2. In cell C2, copy and paste the entire value printed out for taco_1.inspect. In the example above, it would be `#<Taco:0x00007fe52200ed80>`. Do the same for taco_2. Your Sheet should look something like this:

![Imgur](https://i.imgur.com/eff0Rns.png)

`#<Taco:0x00007fe52200ed80>` means "A Taco Object". Don't worry too much about the Hexadecimal number that is printed after the colon. All you need to know is that it is very similar to the object_id, uniquely identifying the Object. This is behaving the same way as our Strings. Even though these two Tacos seem the same, they are taking up two different spots in memory. The difference is that instead of holding String objects, our memory is now holding Taco objects.

Let's make our Tacos a little more spicy. We are going to forget about the second Taco for now, so delete row 3 from your Sheet. Update your code to this:

```ruby
class Taco
  def initialize(filling)
    @filling = filling
  end
end

spicy_sausage = "Chorizo"
taco_1 = Taco.new(spicy_sausage)

puts "taco_1 object_id is #{taco_1.object_id}"
puts "taco_1's value is #{taco_1.inspect}"

puts "spicy_sausage object_id is #{spicy_sausage.object_id}"
puts "spicy_sausage's value is #{spicy_sausage.inspect}"
```

Run this code and update your Sheet with the filling variable name, object_id, and value in memory. Notice that the value printed out for `taco_1` now shows the instance variable `filling`. Update your sheet with this new value stored in memory.

So the Taco object is somehow storing the filling in an instance variable, and that value is "Chorizo". But we also have a variable called `spicy_sausage` that is also holding that value "Chorizo". So the question is, are there two different spaces in memory being allocated? Let's find out. Update your code to this:

```ruby
class Taco
  attr_reader :filling

  def initialize(filling)
    @filling = filling
  end
end

spicy_sausage = "Chorizo"
taco_1 = Taco.new(spicy_sausage)

puts "taco_1 object_id is #{taco_1.object_id}"
puts "taco_1's value is #{taco_1.inspect}"

puts "taco_1 filling's object_id is #{taco_1.filling.object_id}"
puts "taco_1's value is #{taco_1.filling.inspect}"

puts "spicy_sausage object_id is #{spicy_sausage.object_id}"
puts "spicy_sausage's value is #{spicy_sausage.inspect}"
```

**Turn and Talk**: Will taco_1's filling's object_id be different than spicy_sausage's object_id?
