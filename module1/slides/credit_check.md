# Credit Check

---

# Evaluation

1. Ruby Syntax & Style
1. Breaking Logic into Components
1. Functional Expectations

---

# Fundamental Ruby & Style

* 4: Application demonstrates excellent knowledge of Ruby syntax, style, and refactoring
* 3: Application shows strong effort towards organization, content, and refactoring
* 2: Application runs but the code has long methods, unnecessary or poorly named variables, and needs significant refactoring
* 1: Application generates syntax error or crashes during execution

---

# Encapsulation / Breaking Logic into Components

* 4: Application is expertly divided into logical components each with a clear, single responsibility
* 3: Application effectively breaks logical components apart but breaks the principle of SRP
* 2: Application shows some effort to break logic into components, but the divisions are inconsistent or unclear
* 1: Application logic shows poor decomposition with too much logic mashed together

---

# Functional Expectations

* 4: Application meets all requirements, and implements one extension properly.
* 3: Application meets all requirements as laid out per the specification.
* 2: Application runs, but does not work properly, or does not meet specifications.
* 1: Application does not run, crashes on start.

---

# Assignment

Write a program that implements the Luhn algorithm to validate a credit card number.

Start with this template and save it as credit_check.rb:

```ruby
card_number = "4929735477250543"

valid = false

# Your Luhn Algorithm Here

# Output
## If it is valid, print "The number is valid!"
## If it is invalid, print "The number is invalid!"
```

---

# Luhn Algorithm

![inline](luhn.png)

---

# Sample Data

* Valid:
    * 5541808923795240
    * 4024007136512380
    * 6011797668867828
* Invalid:
    * 5541801923795240
    * 4024007106512380
    * 6011797668868728

---

# Extension

* Can you make it work for American Express numbers?
    * 342804633855673 is valid
    * 342801633855673 is invalid.

