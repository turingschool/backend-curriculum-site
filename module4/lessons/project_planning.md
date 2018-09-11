---
title: Real World Project Planning
tags: planning, prototyping
---

## Learning Goals

- Understand why project planning is important for project success
- Explain different methods of planning out a web project
- Understand tools that can be utilized for planning

## Warmup

Take 5 mins to think about the following:
- Think back to your most successful projects at Turing, why were they successful?
- What have you done in the past in terms of planning for software projects?

### But I love coding, why can't I just start?

Having a plan of action before touching the terminal is the key to success when it comes to software projects both big and small.

*Would you try to build a house without blueprints? NO! So why try it with code*

Planning allows us to:
- Dissect the system into necessary components
- Anticipate interactions those components may have
- Research external systems that may be necessary to integrate
- Define iterative steps to achieve MVPs and build on top of it
- Extract similar pieces that may be reusable
- Avoid spaghetti code
- Keep focus on what is important
- KNOW WHAT WE ARE ACTUALLY BUILDING

Different tools are going to be helpful for different types of projects and different types of people. Everyone organizes ideas and thoughts differently so you will see various types of tools used throughout different organizations.

## Mock Ups

Mock ups are great for visualizing how an web application should end up looking like. Many project plans start here then go into breaking down the components needed to build each visual piece. These are commonly used in industry to not only start project but also to explain and clarify features.

Mock ups are visual representations of what the finally app "should" look like. They typically display the layout of each page or section of the application. They can be as simple as napkin drawings to fully designed clickable mock apps. For our purposes a more rough layout of a design can really help us determine the necessary features and feel of the app.

Check out these mock up tools in order of detail & complexity.
[Draw.io](https://www.draw.io/) - (FREE) Check out the layout examples. This is a great tool we can use for a variety of project planning tasks (UML Diagrams, Data Flow Diagrams, etc.)
[Balsamiq](https://balsamiq.com/) - (PAID) Drag & Drop tools to create layouts.
[InVision](https://www.invisionapp.com/) - (FREE) More of a prototyping/workflow tools when working with designs. Helpful for giving developers design specs, not so helpful on small personal projects.

## Mind Map

When first fleshing out ideas, it can be helpful to brain storm and layout all features we can come up with. Using a mind map allow us to do that. Then after we can group different functionalities together to start breaking down what needs to be complete or what tools we made need to complete our project.

Can we use an external api to get this data?
Should we hand roll this auth or would it makes sense to use Facebook or Github OAuth?
We want to track user progress throughout our app, what database tables will we need? What will those relationships look like?

[Mind Mup](https://drive.mindmup.com/) - FREE and integrates with Google Drive

## Iteration Plan

We've seen these many times before. We've been given them for numerous projects and assessments. Why? Because iteration plans help lay out the ordered steps to build either work properly or delivery an MVP. In theory, each step should give us a clear deliverable of what our project should be able to do.

Putting time into thinking about these iteration steps, forces us to begin dissecting the necessary technical components we are going to start building.

To do this:
1. Break down the project into larger features with clear deliverables.
2. Prioritize what is most important. *Is user login essential to the application?*
3. Decide which pieces have dependencies.

## User Stories / Story Board

We use user stories to describe a software feature from an end user perspective. They help explain the type of user, what they want and why. They follow a specific template when writing them out:

`As a <user>, I want <some goal> so that <some reason>`

Once you develop these user stories, you add them to a story board where you are able to prioritize and track each individual story. These user stories are prioritized based on both business needs and technical dependencies. These stories are then often developed in sprint cycles, where the developer estimate which ones they will be able to complete that sprint.

[Waffle](https://waffle.io/) - FREE and integrates well with Github
[Pivotal Tracker](https://pivotal.io/) - More complex tool
[Trello](https://trello.com/) - FREE

## Database Tables

Using one of the methods above should have helped us layout and break down the exact features will need, the components we will need and how those components may interact.

When we continue to break down our project into components, we should try to start visualizing how the database will need to be laid out.

A well-structured database:
- Saves disk space by eliminating redundant data.
- Maintains data accuracy and integrity.
- Provides access to the data in useful ways.

In order to design a useful database, we should follow these steps:
1. Requirements analysis, or identifying the purpose of your database
2. Organizing data into tables
3. Specifying primary keys and analyzing relationships
4. Normalizing to standardize the tables

Thinking about the data in tables forces us to consider interactions that may occur within our system.

[Draw.io](https://www.draw.io/) - We mentioned this above, but it also has tools for this.

## Data Flow Diagrams

Data flow diagrams are visually represent how information flows through the system. They includes data inputs and outputs, data stores, and the various subprocesses the data moves through.

These can be some of the most helpful diagrams when it actually comes down to the details of implementation. They really help us to break down each feature and start thinking of the classes, services, their interactions and their contents.

Take 10 minutes to read the following article about creating Data Flow Diagrams:
[Data Flow Diagram Tutorial](https://www.lucidchart.com/blog/data-flow-diagram-tutorial)

To create your own you can use [Draw.io](https://www.draw.io/) - Again this tool is FREE and great at creating digital drawing very easily.

## Closing

With many of these techniques we are describing them in terms of initial project planning, before a project begins. Many of them can be used throughout the development process when planning out new features for example.

Often with new features, you will want to dig into a bit more detail on things like data flow or database diagrams. Planning these things out before you ever touch the code will make the development process much faster. You are able to show and discuss your plans with other coworkers and work through potential issues or unknown interactions early on.
