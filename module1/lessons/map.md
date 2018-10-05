---
title: Map
length: 60
tags: enumerables, map, each
---

## Learning Goals

* Learn how to use & recreate the functionality of `.map` using `.each`
* Understand when and how to use `.map` appropriately.


## Vocabulary  
* enumerable  
* iterate  
* map
* return value

## Warm Up  
* What is an **enumerable**? What is a use case for one?  
* In your notebook, write the block of code to use `.each` to print each letter in the following array `dynasty_1 = ["K", "e", "n", "n", "e", "d", "y"]`

## Intro

We've already learned how to use each, and we can do some really cool
things with it, but let's do better.

### `map` / `collect`

`map` is a lot like `each`.

The difference is that `map` actually _returns whatever we do in the block_. Think about how this is different from each which will always return the content of the _original_ array.

Let's look at this in code. Taking an array of the numbers, we want to end up with an array with the doubles of each of those numbers. With `each`, we would do it like this:

```ruby
def double                    # define a method called double
  numbers = [1, 2, 3, 4, 5]   # declare a numbers variable with the value of an array

  result = []                 # declare a variable, results, with the value of an empty array

  numbers.each do |num|       # use `.each` to iterate over the numbers array
    result << num * 2         # shovel the current number x 2 into the result array
  end                         # end the `.each` method

  result                      # return the result array
end                           # end the double method

result
=> [2, 4, 6, 8, 10]           # our array of doubles

numbers
=> [1, 2, 3, 4, 5]            # numbers array, which is unchanged
```

We've written a method called `double`. We start off with `result`, which we set to an empty array. With each, we iterate through each item of `numbers`, and with each element, we are doubling the number and we are putting it into the `result` array. At the end, we are returning the `result` variable, which should now contain [2, 4, 6, 8, 10].

This code is decent. But there are things about it I'm not entirely thrilled about. For example, we are temporarily storing things in a variable, `result`, which is inefficient. You want to avoid the use of unnecessary variables when you can. This is how we can achieve the same result using `.map`.

```ruby
def double                # define a method called double
  numbers = [1, 2, 3, 4, 5]   # declare a numbers variable with the value of an array

  numbers.map do |num|    # iterate over numbers with `.map`
    num * 2               # number x 2
  end                     # end the `.map` method

end                       # end the double method

double
=> [2, 4, 6, 8, 10]       # our numbers array has been changed!
```

Instinctually, this should look better to you. We don't have any unnecessary variable assignment and `map` is handling all we need to return.

```ruby
def double
  numbers = [1, 2, 3 ,4, 5]

  numbers.map do |num|
    num * 2
    puts "I really love math"
  end

end
```

#### Discuss:
* With this code, what do you think this method returns? Why?  
* Many folks are tempted to save the result of map to a variable. Why might I disagree with this choice?  

#### Independent Practice
The method below returns an array of the brothers names in all caps; your job is to write one using the `map` method. (Touch an `enums_practice.rb` file in your M1 directory and write the code in that file)

```ruby
def kennedy_brothers
  brothers = ["Robert", "Ted", "Joseph", "John"]

  caps_brothers = []

  brothers.each do |brother|
    caps_brothers << brother.upcase
  end

  caps_brothers

end
```
**Annotate**
Annotate each line of your new code the way the examples above were, to describe exactly what is happening at each line.

**Turn & Talk**  
Share you code with your neighbor.  Talk them through your annotations - be specific. What is similar/different? Why did you make the choices you made?  

## Final CFU
* What do `#map`, and `#each` do? What do they return?
* When is `#map` preferable to `#each`

### Additional Practice
* Work on the `map`, `find`, and `select` exercises for [Enums-Exercises](https://github.com/turingschool/enums-exercises).
