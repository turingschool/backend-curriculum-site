# Restful Routes & CRUD

---

# Warmup

* What does CRUD stand for?
* Look at your Task Manager controller: what are the eight different method/argument combinations contained there?
* What does each one do?

---

## Vocab

* CRUD
* Resource
* REST
* HTTP Verbs
* URI
* 7 RESTful Routes 

# CRUD

* C - Create
* R - Read
* U - Update
* D - Delete

---

# Resource

* Generic term for something that we have in our application (e.g. tasks, people, movies).
* Tables hold instances of resources
* Often, our applications will have a separate controller and model for each resource.

---

# REST

* Representational State Transfer (ReST) is a web architecture style
* Coined by Roy Fielding in doctoral dissertation (2000)
* A map between HTTP verb/path combinations and CRUD actions users want to perform on a resource

---

# HTTP Verbs

* GET: retrieve a resource from a url
* POST: create a new resource
* PUT: update an entire resource
* PATCH: update part of a resource
* DELETE: remove/destroy a resource

---

# URI

* Uniform Resource Identifier

In this context, the portion of the URL after the domain.

For the URL `https://en.wikipedia.org/wiki/Uniform_Resource_Identifier`, the URI would be `/wiki/Uniform_Resource_Identifier`.

---

# Seven RESTful Routes

Create a table based on Task Manager:

* What a user wants
* Method (verb)
* URI
* Data Prep/Manipulation
* Redirect or Render
* Name of View

---

# Not So RESTful routes

* In task manager, see if you can make a route `localhost:3000/easter_egg` that when you visit, has a picture of a moose on it.
