---
layout: page
title: Project Etiquette
length: 60min
tags: ruby, rake, require, require_relative, organization
---

## Ruby Project Etiquette: How to Mind Your P's and Q's in a Ruby Project

In this session we're going to go over some common best practices for organizing and managing code in our Ruby projects. By the end of the lesson, you should be comfortable with the following tasks.

* File naming conventions
* Directory structure conventions
* Difference between `require` and `require_relative`
* How to build a rakefile and **why** you want to


## Vocabulary
* require
* require_relative
* rake task

## Warmup

* How have you been organizing your projects so far?
* What are the advantages of following conventions in project organization?
* Do you tend to use require or require_relative? How does the pathing work?

### Directory and File Organization

#### File/Class Naming Conventions

1. Snake-case file names (`my_file.rb` rather than `myFile.rb` or `my-file.rb`)
2. End files in `.rb`
3. Classes are named using PascalCase a.k.a. UpperCamelCase
3. Match file names to the class name -- e.g. a file containing the class `RotationGenerator` should be `rotation_generator.rb`

#### Directory Structure

In a standard Ruby project, we tend to organize code into 4 subdirectories:

1. `lib` for source code
2. `test` for test files
3. `data` for data-related files (.txt, .csv, etc)
4. `bin` for any "executable" files (you may not have encountered any of these yet; if you don't have them, leave `bin` out)

Additionally, it's common for test files and source files to match relatively 1-to-1. Thus a class called `RotationGenerator` will generally be found in the source file at `lib/rotation_generator.rb` and will have a corresponding test file at `test/rotation_generator_test.rb`.

#### Exercise

Take the following 2 code snippets and place them into a correct ruby project structure. Consider:

* What directories and files do you create?
* What content goes into each file?
* How does the test file know about the source code?

```ruby
class Hello
  def greet
    "Hello, World!"
  end
end
```

```ruby
require "minitest/autorun"
# _______________ <--- Your Require Statement Here

class HelloTest < Minitest::Test
  def test_it_greets
    hello = Hello.new
    assert_equal "Hello, World!", hello.greet
  end
end
```

### Require Statements
Require statements often trip us up, but there are some straightforward guidelines we can follow that make things much more reliable:

##### `require` vs. `require_relative`

Here's a quick overview of _how_ `require` and `require_relative` work.

`require_relative` attempts to require a second file using a path relative to *the file that is requiring it*.

* Does NOT matter where you run the test from (searches for path relative to the file the requirement is in)
* As directory structure gets more complex, navigating relative to the file you require come can become convoluted (`require_relative '../../../lib/enigma'`) 🙀.

`require` attempts to require a second file relative to *the place* from which the first file is **being run** -- that is, relative to your present working directory when you type `ruby file_one.rb`

* DOES matter where you run the test from
* require tends to behave more consistently in complex scenarios and project structures (`require './lib/enigma'`)
* require is also what we'll use for external gems and libraries. This is because...
  * require is designed to cooperate with ruby's $LOAD_PATH
  * Rails assumes we're running from the main project directory.


#### Err on the Side of `require`

Consider a project with the following structure.

```
.
├── lib
│   ├── enigma.rb
└── test
    ├── enigma_test.rb
```

Generally within the Ruby community it is assumed that you will be running your test files from the `project/` directory *and not from within the `/test` directory*.

**Avoid the temptation to navigate into go into test or lib directories through terminal to run code (i.e. `test$ ruby enigma_test`). Use `enigma$ ruby test/enigma_test.rb` instead.**

##### Why do we prefer `require`?

Assuming the directory structure above, `enigma_test.rb` could include either of the following lines (remember you can leave `.rb` off when you are requiring a file):

`require './lib/enigma'`
`require_relative '../lib/enigma'`

If you are running your test files from within the `project` directory, both of these will work the same. If you move down into the `project/test` directory, the first would then be unable to find the `enigma.rb` file. So why would we use something that might break depending on where we execute our code? Well, there are tradeoffs.

What seems more brittle in this case is likely actually more resilient to future changes. Remember the example above: if our application and test suite grow, we may decide that we want to include subdirectories for our tests. If we use `require_relative` that means that we have to add a `../` to each and every one of our tests. If we use `require` we can simply move our files to a new subdirectory and continue to run our tests from the `project` directory as we have been doing.

Additionally, using require tends to be more common within the community. Programmers get worked up about weird things and sometimes it's best to just `go with the flow`.

##### Check for Understanding

Create a `greeting` directory and set up the following code in `lib/hello.rb` and `test/hello_test.rb` files. Experiment with which path formats you can get working in each scenario in the table below and record the path there.

```ruby
class Hello
  def greet
    “Hello, World!”
  end
end
```

```ruby
require "minitest/autorun"
                  # bring in the source code here

class HelloTest < Minitest::Test
  def test_it_greets
    hello = Hello.new
    assert_equal “Hello, World!”, hello.greet
  end
end
```

**require type** | running file from project directory | running file from test directory
|:--:|:--:|:--:|
`require` | |
`require_relative` | |


## Rakefiles and Test Runners

Rake tasks come from [make](https://www.computerhope.com/unix/umake.htm) tasks, Unix origins. They are used for task management and building projects. For a C project, "building" means compiling and verifying that things work. Ruby projects don't get compiled, so what does "building" mean for a Ruby project?

Rake tries to create a standardized solution for this problem so that you can interact with build and program prep the same no matter which application you're running. Not only does it give you set commands, but you can also build your own tasks and run them through Rake.

By default, Rake will look for a file name `Rakefile` in the root of your project. You'll define your RakeTasks in that file.

### Using Rake to Build a Task

A task is comprised of the keyword `task` followed by the name you assign to the task written as a symbol (`:task_name`). This gets passed a block of code (` do ...end` - similar to how we pass a block of code to the `.each` method).

Let's build your first Rake task!

**Independent Practice**  
For your `greeting` project, include a Rakefile. Reminder: it should be at the root of a project, and does not have a file extension.


**Whole Group**
```ruby
# Rakefile

desc "a rake welcome message"
task :welcome do
  puts "Welcome to Rake tasks!"
end
```

This task would then be run from the command line using `rake welcome` (from the **project root** -- noticing a pattern?) We can also run `rake -T` to see which Rake commands we've defined and what they do.


### Building a Test Task

Let's build a task that will run all our tests. Our objective is to be able to go into the root directory of your project, type `rake test`, and run our test suite (all of your tests) with that one command. You'll need to use `*` to pull in files of various names but still end in `_test.rb`.

```ruby
desc "run all tests"
task :test do
  ruby "test/*_test.rb"   # what is this line doing?
end
```

So here's the thing, that code up there only runs one thing. It's hard to see right now - let's add in a `goodbye` class that does something similar (but opposite) to hello. Now run `rake test` and notice - it only runs one of the tests.

What do we have to do to get all of it to run? Pop this inside of the `do ... end` block:

```
 my_files = FileList['test/**/*.rb']
  my_files.each do |file|
    ruby file
  end
 ```

 Look at that! We are getting a list of all of the files in our test directory, and we are enumerating over the list of files and then we are just going to run each one.

 This is great, but we are missing something. Each runs individually, and once we have multiple classes tested we have to scroll up a lot. This is what we would call less than ideal. How do we get everything to run altogether - as if it was one big test file?

Have your Rakefile look like this:

```
require 'rake/testtask'

Rake::TestTask.new do |t|
    t.pattern = "test/**/*_test.rb"
end

```

`testtask` is a thing built into Rake that will do that for us, we just need to follow the format above.

### Default

If you run the command `rake` without any further arguments, Rake will automatically look for a task named `default`. We can also set up a Rake task to have prerequisites - that is other tasks that must be run before the current task is run. If you set a prerequisite, Rake will automatically run those other tasks first, you don't even have to worry about it. Using this knowledge, we can add the following to our Rakefile:


```ruby
task default: ["test", "welcome"]
```

This will run both our `test` and `welcome` tasks when we run `rake`, but only those two, as those two are the two that appear in the default array.

#### Exercise
Update your current project to follow these conventions!

## Wrap Up
* How does require_relative work?
* How does require work?
* Which does Ruby convention prefer?
* What is a Rake Task? Why would you use one?
* What are the components of a Rake Task?

### Recommended Homework

Tonight:
- Update at least one previous project (Credit Check, Date Night, Enigma, Complete Me) to also follow these conventions.

### Additional Resources

* [Using Rake to Automate Tasks](http://www.stuartellis.name/articles/rake/)
* You may see alternate patterns in older Ruby Versions [Testing Rake Task](https://docs.ruby-lang.org/en/2.1.0/Rake/TestTask.html)
