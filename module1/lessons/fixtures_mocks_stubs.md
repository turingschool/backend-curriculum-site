---
layout: page
title: Fixtures, Mocks and Stubs
---

## Learning Goals

*   Understand what stubbing is, how to stub in Ruby with Minitest, when to use it
*   Understand what mocking is, how to mock in Ruby with Minitest, and when to use it
*   Understand what a fixture is and how to create one
*   What’s the difference between behavior and state testing

## Test Helper

Tired of writing all those `require` statements at the top of each file? Let's start thinking of our test files in a more DRY fashion.

Creating a `test_helper.rb` that our test files require allows us to store the rest of our repetitive setup in one centralized location.

## Fixtures

You may not have noticed yet, but all that data processing we're testing is really starting to affect our test suite's performance. Let's see if we can _fix_ that up.

### Basics

*   Create smaller copies of files you'll use in production
*   Mimic a request to an external dependency within testing environment, making calls
Let's set up a quick `learning_fixtures` project folder in our `classwork` directory complete with `lib`, `data`, and `test` directories.

We're going to test-drive iterating over an absurdly long CSV.

But first, you'll need to download [this](https://gist.github.com/laurenfazah/3390b8417274f11dee87eef02ea3c4db) and save it in `data`.

Let's use our CSV knowledge create a hash based on the values contained in the CSV. We'll just create a new hash based on a few _key_ headers and redefine those values with each new row in our CSV. We'll assert that the last `"EPISODE"` key's value is from the last row of the CSV.

Seems pointless? We really just want to create a task that will take significantly long to perform, but would be relatively quick with a customized fixture.

> Want to see approximately how long your tests take to run? Use the `-v` flag when running your tests and Minitest will be more verbose.

## Mocks and Stubs

Clone [this repository](https://github.com/turingschool-examples/testing-dependency-injection) so you have the code we're working with.

Take a second to explore the code and run the tests. You'll find that we're working on a system to organize and report on the data for a school/class/student.

For much of our work we're going to use the Mocha library. Open up the `./test/test_helper.rb` file and you'll see the require statements that we're going to use across test files. Each of our actual test files will require this test helper so we have the libraries loaded up. run `gem install mocha` to make sure you have access to the Mocha library.

You may need to run `bundle` to make sure you have all the proper gems installed.

### Mocks

Mocks are objects that stand in for other objects. The other object might be one that's not implemented yet, doesn't yet have the functionality we need, or maybe we just want to work with a simpler situation.

Open the `./test/section_test.rb` and read the tests there. Note that the second and third tests are skipped. Run your tests before you make any changes and they should be passing with the skips in place. Unskip the second test in `section_test.rb`, run the tests, and see that the test is failing.

Why? The test doesn't know what a `Student` is. We could go create it!

But *wait*. We're trying to write a unit test here. We're trying to test a `Section`, not a `Student`. The `Student` class might be a whole can of worms we're not willing to deal with right now. Let's use a mock!

#### A First Mock

A mock is a simple object that stands in for another object. At the base level, a mock is just a "thing" -- a blank canvas that we can use for just about anything. You create a mock like this:

```ruby
my_thing = mock('name')
```

Looks weird, right? Read this code carefully and figure out:

* what is `mock`, from a Ruby perspective? (like an "object", "integer", what?)
* what type thing is `'name'`?

Let's try to put it to use. Replace the two `Student.new` lines in the test with these:

```ruby
student_1 = mock('student')
student_2 = mock('student')
binding.pry
```

Run your test and pry should pause things. Figure out what the class of `student_1` and `student_2` is. Find the documentation for this class on the web to get an idea of what's possible. Query the `student_1` object to find out what methods it has. Exit pry.

Remove the `binding.pry`, run the test, and it still fails. Add the functionality needed to `Section` to make it work!

Now that your tests are passing, notice how the mocks allowed you to build out the `Section` functionality without actually implementing a `Student`.

#### Mock Expectations

Mocks can do more than just stand there. Remove the `skip` from the third `section_test.rb` and run it. It fails on the `Student.new` line.

Wait a second before you drop a `mock` in there. Read the rest of the tests. See how we need the first names? The previous test didn't use that name data, but now we need it. Let's build a smarter mock.

When you look at the mocha documentation you'll find that a Mock has methods we can call on it.

* `.expects` defines a method that can be called on the mock
* `.returns` defines the value that the expected method should return

Putting that together we replace the first `Student.new` with this:

```ruby
student_1 = mock('student')
student_1.expects(:first_name).returns("Frank")
```

Also replace `student_2` with a similar two lines. Then add a `binding.pry` and run the tests.

Once you're in pry, try calling the `first_name` method on `student_1`. Does it work? Call it again? Does it work?

Now go ahead and implement the `student_names` method in `Section` to make the test pass.

That's how mocks work. You create a mock to stand in for other objects and can add some simple capabilities to get you the functionality you need.

### Stubs

A stub is a fake method added to or overriding an existing method on an object.

#### A First Stub

Unskip the first test in `./test/metrics_calculator_test.rb`, run that file and see it fail. Make it pass without using any mocks/stubs just yet.

With that in place, unskip the second test, run it, and see if fail. Read the test body and figure out what's going on here.

The `MetricsCalculator` needs to have a `total_students` method. Logically that method needs to ask each `Section` about how many students there are. But our `Section` doesn't yet track actual students. What do we do?

We're working on testing the `MetricsCalculator`, not `Section`. Why go off adding functionality in `Section`? Let's, instead, pretend that `Section` has the functionality we want with a *stub*.

In the test find the comment that says that section 1 should have 22 students. Replace that line with this:

```ruby
sec_1.stubs(:student_count).returns(22)
```

Replace the later two comments with similar lines. The `stubs` method is essentially tacking a `student_count` method onto the existing `sec_1`. The `returns` sets the return value for that method call. Run the test again.

Now it fails because `total_students` is undefined. Define that method in `MetricsCalculator` assuming that each section instance now has a `student_count` method. The test should now pass.

### Check for Understanding

With your partners, teach back the difference between stubs and mocks. Check the [mocha docs](https://github.com/freerange/mocha) for more details/

## The Ultimate CFU

* How will you know you're writing a test that might be appropriate for stubbing or mocking?
* What's the difference between testing doubles that rely on state versus behavior?
* How many lines of data should you include in your fixture files?

## Further reading
-  Martin Fowler - Test Double: link [here](http://www.martinfowler.com/bliki/TestDouble.html)
- Gerard Meszaros - Test Double: link [here](http://xunitpatterns.com/Test%20Double.html)
