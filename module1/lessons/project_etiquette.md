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

In a standard Ruby project, we tend to organize code into 4 sub-directories:

1. `lib` for source code
2. `test` for test files
3. `data` for data-related files (.txt, .csv, etc)
4. `bin` for any "executable" files (you may not have encountered any of these yet; if you don't have them, leave `bin` out)

#### Example Directory Structure & Naming

```ruby
.
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


## Rakefiles and Test Runners

Rake tasks come from [make](https://www.computerhope.com/unix/umake.htm) tasks, Unix origins. They are used for task management and building projects. For a C project, "building" means compiling and verifying that things work. Ruby projects don't get compiled, so what does "building" mean for a Ruby project?

Rake tries to create a standardized solution for this problem so that you can interact with build and program prep the same no matter which application you're running. Not only does it give you set commands, but you can also build your own tasks and run them through Rake.

By default, Rake will look for a file name `Rakefile` in the root of your project. You'll define your RakeTasks in that file.

### Using Rake to Build a Task

A task is comprised of the keyword `task` followed by the name you assign to the task written as a symbol (`:task_name`). This gets passed a block of code (` do ...end` - similar to how we pass a block of code to the `.each` method).

### Building a Test Task

Let's build a task that will run all our tests. Our objective is to be able to go into the root directory of your project, type `rake test`, and run our test suite (all of your tests) with that one command. You'll need to use `*` to pull in files of various names but still end in `_test.rb`.

```ruby
desc "run all tests"
task :test do
  ruby "test/*_test.rb"   # what is this line doing?
end
```

So here's the thing, that code up there only runs one thing.

What do we have to do to get all of it to run? Notice the changes between the `do ... end` block:

```ruby
desc "run all tests"
task :test do
my_files = FileList['test/**/*.rb']
 my_files.each do |file|
   ruby file
 end
end
 ```

Now, we should be getting a list of all of the files in our test directory, and we are enumerating over the list of files and then we are just going to run each one.

This is great, but we are missing something. Each runs individually, and once we have multiple classes tested we have to scroll up a lot. This is what we would call less than ideal. How do we get everything to run altogether - as if it was one big test file?

Have your Rakefile look like this:

```
require 'rake/testtask'

Rake::TestTask.new do |t|
    t.pattern = "test/**/*_test.rb"
end

```

`testtask` is a thing built into Rake that will do that for us, we just need to follow the format above.

Again, this:

```
require 'rake/testtask'

Rake::TestTask.new do |t|
    t.pattern = "test/**/*_test.rb"
end

```

is probably what you want in the Rakefile; we walked you through the section above so you have a little bit of understanding about what rake is doing for us.


### Default

If you run the command `rake` without any further arguments, Rake will automatically look for a task named `default`. We can also set up a Rake task to have prerequisites - that is other tasks that must be run before the current task is run. If you set a prerequisite, Rake will automatically run those other tasks first, you don't even have to worry about it. Using this knowledge, we can add the following to our Rakefile:


```ruby
task default: ["test", "welcome"]
```

This will run both our `test` and `welcome` (assuming we have a welcome task) tasks when we run `rake`, but only those two, as those two are the two that appear in the default array.


## Additional Resources

* [Using Rake to Automate Tasks](http://www.stuartellis.name/articles/rake/)
* You may see alternate patterns in older Ruby Versions [Testing Rake Task](https://docs.ruby-lang.org/en/2.1.0/Rake/TestTask.html)
