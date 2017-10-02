---
layout: page
title: RESTful Routes and CRUD
---

## Learning Goals

  - Explain CRUD in the context of web applications.
  - Create a routes reference chart for the seven RESTful routes.
  - Be able to distinguish between a RESTful vs non-RESTful route.

## CRUD

  - C - Create
  - R - Read
  - U - Update
  - D - Delete  
  - The above operations apply to a resource. A resource is the term used for a collection of similar objects, such as tasks, people or movies. You can create, read, update and destroy items for a resource.

## Routes Recap - Task Manager Let's step back from Sinatra for a moment to talk generally about the web.

  - Routes in Sinatra are defined as part of its DSL (Domain Specific Language).
  - These routes should look similar to other `do`/`end` blocks you're used to from Ruby.
  - The first keyword of these routes corresponds with the **HTTP verb** the request is making to the route.
  - The param this keyword takes is a string version of the **path** the request is being made to.
  - Inside the block, we tell Sinatra how to handle the request.

### How Do We Handle Route Requests?

  Most likely with one of the following:

  - `erb`
  - `redirect`

## RESTful Routes

### What does REST mean?

  - Representational State Transfer
  - Uniform URLs
  - Structured
  - Patterned

### RESTful Routes  

  - RESTful routes provide us with a design pattern that we can follow:
  - A map between HTTP verb/path combinations and CRUD actions users want to perform on a resource.

### Using REST in Our App

  - When your application receives an HTTP request, it identifies the HTTP method and URL, connects that with a connected controller action that has that method and URL, executes the code in that action, and determines which response gets sent back to the client.
  - Let's chart out the "Golden Seven" RESTful routes.

### Not So RESTful routes

  - In task manager, see if you can make a route `localhost:3000/easter_egg` that when you visit, has a picture of a moose on it.
