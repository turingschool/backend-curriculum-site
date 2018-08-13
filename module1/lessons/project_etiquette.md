---
layout: page
title: Project Etiquette
length: 45min
tags: ruby, rake, require, require_relative, organization
---

## Ruby Project Etiquette: How to Mind Your P's and Q's in a Ruby Project

### Directory and File Organization

#### File/Class Naming Conventions

1. Snake-case file names (`my_file.rb` rather than `myFile.rb` or `my-file.rb`)
2. End files in `.rb`
3. Classes are named using PascalCase a.k.a. UpperCamelCase
3. Match file names to the class name -- e.g. a file containing the class `RotationGenerator` should be `rotation_generator.rb`

#### Directory Structure

Every project should have one top level directory that contains everything for that project. This is called the **Root Directory**. Be careful: "Root Directory" can also refer to the root of your computer. In this case, we are referring to the root of the project. Context is very important.

In a standard Ruby project, we tend to organize code into 4 sub-directories underneath the root directory:

1. `lib` for source code
2. `test` for test files
3. `data` for data-related files (.txt, .csv, etc)
4. `bin` for any "executable" files (you may not have encountered any of these yet; if you don't have them, leave `bin` out)

#### Example Directory Structure & Naming

If we are creating an "Enigma" project that needs a `RotationGenerator` class, our directory structure would look like this:

```ruby
enigma
  ├── lib
  │   ├── rotation_generator.rb
  └── test
      ├── rotation_generator_test.rb
```

```ruby
# lib/rotation_generator.rb

class RotationGenerator

  def first_method
    # do a thing
  end

end
```

```ruby
# lib/rotation_generator_test.rb

class RotationGeneratorTest < Minitest::Test

  def test_first_method
    # test that is does a thing
  end

end
```

Notice the relationship between class and test class names, source code file and test file names, and file to class names.

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
enigma
  ├── lib
  │   ├── enigma.rb
  └── test
      ├── enigma_test.rb
```

Generally within the Ruby community it is assumed that you will be running your test files from the root directory, in this case "enigma", *and not from within the `/test` directory*.

**Avoid the temptation to navigate into go into test or lib directories through terminal to run code (i.e. `test$ ruby enigma_test`). Use `enigma$ ruby test/enigma_test.rb` instead.**

##### Why do we prefer `require`?

Assuming the directory structure above, `enigma_test.rb` could include either of the following lines (remember you can leave `.rb` off when you are requiring a file):

`require './lib/enigma'`
`require_relative '../lib/enigma'`

If you are running your test files from within the `project` directory, both of these will work the same. If you move down into the `project/test` directory, the first would then be unable to find the `enigma.rb` file. So why would we use something that might break depending on where we execute our code? Well, there are tradeoffs.

What seems more brittle in this case is likely actually more resilient to future changes. Remember the example above: if our application and test suite grow, we may decide that we want to include subdirectories for our tests. If we use `require_relative` that means that we have to add a `../` to each and every one of our tests. If we use `require` we can simply move our files to a new subdirectory and continue to run our tests from the `project` directory as we have been doing.

Additionally, using require tends to be more common within the community. Programmers get worked up about weird things and sometimes it's best to just `go with the flow`.

## Rakefiles

Rake tasks come from [make](https://www.computerhope.com/unix/umake.htm) tasks, Unix origins. They are used for task management and building projects. For a C project, "building" means compiling and verifying that things work. Ruby projects don't get compiled, so what does "building" mean for a Ruby project?

Rake tries to create a standardized solution for this problem so that you can interact with build and program prep the same no matter which application you're running. Not only does it give you set commands, but you can also build your own tasks and run them through Rake.

By default, Rake will look for a file name `Rakefile` in the root of your project. You'll define your RakeTasks in that file.

### Rakefile to Run all your Tests

In your project's root directory, create a file called `Rakefile`. Add this code to it:

```ruby
require 'rake/testtask'

Rake::TestTask.new do |t|
    t.pattern = "test/**/*_test.rb"
end

task default: ["test"]
```

A "task" is referring to something rake can do for you. The `Rake::TestTask` is a special task built in to rake for running all your tests. Instead of having to run all your test individually by calling `ruby test/file_name` for each test file, you can run the command `rake` in the command line from your project root directory and it will run all of the test files inside your test directory as if it were one, big test file.

**note:** You may need to `gem install rake`.

Notice that the `Rake::TestTask` is being passed a block, kind of like how we pass blocks to enumerables. This block is specifying where the test files are located with the line `t.pattern = "test/**/*_test.rb"`. The `*` is a wildcard character, which means it will pattern match anything. This line of code is saying "our tests are located in the test directory in files that end with `_test.rb`".

The line `task default: ["test"]` is setting our default task to "test". Normally when you run `rake`, you have to specify the name of task you want to run, but setting "test" as the default allows us to just run `rake` from the command line to run all the tests.

## Additional Resources

* [Using Rake to Automate Tasks](http://www.stuartellis.name/articles/rake/)
* You may see alternate patterns in older Ruby Versions [Testing Rake Task](https://docs.ruby-lang.org/en/2.1.0/Rake/TestTask.html)
