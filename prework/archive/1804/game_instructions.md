---
title: Turing School Prework - Game
subheading: Back End Engineering
---

Create a Game!
----------------
Now that you have had some practice with Ruby, let's continue to practice using our editor and terminal together.

### Setup

-   From your command line, create a new folder in your `1module` directory called `prework_game`. This is where you will store your game file.
-   From your command line, create a new file in the folder `prework_game` called `guessing_game.rb`
-   In the file, enter the lines:

    ```ruby
    puts "I have generated a random number for you to guess, what is your guess?"
    ```

-   If all is set up correctly, running `ruby guessing_game.rb` from your command line (while in the `prework_game` directory) will print the line "I have generated a random number for you to guess, what is your guess?" in your terminal.

### Before You Begin

-   Try pseudocoding the problem.
-   What is pseudocoding?
    -   Pseudocode is an informal high-level description of the operating principle of a computer program or other algorithm.
    -   As programmers, we use comments (`#`) in our editor to pseudocode.

        ```ruby
        # When I start the program, it prints "I have generated a random number for you to guess, what is your guess?"
        # A random number is generated (set to a variable?)
        ```
-   A generalized process for solving technical problems:
    1.  How will you know when the problem is solved? (Identify the big-picture goal)
    2.  How do you want to use the software? (Identify the “interface”)
    3.  What’s the (next-)most trivial possible case? (Identify the next small-picture goal)
    4.  How do we achieve this goal? (Sketch an algorithm using pseudocode)
    5.  Implement it (do programming)
    6.  Is the whole problem (from step 1) solved? If not, return to 3.
-   <a href='https://www.vikingcodeschool.com/software-engineering-basics/what-is-pseudo-coding' target='blank'>This</a> description and the examples within, are helpful in understanding why pseudocoding is a very important process.

### Instructions

-   The computer should generate a random number in the range of 1 to 100.
-   The computer should prompt the user to guess the random number.
-   Level 1: If the guessed number is the same as the random number, the computer responds with `You guessed the right number!`, if it is not correct, the computer responds with `Guess again` and the computer prompts the user for another guess.
-   Level 2: When the user responds with their guess, the computer must check whether the guess is higher or lower than the random number and respond accordingly, asking for another guess if the guess is wrong.
-   Level 3: In the instructions, add the ability to cheat. If the user inputs (c) or (c)heat, the random number is shown to them.
-   Level 4: Add a hint. Maybe when the user guesses incorrectly, the computer gives the user a mathematical hint about the number. Get creative! For instance:

    ```ruby
    puts "The secret number is divisible by 5."
    ```

### Some Hints:

-   Wondering how to get the user's input? See <a href='https://learnrubythehardway.org/book/ex11.html' target='blank'>here</a> for more information.
-   Wondering how to continually ask for input? Check out information about loops <a href='https://www.tutorialspoint.com/ruby/ruby_loops.htm' target='blank'>here.</a>
-   Most everything is searchable on the internet so try to think of some key words to search for and add the word `ruby` after, to see results.
