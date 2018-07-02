---
title: Git Review
length: 90
tags: git, github
---

## Learning Goals

* Create a new git repository.
* Check out new branches to implement pieces of functionality.
* Add and commit files from the command line.
* Push branches to GitHub
* Merge branches on GitHub
* Pull master from GitHub

## Walkthrough

### Iteration 1.0

In this stage, we want to create a new project locally, create a repository on GitHub and then link the two of them together.

#### Iteration 1.1: Create a New Project Locally

On your own computer walk through the following steps in your terminal.

1. `cd` into your Turing Mod 1 directory.
1. If you do not already have a practice directory, create one using `mkdir`
1. `cd` into your `practice` directory.
1. `mkdir dog_party`
1. `cd dog_party`
1. `mkdir lib`
1. `mkdir test`
1. `touch test/dog_test.rb`
1. `touch lib/dog.rb`
1. `git init`
1. `git status`
1. `git add test/dog_test.rb`
1. `git add lib/dog.rb`
1. `git commit -m "Initial commit"`

#### Iteration 1.2: Create a New Project on GitHub

In your browser:

1. Navigate to `github.com`
1. Click the `New repository` button
1. Enter `dog_party` as the name of your new repository
1. Click on `Create repository`
1. Under `...or push an existing repository from the command line`, click on the icon to copy the text commands to your clipboard

#### Iteration 1.3: Connect Your Local Repository to Your Remote

Back in your terminal:

1. Paste the commands that you've copied
1. Hit enter if the last command doesn't run

### Iteration 2.0

Here we want to actually add some content to our project. First we'll check out a branch, then do some work, commit, push to GitHub, merge to master, and then pull down so that we have our work on our local master branch.

#### Iteration 2.1: Create a Branch

Still in the Terminal:

1. `git branch -a`
1. `git branch create_dog_class`
1. `git branch -a`
1. `git checkout create_dog_class`
1. `git status`

#### Iteration 2.2: Create a Test

From the Terminal:

1. `atom ./`

In Atom:

1. Copy the code below into your test file.

```ruby
require 'minitest/test'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/dog'

class DogTest < Minitest::Test

  def test_it_exists
    dog = Dog.new("Fido", 2, "Dalmation")

    assert_instance_of Dog, dog
  end
end
```

In your terminal:

1. `ruby test/dog_test.rb`

#### Iteration 2.3: Commit Our Test

Still in the terminal:

1. `git status`
1. `git add test/dog_test.rb`
1. `git status`
1. `git commit -m "Create test for dog class"`
1. `git status`
1. `ruby test/dog_test.rb`

#### Iteration 2.4: Make Our Test Pass

Back in Atom:

1. Make the test pass by entering the following code into your `./lib/dog.rb` file.

```ruby
class Dog
  def initialize(name, age, breed)
    @name  = name
    @age   = age
    @breed = breed
  end
end
```

In your terminal:

1. `ruby test/dog_test.rb`

#### Iteration 2.5: Commit Our Work

1. `git status`
1. `git add lib/dog.rb`
1. `git status`
1. `git commit -m "Create dog class"`
1. `git status`

#### Iteration 2.6: Push to GitHub

1. `git push origin create_dog_class`
1. `git status`

#### Iteration 2.7: Merge to Master on GitHub

On GitHub

1. Reload the page that has your `dog_party` repo (where you copied the command to add the link to your repo)
1. Click on the green button in the yellow box that says 'Compare & pull request'
1. In the text box that says `write` above it add the following:

```
* Create test for dog class with name, age, and breed attributes.
* Create dog class.
```

1. Review the files that you changed below the text box - it should only include `dog.rb` and `dog_test.rb`
1. Click on the green button that says `Create pull request`
1. Click on the tab that says `Files changed`
1. Confirm that this only includes your `dog.rb` and `dog_test.rb` files and that it includes the code provided in earlier steps
1. Click on the tab that says `Conversation`
1. Click on the green button that says `Merge pull request`
1. Click on the green button that says `Confirm merge`
1. At the top of the page click on the tab that says `<> Code`
1. Confirm that you are on the `master` branch in the dropdown 1/3 of the way down the site on the left-hand side
1. Review the code in your `lib` and `test` directories on GitHub to confirm that you have successfully pushed and merged your code to master
1. Click on `<> Code` to return to the main page for your `dog_party` repository

#### Iteration 2.8: Get the Code from GitHub Master to Our Local Master

In your terminal:

1. `git checkout master`

In Atom:

1. Review your code. Your `test/dog_test.rb` and `lib/dog.rb` files should both be blank.

