---
title: How the Web Works II
subheading: Request/Response Anatomy
layout: page
---

## Learning Goals

- Identify the structure of a HTTP Request
- Identify the structure of a HTTP Response
- Describe how users/clients send information through a request

## Vocab

- HTTP Request/Response
- Request/Response Headers
- Request/Response Body
- Query Params

## Warm Up

- What is included in the Request Line (the first line) of an HTTP request?
- What are the 5 common HTTP verbs? And, which CRUD actions do they correspond to?


## HTTP Requests and Responses

The HyperText Transfer Protocol gives us rules about how messages should be sent around the Internet. The system that initiates a connection sends a "request", and the system the answers sends a "response".

## HTTP Request

When a "client" (like a web browser) retrieves information, it sends a payload of data to a server as a "request". This request is made up of three main parts:

- A Request line, containing three piece of information:
  - the HTTP method (also called a **verb**) for sending or retrieving information
  - the URI **path** of the resource where we're sending or retrieving information
  - the version of the HTTP protocol our "client" software is using

- Headers, which is a key/value pair, which contain supplemental information about our request

- An optional body; we only send data to the server in the body when we are creating or modifying something

### Why Headers? Why a Body?

Think about how we handle requests in a rails app.  We tell our application which verb/path combinations to respond to, and which controller/action to activate when we receive that request.  So, why would a request include additional information, like headers and a body?

The headers will include information which may help a server build an appropriate response.  Each client will send different headers to indicate to our server where the request is originating, and any necessary information for sending back a response.

With a `GET` request, we are only asking our application to retrieve some information for us; but if we want to make some change to the database, we need to send more specific information to our server.  For example, if we want to create a new resource, we need to include the information for that new resource.  Generally, this happens through a HTML form and the information that a user enters into the form is sent to our sever through the body of the request.

Let's take a look at this in action.  Open up your Task Manager app from your pre-work, put a `binding.pry` in your `tasks#create` action. Start up your server locally with `rails s` and create a new task.  In your pry session, call `request.raw_body` to see the string that comes in with your post request.  There is a lot of information in there, but somewhere in there, you should see the details of that POST request!


### Query Params

Using the request body is a great way to send information to a server via HTTP request, but it is not the *only* way.  Many requests use **query params** to send additional information as well.

For example, when looking at an index of items, we often want to sort or order those items by specific characteristics.  When we want to accomplish this sorting, it is not efficient to send this information through a form; we need a better way.  Enter **query params**.

Query params are sent to the server as part of the URL itself.  A URL can (and usually does) have many different parts:

* Protocol: `http://` - Tells us the application protocol we will be using to interact on the web.
* Domain: `task-manager.herokuapp.com` - Tells us where the resources we are trying to access are located (tied to an IP address using DNS).
* Path: `/task/new` - The specific path for the resources that we are trying to access at that location.
* Query String: `?sort=alphabetical` - Params that give our server additional information about what we would like to access.
* Fragment Identifier: `#new_form_anchor` - An indicator of a specific section of a website we would like to view (e.g. if there is an anchor tag tied to a heading half way down the page). This can be seen by visiting [this](http://guides.rubyonrails.org/active_record_querying.html#array-conditions) link to the rails docs which references the `array-conditions` section of the Query Interface page.

The "Domain", "Path", and "Query String" combined indicate a unique "identifier" for a resource, and all three of these pieces are a "URI".


## HTTP Response

When the server or web application is finished processing our request, it will send back a response which is a payload of data, and is made up of three main parts:

- a Status line, containing three pieces of information:
  - The version of the HTTP protocol that this response is using
  - a 3-digit numeric "status code"
  - a user-friendly string description of what the "status code" means

- Headers, also sent as key/value pairs similar to the HTTP request

- An optional body; almost all responses will contain additional data in the body. In mod 2, our "body" payload will almost always be HTML.
