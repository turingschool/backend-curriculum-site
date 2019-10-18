---
title: CSV Walkthrough
tags: ruby, csv tutorial
---

### CSV Walkthrough

In Ruby, there are classes already defined for us that will allow us to read and write files. Today we are going to focus on the `CSV` class and how to read a file to create instances of our objects. We will be using [this repo](https://github.com/turingschool-examples/csv_example) as an example. Take a moment to look at the files and what they contain.

The `runner.rb` is where we will be writing out code to read our files and create objects. To start
we are going to `require 'CSV'` so that we will have access to its methods. Next, we want to use the `foreach` method from `CSV` and pass it an argument of the file that we want to read. Similar to the `each` enumerable the `foreach` creates a block where the block variable will be a single row in the file. Now add a `pry` within the block so we can see what a row looks like in our block.

```Ruby
require 'CSV'

CSV.foreach('./data/animal_lovers.csv') do |row|
  require 'pry'; binding.pry
end
```

Congrats, you are reading a csv! Since, we know we have access to the information in the file a row at a time we now just need to create objects using that information. As you noticed our first row is the headers row and doesn't contain any data to create an object. Let's update the `foreach` arguments to include the following:

```Ruby
require 'CSV'
# headers: true & header_converter: :symbol are optional arguments
CSV.foreach('./data/animal_lovers.csv', headers: true, header_converters: :symbol) do |row|
  require 'pry'; binding.pry
end
```

Now what does `row` look like in `pry`?

These optional arguments help format the row information to be more manageable to work with so that you can create new objects. Now let's create an instance of the `Animal Lovers` class from our data.


With a partner see if you can explain what is happening in the code below and use `pry` to confirm your assumptions.

```Ruby
require 'CSV'
require './lib/animal_lover'
# headers: true & header_converter: :symbol are optional arguments
CSV.foreach('./data/animal_lovers.csv', headers: true, header_converters: :symbol) do |row|
  id = row[:id].to_i
  first_name = row[:first_name]
  last_name = row[:last_name]
  age = row[:age].to_i
  animal_lover = AnimalLover.new(id,first_name,last_name,age)

  require 'pry'; binding.pry

  puts "#{animal_lover.full_name} has been created!"
end
```

### Practice

On your own, try reading the file and creating magical pet objects.
