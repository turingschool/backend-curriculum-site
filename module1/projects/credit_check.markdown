---
layout: page
title: Credit Check
---

### Learning Goals
* break a problem into logical components
* implement appropriate Ruby syntax
* utilize methods and classes

Let's write a program that can detect mistakes in a credit card number.

## Background: Luhn Algorithm

The Luhn algorithm is a check-summing algorithm best known for checking the validity of credit card numbers.

You can checkout the full description on Wikipedia: http://en.wikipedia.org/wiki/Luhn_algorithm

### Description

(adapted from Wikipedia)

The formula verifies a number against its included check digit, which is usually appended to a partial account number to generate the full account number. This full account number must pass the following test:

* starting with the first digit, double the value of every other digit
* if product of this doubling operation is greater than 9 (e.g., 7 * 2 = 14), then sum the digits of the products (e.g., 10: 1 + 0 = 1, 14: 1 + 4 = 5).
* take the sum of all the digits
* if the sum is divisible by ten, the number is valid

### Example

#### Validating an Account Number

Using `5541808923795240` as our sample input:

```
Account number:        5    5    4    1    8    0    8    9    2    3    7    9    5    2    4    0
2x every other digit:  10   5    8    1    16   0    16   9    4    3    14   9    10   2    8    0
Summed digits over 10: 1    5    8    1    7    0    7    9    4    3    5    9    1    2    8    0
Results summed:        70
Divisible by 10?:      70 % 10 == 0
```

Since the summed results modulo 10 is zero, the account number is valid according to the algorithm.

## Assignment

### Setup

1. Fork [this Repository](https://github.com/turingschool-examples/credit_check)
1. Clone your forked repo to your machine with `git clone <ssh key for your repo>`

### Iteration 1 - The Luhn Algorithm

Open `credit_check.rb` in your `lib` directory. You should should this template:

```ruby
card_number = "5541808923795240"

# Your Luhn Algorithm Here

# Output
## If it is valid, print "The number [card number] is valid!"
## If it is invalid, print "The number [card number] is invalid!"
```

Fill out the file so that it will print out the validity of the given card_number. The number included in the template is a valid example.

#### Sample Data

If helpful, you can use the following sample data:

* *Valid*: 5541808923795240, 4024007136512380, 6011797668867828
* *Invalid*: 5541801923795240, 4024007106512380, 6011797668868728

### Iteration 2 - Credit Card Class

Create a `CreditCard` class based on the following criteria:

* A `CreditCard` is passed two arguments upon initialization
  * The first argument is a String representing the card number
  * The second argument is an Integer representing the `CreditCard`'s limit
* A `CreditCard` has getter methods called `card_number` and `limit` for reading the card number and limit
* A `CreditCard` has a method called `is_valid?` that takes no arguments and returns either true or false based on whether or not the card number is valid.
* A `CreditCard` has a method called `last_four` that returns a String of the last four digits of the card number

If the previous criteria are met, you should be able to interact with the `CreditCard` class from a Pry session like so:

```ruby
pry(main)> require './lib/credit_card'
#=> true

pry(main)> credit_card = CreditCard.new("5541808923795240", 15000)
#=> #<CreditCard:0x00007fbb1ca5f698 @card_number="5541808923795240", @limit=15000>

pry(main)> credit_card.card_number
#=> "5541808923795240"

pry(main)> credit_card.limit
#=> 15000

pry(main)> credit_card.last_four
#=> "5240"

pry(main)> credit_card.is_valid?
#=> true
```

### Iteration 3 - Testing

Write tests for your `CreditCard` class that cover that expected behavior described in the previous iteration. If done correctly, the `bank_test.rb` test should also pass.

### Iteration 4 - Extensions

* Create a command line interface that allows the user to validate a number

* Add functionality to calculate the check sum digit.

* Can you make it work for American Express numbers? 342804633855673 is valid but 342801633855673 is invalid
