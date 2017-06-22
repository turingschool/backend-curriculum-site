# Week 2 Diagnostic

This exercise is intended to help you assess your progress with the concepts and techniques we've covered during the week.

For these questions, write a short snippet of code that meets the requirement. In cases where the question mentions a "given" data value, use the variable `given` to refer to it (instead of re-writing the information).

Use single (\`) and triple backticks (\`\`\`) to container code snippets.

1.  Define a class called `PizzaOven` which has a method `cook_pizza` which returns the string `"mmm 'za"`.

2.  Define a class called `Student` which is instantiated with a "name" value and which has a method `name` that returns this value

3.  Given an array of the numbers `[1,2,3,4,5]`, how would you create a new array of all elements doubled? How would you return an array of all odd elements?

4.  Give the command to create a new Git repository in a directory on your machine

### Pizza

5.  Given a hypothetical `Pizza` class which has an instance method `is_tasty?` that always returns true, write a simple Minitest test that tests this behavior.

6.  Suppose the `Pizza` class also has a method `style` which randomly returns one of: `"supreme"`, `"mediterranean"`, or `"cheese"`. Write a test that confirms that the returned pizza style is within this list.

6.  Give the Git commands needed to *stage* and then *commit* a set of changes to a file

### Student

7.  Define a `Student` class which, when created, has an `attitude` attribute.
`attitude` should start out with the value "cheerful", and the `Student` class should provide a "reader" method that allows us to access the value of its `attitude`.

8.  Additionally, add an `assign_homework` method to `Student`. When `assigned_homework` is invoked, if the student's `attitude` is `"cheerful"`, it should become `"dubious"`. If the value is currently `"dubious"` it should become `"perturbed"`. If the value is currently `"perturbed"`, it should become `"dazed"`. Assigning homework to a `"dazed"` student has no effect.

9.  Building on the `Student` class from the previous example, update the `assign_homework` method to accept an argument. The argument will be a `String` containing a short description of the assignment. For example we might use it like this:

```ruby
s = Student.new
s.assign_homework("Write a linked list")
```

Then, add an `assignments` method to `Student`. `assignments` should return a list of all the assignments that have been given, separated by a comma and a space. For example:

```ruby
s = Student.new
s.attitude
=> "cheerful"
s.assign_homework("write a linked list")
s.attitude
=> "dubious"
s.assign_homework("write a BST")
s.attitude
=> "perturbed"
s.assignments
=> "write a linked list, write a BST"
```

10. Given an array of 3 `Student` instances, generate a new string of *all* of their assignments

For example:

```
s1 = Student.new
s2 = Student.new
s3 = Student.new

s1.assign_homework("linked list")
s1.assign_homework("sorting algos")

s2.assign_homework("write a c compiler")
s2.assign_homework("write a pacman game")

s3.assign_homework("headcount")
s3.assign_homework("sales engine")

students = [s1,s2,s3]

# YOUR CODE HERE

=> "linked list, sorting algos, write a c compiler, write a pacman game, headcount, sales engine"
```

11. What does the following code output?

```ruby
def print_variables(x)
  puts "x: #{x}"
  puts "b: #{b}"
end

def b
  12
end

a = 4
print_variables(a)
```

12. Working with files: given a text file located at `"~/Documents/pizza.txt"`, write code to read the
file from the filesystem and print _each line_ one at a time.

13. Writing Files: given a text file located at `"~/Documents/pizza.txt"`, write code to read the file from the filesystem, then write a new file at `"~/Documents/line_count.txt"` containing the number of lines in the original file.

14.  Imagine a simple ruby class designed to represent a Corgi dog. Write a _test_ for each of the following features:

*  A Corgi can be created with no arguments
*  A Corgi can be assigned a name
*  A Corgi can be asked for its name
*  A Corgi can be asked for its posture, which should default to "standing"
*  A Corgi can be asked to lie down, which should change its posture to "laying"
