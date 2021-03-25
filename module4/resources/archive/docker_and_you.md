---
layout: page
title: Docker and You
length: 60 mins
tags: docker, container
---

## Learning Goals

By the end of this activity, students should...
- understand the problem Docker aims to solve
- be able to provide a high-level explanation of how Docker works
- pull down a Docker container and run a project locally

## Vocabulary

- Docker
- containers
- images

## The Problem

![inline](https://media.makeameme.org/created/it-works-on-5b27d8.jpg)

## The Solution

![inline](https://msdnshared.blob.core.windows.net/media/2017/10/docker.png)

Docker is software that allows us to:
- Create environments to work in
- Use those environments to pull down code and get started with complex projects with  few commands  
- Push those environments up to be easily distributed to a team or cluster of servers
- Those environments are in a bubble; they can't be affected by other environments or anything on your machine

## Docker and You

You have about 1.5 hours to complete **one** of the following assignments. Documentation for dockerizing a Rails app is [available here](https://docs.docker.com/compose/rails/). Once you've built some context and seen how it works in action, we will go into more depth about how Docker does what it does!

1. Challenge 🔥 Dockerize your QS Rails app
  - Use Rails Docker documentation to dockerize your QS Rails app.
  - If you get working in a container on your machine, push the `Dockerfile` and `docker-compose.yml` to your master branch, and update your README so anyone else could run your app in a Docker container.
  - If time, have a classmate try to run your app in a Docker container. Was your README clear enough? Make any necessary edits.

2. Get some practice first 🦄 Start with a tutorial
  - Follow the tutorial in the README of [this repo](https://github.com/ameseee/docker-rails-api).
  - Use the commands to 'clean up' - then get it up and running again!
  - Once you have that up and running, try to dockerize your QS Rails app!

Whether you did option 1 or 2, be prepared to discuss your answers to the following:
- What commands did you find yourself using the most?
- If you ran into any problems, what were they? What resources were helpful?
- In what capacity do you imagine developers interacting with Docker? How do you think this would fit into your workflow?
- What questions are you left with??

## Debrief

* You're at a job interview and you get asked, "What do you know about Docker?". What do you say?
* You got the job! It's your first week and you are getting all set up. What commands do you know that will be helpful? What resources can you utilize to get set up?
