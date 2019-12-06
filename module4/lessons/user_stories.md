---
title: Writing Effective User Stories
layout: page
---

### Intro

Breaking down what you want to build is incredibly important when it comes to software. Too often, we decide that we’re going to build an application that does something specific without much upfront planning. This is where we can utilize writing stories to help us know what lego blocks we’ll need to build out in order to accomplish our final end goal.  

### Vocabulary

* Project board
* Features
* User stories
* Chores
* Bugs
* Story labels
* Persona
* Acceptance criteria
* Sprint

### Discussion: How are you currently writing user stories?

#### Questions to ask while writing user stories

* Who is the persona you are focusing on? This should be defined
* What is the goal of the persona for your story?
* What should happen when the persona is successful in their goal?
* What should happen when the person isn’t successful in their goal?
* What is the acceptance criteria for your user story?

#### User story titles

The titles of your user stories should convey what is being worked on and what the user will be able to do once it has been accomplished. For example: 

* `User can create a new account with the /sign_up endpoint`
* `User can updatee user_profile information to an existing profile`
* `Admin can update account information in their organization`

#### Story details

Each story should be descriptive and outline a few things: 

* Is this a JSON endpoint? If so, what does the request and response payloads look like? What happens when the user is unsuccessful? 
* Is this a frontend story? If so, what is the entire workflow of the user when attempting to accomplish the stories task? 
* Are there any additional resources that would make the story more clear? This could include wireframes, schema designs, etc. 
* The more information given in the story will allow you to start working without the need to ask too many questions. 

#### Bugs and Chores

If a *bug* is discovered in the middle of working on a feature, a new story should be created in order to track it. If you are busy working on a particular feature, another person on your team could take care of it in the meantime. If the bug blocks you from completing your current story, you should save your work, flip to a new branch, and begin working on fixing it. Once completed, you may return to your original story. 

*Chores* are tasks that can be taken care of towards the end of a project or sprint. These tasks include refactoring, updating documentation, and a variety of project clean up. Reserve doing these stories until the end of your prescribed sprint(s). 

#### Labels

One way to organize your work is to use labels. Labels give us the ability to classify different pieces of our work into smaller chunks. If you are working on JSON endpoints, then a label of `endpoint` may be useful in letting your teammates know what kind of a story they’d be picking up. This could also apply to frontend stories as well. 