In your terminal:

1. `git pull origin master`

In Atom:

1. Review your code. Your `test/dog_test.rb` and `lib/dog.rb` files should both be populated.

### Iteration 3.0

Here we're going to repeat the process from iteration 2.0 to add some more code to our project.

#### Iteration 3.1: Check Out a New Branch

In your terminal:

1. `git status`
1. `git branch add_attr_readers`
1. `git checkout add_attr_readers`
1. Notice that we pulled to master, but are checking out a new branch before we do any additional work.
1. Additionally, the branch is named for the work we are planning on doing.

#### Iteration 3.2: Add Tests for Attributes

In Atom:

1. Add the tests below to your existing `test/dog_test.rb` file (some of the existing code is not repeated here, but referenced for brevity)

```ruby
# existing require statements

class DogTest < Minitest::Test
  # existing test that Dog exists

  def test_it_has_a_name
    dog = Dog.new("Fido", 2, "Dalmation")

    expected = "Fido"
    actual   = dog.name

    assert_equal expected, actual
  end

  def test_it_has_an_age
    dog = Dog.new("Fido", 2, "Dalmation")

    expected = 2
    actual   = dog.age

    assert_equal expected, actual
  end

  def test_it_has_a_breed
    dog = Dog.new("Fido", 2, "Dalmation")

    expected = "Dalmation"
    actual   = dog.breed

    assert_equal expected, actual
  end
end
```

In your terminal:

1. `ruby test/dog_test.rb`

#### Iteration 3.2: Commit Our Work

Still in the terminal:

1. `git status`
1. `git add test/dog_test.rb`
1. `git status`
1. `git commit -m "Create test for attributes"`

#### Iteration 3.3: Add Attributes

In Atom:

1. Add `attr_reader`s to your existing Dog code so that your final Dog class looks like the one below.

```ruby
class Dog
  attr_reader :name,
              :age,
              :breed

  def initialize(name, age, breed)
    @name  = name
    @age   = age
    @breed = breed
  end
end
```

#### Iteration 3.4: Commit Our Work

In your terminal:

1. `git status`
1. `git add lib/dog.rb`
1. `git status`
1. `git commit -m "Add attribute methods"`

#### Iteration 3.5: Push Our Branch to GitHub

1. `git status`
1. `git push origin add_attr_readers`

#### Iteration 3.6: Create a Pull Request

On GitHub

1. Click on the green button in the yellow box that says 'Compare & pull request'
1. In the text box that says `write` above it add the following:

```
* Create tests for Dog attributes.
* Add `attr_reader`s to Dog
```

1. Review the files that you changed below the text box - it should include both `dog.rb` and `dog_test.rb`
1. Click on the green button that says `Create pull request`

#### Iteration 3.7: Merge Our Pull Request

1. Click on the tab that says `Files changed`
1. Confirm that this includes your `dog.rb` and `dog_test.rb` files and that it includes the code provided in earlier steps
1. Click on the tab that says `Conversation`
1. Click on the green button that says `Merge pull request`
1. Click on the green button that says `Confirm merge`
1. At the top of the page click on the tab that says `<> Code`
1. Confirm that you are on the `master` branch in the dropdown 1/3 of the way down the site on the left-hand side
1. Review the code in your `lib` and `test` directories on GitHub to confirm that you have successfully pushed and merged your code to master
1. Click on `<> Code` to return to the main page for your `dog_party` repository

#### Iteration 3.8: Pull Our Work to Our Local Master Branch

In your terminal:

1. `git status`
1. `git checkout master`
1. `git status`
1. `git pull origin master`
1. `ruby test/dog_test.rb`

### Iteration 4.0

Use the examples above to add some additional code to your project:

1. Create and check out a branch called `add_bark_method`.
1. Add a test for a method called `bark` that returns the string "Woof!"
1. Commit your test with a commit message that describes the work you did.
1. Add a method called `bark` to your Dog class.
1. Commit your test with a commit message that describes the work you did.
1. Push your work to GitHub.
1. Merge your work.
1. Check out your `master` branch locally.
1. Pull your work from GitHub to your local `master` branch.

### Iteration 5.0

Same as before, but add a `summary` method that returns the string:

```
Name: Fido
Age: 2
Breed: Dalmation
```

Don't use `puts`!

### Questions

* In your own words, what are the high level steps for adding work to your project using a branching workflow?
* How do you decide what to name a branch in Git?
* Why would you work on a branch other than the master branch?
* When you've merged a branch to master on GitHub, how do you get that code to your local master branch?
