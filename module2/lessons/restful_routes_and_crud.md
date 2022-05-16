---
layout: page
title: RESTful Routes and CRUD
---

## Learning Goals

* Explain CRUD in the context of web applications.
* Explain what is REST
* Be able to distinguish between a RESTful vs non-RESTful route.

## Vocabulary
* CRUD
* REST
* HTTP Verbs
* URI

## Warmup

Based on your Task Manager App:

* What does CRUD stand for?
* Look at your Task Manager routes: what are the eight different method/path/controller#action combinations contained there?
* What does each one do?

## CRUD

* C - Create
* R - Read
* U - Update
* D - Delete

This is a list of the operations we can perform on a _resource_.

In this context, _resource_ is a generic term for something that we have in our application (e.g. tasks, people, movies). Generally, each table we create in our database holds specific instances of a particular resource. We create, read, update and destroy resources in our database.

Often, our applications will have a separate controller and model for each resource.

## REST

* **Representational State Transfer** (ReST) is a web architecture style
* Coined by Roy Fielding in doctoral dissertation (2000)
* REST is a simple way to organize interactions between independent systems
* A map between HTTP verb/path combinations and CRUD actions users want to perform on a resource
* RESTful applications typically treat the web like a resource

### HTTP Verbs

* GET: retrieve a resource from a url
* POST: create a new resource
* PUT: update an entire resource
* PATCH: update part of a resource
* DELETE: remove/destroy a resource

Additional information from the [W3C](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html).

### URI

* **Uniform Resource Identifier**

In this context, the portion of the URL after the domain.

For the URL `https://en.wikipedia.org/wiki/Uniform_Resource_Identifier`, the URI would be `/wiki/Uniform_Resource_Identifier`.

**Think to yourself**

What is the URI for this address? `http://www.tatteredcover.com/book/9781626722934`

### Seven RESTful Routes

Pull up the routes and TaskController from Task Manager. Let's see if you can create a [table](https://docs.google.com/spreadsheets/d/1QLaehcK8r_uBlmlKNcgGwCb7Mdq3w7Q2B1o7ilKFS0s/edit?usp=sharing) for seven RESTful routes allowing us to perform all CRUD actions on a Task. Include the following:

* Method (verb)
* Path/URI
* Controller
* Controller action
* What does it do?


**Complete the table. You can either make a copy of the spreadsheet, or diagram this in your notebook.**

Is there a command you can run from your terminal to help with the diagram? (HINT)


### Not So RESTful routes

* Do research. What is an example of a non-RESTful route?
  * `/tasks/add`
  * `/tasks/show_all`
  * etc


## WrapUp
* What is each part of CRUD?
* What is REST?
* How do we combine CRUD and REST in web applications?
* Record a version of the restful routes table in your notes

## Additional Resources

* [Representational State Transfer](https://en.wikipedia.org/wiki/Representational_state_transfer) on Wikipedia
* [What is REST?](http://www.restapitutorial.com/lessons/whatisrest.html) from REST API Tutorial
* [Another Video](https://www.youtube.com/watch?v=2zz_XvKTVxI)
