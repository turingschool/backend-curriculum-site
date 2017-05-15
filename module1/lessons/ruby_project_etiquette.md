---
layout: page
title: Project Etiquette
---

## Ruby Project Etiquette: How to Mind Your P's and Q's in a Ruby Project

In this session we're going to go over some common best practices for organizing and managing code in our Ruby projects. By the end of the lesson, you should be comfortable with the following tasks.

* File naming conventions
* Directory structure conventions
* Difference between `require` and `require_relative`
* How to build a rakefile and why you'd want to

Slides available [here](../slides/ruby_etiquette)

### Warmup

* How have you been organizing your projects so far?
* What are the advantages of following conventions in project organization?

### Directory and File Organization

#### File Naming Conventions

1. Snake-case file names (`my_file.rb` rather than `myFile.rb` or `my-file.rb`)
2. End files in `.rb`
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

* What directories and files do you create
* What content goes into each file
* How do you require the code file from the test

```ruby
class TastyPizza
  def nom
    "mmmm 'za"
  end
end
```

```ruby
require "minitest/autorun"
# _______________ <--- Your Require Statement Here

class TastyPizzaTest < Minitest::Test
  def test_za_is_tasty
    assert_equal "mmmm 'za", Pizza.new.nom
  end
end
```


### Require Statements
Require statements often trip us up, but there are some straightforward guidelines we can follow that make things much more reliable.

##### `require` vs. `require_relative`

Here's a quick overview of _how_ `require` and `require_relative` work.

`require_relative` attempts to require a second file using a path relative to *the file* that is requiring it.

* Does NOT matter where you run the test from (searches for path relative to the file the requirement is in)
* As directory structure gets more complex, navigating relative to the file you require come can become convoluted (`require_relative '../../../lib/enigma'`).

`require` attempts to require a second file relative to *the place* from which the first file is **being run** -- that is, relative to whatever place you are sitting when you type `ruby file_one.rb`

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

Additionally, using require tends to be more common within the community. Programmers get workedup about weird things and sometimes it's best to just go with the flow

##### Check for Understanding

Set up the following code in `lib/hello.rb` and `test/hello_test.rb` files. Experiment with which path formats you can get working in each scenario in the table below.

```ruby
class Hello
  def greet
    “Hello, World!”
  end
end
```

```ruby
require "minitest/autorun"

class HelloTest < Minitest::Test
  def test_it_greets
    hello = Hello.new
    assert_equal “Hello, World!”, hello.greet
  end
end
```

**require type** | running file from project directory | running file from test directory
`require` | |
`require_relative` | |

## Rakefiles and Test Runners

* Unix origins, building projects, and `make`
* Problem: want a standardized command that you can run in every project
* For a C project, "building" means compiling and verifying that things work
* Ruby projects don't get compiled, so what does "building" mean for a Ruby project?
* Rake tries to create a standardized solution for this problem
* Also provides a standardized "task runner" for ruby projects
* `Rakefile` is a special file that lives in the root of your project and defines these tasks

#### Using Rake to Build a Task

Code along with your instructor to build your first rake task.

```ruby
task :pizza do
  puts "om nom nom"
end
```

This task would then be run from the command line using `rake pizza` (from the **project root** -- noticing a pattern?)

#### Building a [Testing Rake Task](http://rake.rubyforge.org/classes/Rake/TestTask.html)

Let's build our first [testing rake task](http://rake.rubyforge.org/classes/Rake/TestTask.html). Our objective is to be able to go into the root directory of your project, type `rake`, and run our test suite (all of your tests) with that one command.

```ruby
require "rake"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task default: :test # <------ important
```

##### Exercise

Use your knowledge of Ruby's object model and blocks to make sense of the rake TestTask above.

#### Summary

Review objectives from beginning of session.

### Recommended Homework

Tonight:

1. Update your current project to follow these conventions
2. Update one previous project (Credit Check, Flashcards, Complete Me, Date Night) to also follow these conventions
