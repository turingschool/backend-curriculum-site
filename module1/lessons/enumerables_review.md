---
title: Advanced Enumerables
length: 90
tags: enumerables, ruby, zip, group_by, reduce
---

## Learning Goals

* Solidify understanding of enumerables used so far
* Practice more complex enumeration
* Practice iterating over hashes

## Warm Up  

Copy and paste the following into a Ruby file:

```ruby
class Student
  attr_reader :name, :id

  def initialize(name ,id)
    @name = name
    @id = id
  end
end

student_1 = Student.new("Megan", 4)
student_2 = Student.new("Brian", 9)
student_3 = Student.new("Sal", 1)
student_4 = Student.new("Mike", 2)
student_5 = Student.new("Amy", 5)

students = [student_1, student_2, student_3, student_4, student_5]
```

Then, use the students array to accomplish the following. Use print statements to check your work:

1. Create an Array of all the Student names
1. Create an Array of all the Students whose names start with the letter "M"
1. Get the Student whose id is 1
1. Check if one Student is named "Amy"
1. Check if any of the Students have an id of 10
1. Find the Student with the highest id
1. Create an Array with the Students in order of name, alphabetically
1. Create an Array with the Students in order of name by length

## Advanced Problems

Copy and paste the following into a Ruby file:

```ruby
class Student
  attr_reader :name, :id

  def initialize(name ,id)
    @name = name
    @id = id
  end
end

student_1 = Student.new("Megan", 4)
student_2 = Student.new("Brian", 9)
student_3 = Student.new("Sal", 1)
student_4 = Student.new("Mike", 2)
student_5 = Student.new("Amy", 5)

modules = {
  mod_1: [student_1, student_2, student_3],
  mod_2: [],
  mod_3: [student_4],
  mod_4: [student_5]
}
```

Then, use the above to accomplish the following. Use print statements to check your work:

* Create an array of all mods (as symbols) that have more than one student. The answer should be `[:mod_1]`.

* Create a hash that associates a mod with an Array of students names. The answer should be:

```ruby
{
  mod_1: ["Megan", "Brian", "Sal"],
  mod_2: [],
  mod_3: ["Mike"],
  mod_4: ["Amy"]
}
```

* Figure out which mod has the most students. The answer should be `:mod_1`.
* Create a Hash that associates a mod with the student with the name of the Student highest id. The answer should be:

```ruby
{
  mod_1: "Brian",
  mod_2: nil,
  mod_3: "Mike",
  mod_4: "Amy"
}
```

* Create the following hash:

```ruby
{
  ids_greater_than_or_equal_to_5:   "Brian and Amy",
  ids_less_than_5:                  "Megan and Sal and Mike"
}
```
