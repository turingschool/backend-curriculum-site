# Refactor(90-120 minutes)

## Objectives
-   To have a clear strategy to tackle refactoring interviews
-   Understand what employers are looking for

* Overview
  * Summary
  * Beginning questions
  * Things interviewer is looking for
  * Have Mike(or a student) do a live refactoring
  * Discuss the refactor
  * Refactoring strategy
  * Tunnel vision
  * Have students do a problem on pen an paper

### Summary(3-5 minutes)
  * Refactor interview is either a take home or a live coding exercise
  * They give you a bunch of spaghetti code and ask you to Refactor
  * Often comes with a working test suite that covers the functionality they want to cover
  * They might ask you to refactor just one class, it could be to refactor many classes
  * Code is functional
  * They generally won't ask you to write any new features

### Beginning questions?(1-3 minutes)
  * Ask if you should write any unit tests
  * Clarify the requirements of the refactoring exercise

### Things interviewer is looking for(9-15 minutes)
  * Is the test suite almost always green(Run your tests constantly)
  * Do they follow generally good programming practices
    * Law of Demeter
    * Encapsulation
    * Single Responsibility Principle
      * One good thing to think about when following good OOP practices is
        pass values not objects.
    * Ruby conventions
    * What domain do I belong to??(For instance in the movie rental exercise I will post
      what information belongs on the rental, movie, how about calculating the statement?)
    * Naming
    * Performance
  * Do they collaborate?
  * Do they ask good questions?
  * Do they explain what they are doing?
    * Interviewers don't like if person they are evaluating goes quiet


### TA or brave student does a live refactoring(45-55 mins)
  * Give everyone including the staff you've convinced to do live refactoring 15-20
    mins to come up with a gameplan for this refactoring exercise.[Blockbuster Video](https://github.com/michelgrootjans/videostore)

  * Have them post their strategies in a thread on slack at the end of the time period
  * Road Show! Do the live refactoring, as the interviewer be somewhat helpful, but do not give away too much.  Give the person
    doing the refactor some room to struggle.
  * Have the students write down a pro and con while they are watching this mock interview.

### Discuss the refactor(15-20 minutes)
  * Have students share pros and cons
  * Have interviewer share how they felt etc.


### Refactoring strategy(7-10 mins)
  * Start small
  * ALWAYS COMMENT OUT THE WORKING CODE FIRST
    * Then delete comment, when your refactor works
  * Possible order of how to refactor
    * Conditional statement into a boolean ruby method
    * A chunk of code that makes up one concept(3-5 lines)
      * ex. how to calculate a non late rental for a new movie
    * A bigger chunk of code
      * ex. how to calculate a cost for any new movie
      * ex. then bigger, how to calculate cost for any movie
    * Now you can start thinking, does this belong in a different class
      * Which domain object do I belong to
  * Have you been running your tests a lot you silly goose??? Do they pass?

### Tunnel vision(3-5 minutes)
  * Lets say you don't know where to go from here, you are super stuck.
    * Maybe it's an error you can't figure out, or you don't know the next step.
  * Ask a good question to your interviewer to help you get unstuck
  * If you are going to go silent to think about something, let your interviewer know.
  * If you are so nervous to even know what to type next, try telling your interviewer,
    step by step how you would solve the problem.

### Students practice Yahtzee(1-2 mins)
  * Here is a Yahtzee refactoring
  * If you want to submit we will do a code review
  * [Dice Game](https://github.com/BobGu/dice-game)
