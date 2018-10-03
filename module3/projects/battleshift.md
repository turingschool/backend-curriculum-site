---
title: Battleshift
length: 2 weeks
tags:
type: project
---

## Project Description

You will be building on top of a pre-existing API implementation of the game Battleship, found [here](https://github.com/turingschool-examples/battleshift). The current project allows a player to play against a computer through an API. The "real world" scenario for having an API for a game would be to support multiple devices to connect through the same interface. For example: An Android app, an iPhone app, and a desktop app could all use the same API to play this game.

For this project we will start building the interface for the desktop application, add multiplayer functionality, and create basic levels of security.

**Why?** Most devs are building on top of existing code bases where we have to inherit and deal with the technical debt and decisions of those that came before us. Understanding how someone's decisions impact a team is an important part of learning how to write maintainable software. You also rarely have time for a complete rewrite so deciding what to care about and when becomes as important a skill as being able to write code.

## Learning Goals

* Explain what dogfooding is and why we would do it
* Learn to consume a JSON API
* Lock down an API using unique keys
* Build on top of brownfield code
* Empathy for developers facing deadlines
* Empathy for teammates that might work with your code in the future (or future you!)
* Prioritize what code is relevant to your immediate task (and ignore the rest)
* Send email from a Rails application

## Requirements

Your app will only be assessed for what has made it into production. Your evaluator will use your production URL to run a [spec harness](https://github.com/turingschool-examples/battleshift_spec_harness) to check basic functionality of the game play through the JSON API. However, it is expected that you write more thorough tests on your application.

Use the rubric below to self assess your project and bring this to the eval with your instructor. Be prepared to show examples for each box you check.

### Week 1

**Days 1 and 2:** Each team member should start a spike branch for the story below and should not pair. Questions and collaboration are encouraged but it is really important that each student does the work. Complete the following user story. The controller that is hit using the URL below should not go directly to the database. Your app should consume your own API to accomplish the task below (AKA dogfooding).

```
Title: Dogfooding GET /api/v1/users/:id

Background: There is a user stored in the database with an id of 1, name of Josiah Bartlet, email of jbartlet@example.com

As a guest user
When I visit "/users/1"
Then I should see the user's name Josiah Bartlet
And I should see the user's email address jbartlet@example.com
```

Once both team members have completed the above user story, create a new branch. Share your implementations with each other and discuss how you would like to approach the user story as a pair. Use acceptance tests to drive the development of the user story. Ship it!

Each team member should start a spike branch for the story below and should not pair. Questions and collaboration are encouraged but it is really important that each student does the work. Complete the following user story. The controller that is hit using the URL below should not go directly to the database. Your app should consume your own API to accomplish the task below (AKA dogfooding).

```
Title: Dogfooding GET /api/v1/users/

Background: There are two users stored in the database

As a guest user
When I visit "/users"
Then I should see the user's name (for both users)
And I should see the user's email (for both users)
```

Once both team members have completed the above user story, create a new branch. Share your implementations with each other and discuss how you would like to approach the user story as a pair. Use acceptance tests to drive the development of the user story. Ship it!

**Days 3 and 4:** Using the same process as above complete the task below.

```
Title: Build PATCH /api/v1/users/:id

API should only support changing a users's email address
```

```
Title: Edit a user's email address (dogfooding PATCH /api/v1/users/:id)

Background: There is a user stored in the database with an id of 1, name of Josiah Bartlet, email of jbartlet@example.com

As a guest user
When I visit "/users"
And I click on `Edit` for Josiah Bartlet
Then I should be on "/users/1/edit"

When I fill in the email field with "josiah@example.com"
And I click "Save"
Then I should be on "/users"
And I should see a flash message that says "Successfully updated Josiah Bartlet."
And I should should see Josiah Bartlet's email show up in the list as "josiah@example.com"
```

**Day 5:** Complete the following stories prior to working on the spec harness failures. Once these are complete, start with the `game_play_spec` in the spec harness.

```
As a guest user
When I visit "/"
And I click "Register"
Then I should be on "/register"
And when I fill in an email address (required)
And I fill in name (required)
And I fill in password and password confirmation (required)
And I click submit
Then I should be redirected to "/dashboard"
And I should see a message that says "Logged in as <SOME_NAME>"
And I should see "This account has not yet been activated. Please check your email."
```

```
Background: The registration process will trigger this story

As a non-activated user
When I check my email for the registration email
I should see a message that says "Visit here to activate your account."
And when I click on that link
Then I should be taken to a page that says "Thank you! Your account is now activated."

And when I visit "/dashboard"
Then I should see "Status: Active"
```

```
Background: The registration process will trigger this story

As a non-activated user
When I check my email for the registration email
Then I should see a unique API key to use for making API calls
```

**Day 6+:** Work through the spec harness.

## Extensions

**Mild**

* Prevent two players from playing more than one game

**Medium**

* Use Twilio to send SMS alerts when your opponent invites your to play and when they make a move. (Note: free Twilio accounts will only allow messages to be sent to one number but you can still build all of the functionality with this limitation.)

**Spicy**

* Create a web interface for the game by consuming your API
* Add support for both player vs player and player vs computer. Make the AI for the computer better than it currently is.

## Evaluation

Each team should use the rubric below to self assess your project. Bring this to the eval with your instructor. Be prepared to show examples for each box you check.

### Passing?

- [ ] Yes
- [ ] No

### Developer Empathy and Technical Debt

- [ ] Dev(s) can point out areas where they may have created or added to technical debt (required)
- [ ] Dev(s) can explain how the previous developers could have written their code to be more maintainable (required)

### Completion

- [ ] All user stories complete (required)
- [ ] All spec harness tests are passing (required)
- [ ] All requirements set by your instructor have been met. (required)

### Testing

- [ ] I would be satisfied paying for this test suite. (required)
- [ ] Common edge case are tested. (5 required)
- [ ] Unit testing is above 90%. (required)

**Passing project utilize two or more of these techniques in multiple tests:**

- [ ] Fixtures
- [ ] Mocks
- [ ] Stubs
- [ ] Doubles
- [ ] Spies

### Code Quality

- [ ] Project uses polymorphism (required)

**Passing project uses one (required) or more of the following**

- [ ] Project uses encapsulation
- [ ] Project uses abstraction
- [ ] Project uses inheritance

### Explorers and Risk Takers

- [ ] Project was built with fearlessness. (Bonus)
