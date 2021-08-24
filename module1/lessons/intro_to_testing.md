---
layout: page
title: Intro to Testing
length: 120
tags: ruby, testing
---

## Learning Goals

* Understand why we use tests
* Define the stages of a test
* Define a RSpec test
* Use a variety of assertion methods

## Vocabulary

* Gem
* Test
* Assertion

## Warm Up

* Thinking back to your capstone work; how did you know if your program was working?
* What are some potential drawbacks to this approach?

## Test Etiquette

### File Structure

- Spec files live in their own `spec` directory
- Implementation code files live in a sibling `lib` directory
- Spec files should reflect the class they're testing with `_spec` appended to the file name, e.g. `spec/name_of_class_spec.rb`
- In your test, you'll now `require "./lib/name_of_class.rb"`
- Run your spec files from the root of the project directory, e.g. `rspec spec`
- If you want to run a specfic spec file you can append the location of that file to the `rspec spec` command. So `rspec spec spec/name_of_file_spec.rb`

```
.
├── lib
|   └── name_of_class.rb
└── spec
    └── name_of_class_spec.rb
```

### RSpec Setup

RSpec is a framework used for automated testing. It is the testing framework used on many of the homework exercises you've been assigned.
[RSpec Core Documentation](https://rspec.info/documentation/3.9/rspec-core/RSpec/Core/Configuration)

```
gem install rspec
```

* Require `rspec` - the easy and explicit way to run all your tests

### RSpec Convention

- At the top of every spec file: `describe NameOfClass`
- describe '#name_of_method'
  - It is good practice to have another describe block for the name of method. That way we can group all assertions dealing with this method in this describe block.
- We need to have an assertion at the end of every test
  - A lot of times we are going to compare if two values are equal to each other
  - We do that by writing `expect(actual).to eq(expected)` where actual is the result of the method call or object querying, and expected is the value we expect it to be.
- [RSpec Expectations Documentation](https://www.rubydoc.info/github/rspec/rspec-expectations/RSpec/Expectations)


## Code-Along

### Scenario Specifications

```ruby
pry(main)> require './lib/student'
=> true

pry(main)> student = Student.new('Penelope')
=> #<Student:0x007fa71e12c1f0 @cookies=[], @name="Penelope">

pry(main)> student.name
=> "Penelope"

pry(main)> student.cookies
=> []

pry(main)> student.add_cookie('Chocolate Chunk')
pry(main)> student.add_cookie('Snickerdoodle')

pry(main)> student.cookies
=> ["Chocolate Chunk", "Snickerdoodle"]
```

Now, let's write tests based on the interaction pattern above.

```ruby
# student_spec.rb
require 'rspec'

describe Student
  # test it exists
  # test it has a name
  # test it has cookies
  # test it can add cookies
end
```

Let's build out our Student Test!

```ruby
# student_spec.rb
require 'rspec'

describe Student do
  describe '#initialize' do
    it 'is an instance of student' do
      student = Student.new('Penelope')
      expect(student).to be_a Student
    end
  end
end
```

* Write tests
* Run tests
* Thoroughly read errors & failures
* Write implementation code

```ruby
class Student

end
```

* Do it all again

```ruby
# student_spec.rb
require 'rspec'
require './lib/student'

describe Student do
  describe '#initialize' do
    it 'is an instance of student' do
      student = Student.new('Penelope')
      expect(student).to be_a Student
    end

    it 'has a name' do
      student = Student.new('Penelope')
      expect(student.name).to eq 'Penelope'
    end
  end
end
```

```ruby
class Student
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end
```

## S.E.A.T

Each test that we create needs 4 components to be a properly built test.

* Setup - The setup of a test is all of the lines of code that need to be executed in order to verify some behavior. Because each test is run individually, we often see the same setup being created multiple times.
* Execution - The execution is the actual running of the method we are testing.  This sometimes happens on the same line as the assertion, and sometimes happens prior to the assertion.
* Assertion - The verification of the behavior we are expecting.  This is really the main focus of the test; without the assertion, we have no test.
* Teardown - After we complete a test, we want to delete all of our setup, and clear the scope for our next test.  In RSpec this is done automatically! So, you won't need to worry about this in Mod 1, but it is important to know for other testing frameworks.

With a partner, see if you can identify each of the components in the following tests:

```ruby
# student_spec.rb
require 'rspec'
require './lib/student'

describe Student do
  describe '#initialize' do
    it 'is an instance of student' do
      student = Student.new('Penelope')
      expect(student).to be_a Student   
    end

    it 'has a name' do
      student = Student.new('Penelope')
      expect(student.name).to eq 'Penelope'
    end

    it 'has cookies by default' do
      student = Student.new('Penelope')
      expect(student.cookies).to eq []
    end
  end

  describe '#add_cookie' do
    it 'adds cookie to cookies array' do
      student = Student.new('Penelope')
      student.add_cookie('Chocolate Chip')
      student.add_cookie('Snickerdoodle')

      expect(student.cookies).to eq ['Chocolate Chip', 'Snickerdoodle']
    end
  end
end
```

# Testing Cont. Warmup
What do you think the following `.to` methods do?

- `.to eq`
- `.to be_a`
- `.to be true `
- `.to be_nil`
- `.to include`

## Additional Test Intricacies

### Ensuring Dynamic Functionality

We should make sure that all of our methods can handle different cases, ensuring that our implementation code is dynamic, e.g.:

```ruby
# student_spec.rb
require 'rspec'

describe Student do
  describe '#initialize' do
    it 'is an instance of student' do
      student = Student.new('Penelope')
      expect(student).to be_a Student
    end

    it 'has a name' do
      student = Student.new('Penelope')
      expect(student.name).to eq 'Penelope'
    end

    it 'has a different name' do
      student = Student.new('James')
      expect(student.name).to eq 'James'
    end
  end
end
```

### Testing Edge Cases

* Ensure that your implementation code can handle things we might not expect, e.g.:

```ruby
# student_spec.rb
describe Student do
  describe '#initialize' do
    it 'is an instance of student' do
      student = Student.new('Penelope')
      expect(student).to be_a Student
    end

    it 'has a name' do
      student = Student.new('Penelope')
      expect(student.name).to eq 'Penelope'
    end

    it 'assigns a default name' do
      student = Student.new(42)
      expect(student.name).to eq 'Default Name Assigned'
    end
  end
end
```

### Nice to Know
- Each test is independent of the next; **don't depend on tests to run in order** of how they're written
  - However, it clarifies your code to other humans to write in order of complexity; aim to start from most basic to most complex functionality and keep tests grouped by method
- You can `before(:each)` method
  - This will provide shared test setup run before each individual test
- Tests will generally return an `E` for error, `F` for failure & `.` for passing

```ruby
describe Student do
  before(:each) do
    @student = Student.new('Penelope')
  end
end
```

## Recap

* What 2 directories should we have within our project directory?
* `rspec` setup
  * What do you have to require in a spec file?
  * What goes in the initial describe block?
  * What is the syntax for a RSpec spec?
  * Name 3 `.to` methods you learned about today & describe their syntax.
