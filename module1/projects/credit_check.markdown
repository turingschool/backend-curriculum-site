# Credit Check

### Learning Goals 
* break a problem into logical components 
* implement approriate Ruby syntax
* utilize methods and classes 

Let's write a program that can detect mistakes in a credit card number.

## Background: Luhn Algorithm

The Luhn algorithm is a check-summing algorithm best known for checking the validity of credit card numbers.

You can checkout the full description on Wikipedia: http://en.wikipedia.org/wiki/Luhn_algorithm

### Description

(adapted from Wikipedia)

The formula verifies a number against its included check digit, which is usually appended to a partial account number to generate the full account number. This full account number must pass the following test:

* from the rightmost digit, which is the check digit, moving left, double the value of every second digit
* if product of this doubling operation is greater than 9 (e.g., 7 * 2 = 14), then sum the digits of the products (e.g., 10: 1 + 0 = 1, 14: 1 + 4 = 5).
* take the sum of all the digits
* if and only if the total modulo 10 is equal to 0 then the number is valid

### Example

#### Calculating the Check Digit

**You don't need to calculate the check digit for this assignment, but the explanation may help you understand the algorithm.**

Take an account identifier `7992739871`. To make it an account number, we need to calculate and append a check digit. Calling the digit `x`, the full account number will look like `7992739871x`.

We use the algorithm to calculate the correct checksum digit:

```
Account identifier:    7   9   9   2   7   3   9   8   7   1   x
2x every other digit:  7   18  9   4   7   6   9   16  7   2   x
Summed digits over 10: 7   9   9   4   7   6   9   7   7   2   x
Results summed:        7   9   9   4   7   6   9   7   7   2 = 67
```

With the result of `67`, we take the ones digit (`7`) and subtract it from `10`: `10 - 7 = 3`. Thus `3` is the check digit.

The full account number with check digit is `79927398713`.

#### Validating an Account Number

**You do need to build out validation functionality.**

We can use the same process to validate an account number. Using `79927398713` as our sample input:

```
Account identifier:    7   9   9   2   7   3   9   8   7   1   3
2x every other digit:  7   18  9   4   7   6   9   16  7   2   3
Summed digits over 10: 7   9   9   4   7   6   9   7   7   2   3
Results summed:        7   9   9   4   7   6   9   7   7   2   3 = 70
```

Since the summed results modulo 10 is zero, the account number is valid according to the algorithm.

## Assignment

Fork [this](https://github.com/turingschool-examples/credit_check) repository, clone your new repository, and write a program that implements the Luhn algorithm to validate a credit card number.

Start with this template and save it as `credit_check.rb` in your `lib` directory:

```ruby
card_number = "4929735477250543"

valid = false

# Your Luhn Algorithm Here

# Output
## If it is valid, print "The number is valid!"
## If it is invalid, print "The number is invalid!"
```

### Sample Data

If helpful, you can use the following sample data:

* *Valid*: 5541808923795240, 4024007136512380, 6011797668867828
* *Invalid*: 5541801923795240, 4024007106512380, 6011797668868728

### Extensions

* Can you make it work for American Express numbers? 342804633855673 is valid but 342801633855673 is invalid.

### Submission

Use `git` to commit your solution and push to your repository. 

```
$ git add .
$ git commit -m "Add Credit Check"
$ git push origin master
```

Once you have committed and pushed, create a pull request to the Turing School Examples repository. Instructors will comment on your pull request to give you feedback on your code.

More information on committing changes in `git` can be found [here](http://dont-be-afraid-to-commit.readthedocs.io/en/latest/git/commandlinegit.html), and [here](http://gitref.org/basic/). Note: for this exercise, you will not need to check out a branch. The commands you will need are `git add`, `git commit -m "Put your commit message here"`, and `git push origin master`. These guides cover many more commands. This will be a good opportunity for you to read online documentation to pull out only the information you need.

More information on submitting a pull request in GitHub is available [here](https://help.github.com/articles/creating-a-pull-request-from-a-fork/). One note: if you view your repository up to a few minutes after you have pushed your changes, there will be a button to create a new pull request on the front page that will automatically select the upstream repository for you. [This video] shows this at around the 5:35 mark.

## Evaluation Rubric

The project will be assessed with the following guidelines:

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

### 1. Ruby Syntax & Style

Expectations: 

[ ] Naming follows convention (is idiomatic)
[ ] Ruby methods used are logical and readable
[ ] Code is indented properly
[ ] Code does not exceed 80 characters per line

### 2. Breaking Logic into Components

Expectations: 

[ ] Code is effectively broken into methods & classes
[ ] May break the principle of SRP

### 3. Functionality

Expectations: 

[ ] Application meets all requirements (extension not req'd)

