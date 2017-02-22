---
title: Day 5 - Practice with Atom and Terminal
subheading: Back End Engineering
---

Creating a New Directory/File For Practice
-------------------

1.  Change directories (`cd`) into the `1module` directory.
2.  Create a new directory called "prework_practice". (`mkdir prework_practice`)
3.  Change directories into the new `prework_practice` directory.
4.  Create a new file in the directory called "exercise_practice.rb". (`touch exercise_practice.rb`)
5.  Open the file in Atom. (`atom .` or `atom exercise_practice.rb`)

### Exercise 1

-   In the `exercise_practice.rb` file, create a new string and print it:

    ```ruby
    puts "Turing"
    ```

-   Run the file (`ruby exercise_practice.rb`) and if all is correctly setup, the terminal should display `"Turing"`

-   In your prework gist, answer the following questions regarding the string, "Turing". What ruby command would we use to get:
    1.  The "T" from "Turing".
    2.  The length of "Turing".
    3.  Make the whole string capital letters.
    4.  Delete the "n" from "Turing".
    5.  Assign "Turing" to a variable.

-   Try it out:

    ```ruby
    puts "Turing"

    answer_1 = "Turing"[0]
    puts answer_1

    answer_2 = "Turing".length
    puts answer_2

    answer_3 = "Turing".upcase
    puts answer_3

    answer_4 = "Turing".delete("n")
    puts answer_4

    #answer 5
    turing = "Turing"
    puts turing
    ```

-   The output of your terminal will be:

    ```terminal
    Turing
    T
    6
    TURING
    Turig
    Turing
    ```

### Exercise 2

-   In the `exercise_practice.rb` file, add the following code:

    ```ruby
    puts "What is your first name?"

    first_name = gets
    puts first_name

    puts "What is your last name?"

    last_name = gets.chomp
    puts last_name

    puts "What is your favorite number?"

    fav_num = gets
    puts fav_num

    puts fav_num.to_i
    ```

-   Run the file. (`ruby exercise_practice.rb`)

-   In your prework gist, answer the following questions:
    1.  What does `gets` do?
    2.  What is the difference between the input without the `.chomp` and the input with the `.chomp`?
    3.  What does `fav_num.to_i` do?

### Exercise 3

-   In the `exercise_practice.rb` file, create a new array of animals:

    ```ruby
    animals = ["dog", "cat", "penguin", "armadillo"]

    puts animals
    ```

-   Run the file. (`ruby exercise_practice.rb`)

-   In your prework gist, answer the following questions:
    1.  What does `animals.length` return?
    2.  What does `animals[0]` return?
    3.  What does `animals.empty?` return?
    4.  What are two different ruby commands that add to the `animals `?
    5.  What ruby command is used to remove the last element from the array?


-   Try it out:

    ```ruby
    animals = ["dog", "cat", "penguin", "armadillo"]

    puts animals

    answer_1 = animals.length
    puts answer_1

    answer_2 = animals[0]
    puts answer_2

    answer_3 = animals.empty?
    puts answer_3

    # answer 4
    animals.push("hippo")
    # OR
    # animals << "hippo"
    puts animals

    # answer 5
    animals.pop
    puts animal
    ```

-   The output of your terminal will be:

    ```terminal
    dog
    cat
    penguin
    armadillo
    4
    dog
    false
    dog
    cat
    penguin
    armadillo
    hippo
    dog
    cat
    penguin
    armadillo
    ```
