---
layout: page
title: Intro to Postman and Faraday
length: 180
tags: apis, rails, faraday
---

### Learning Goals

- Understand how to consume API endpoints
- Gain familiarity with the Faraday and Postman HTTP clients

### Vocabulary

* __API Endpoint__: An address to which a client can request information
* __JSON__: JavaScript Object Notation
* __Client__: A program that relies on requesting information from a server
* __Postman__: A tool that allows developers to visualize the parts of HTTP requests and responses
* __Faraday Gem__: An HTTP client library that allows developers to more easily write requests and handle responses in Ruby

### Warm Up

* What is the purpose of an API?
* Why do we expose data through APIs?
* What format is the data in when it is exposed through an API endpoint?

### Overview

In the intermission work, you were asked to write out the anatomy of a HTTP request and response. Feel free to reference your diagram or create a new one from today's review. We will be looking at the types of requests & responses you made in Mod 2 for HTML and how they compare to the requests and responses from APIs.

Throughout the lesson you will have the opportunity to explore how to make a `GET` request to an API using different clients: the browser, Postman, and a Ruby file using the Faraday gem. For each of these, we will look at how to make the request and how to understand the response that is returned. We will also discuss some of the benefits to using these tools and explore documentation.

### HTTP Request and Response Review

List out the parts of a generic HTTP GET request and response

#### HTTP Client 1: The Browser

Using the browser, make a GET request to hit the [GitHub users](https://developer.github.com/v3/users/#get-a-single-user) API endpoint.

`https://api.github.com/users/<username>`


* How did you make this request?
* What does the response look like?
* What information is included in the response?


#### HTTP Client 2: Postman

Download [Postman app](https://www.postman.com/downloads/) Take a minute to explore the different tabs and options in Postman.

After you've explored Postman, try to make a GET request to hit the Github users API endpoint.

* How did you make this request in Postman?
* What is the status of the response?
* What is included in the response's Headers?


#### HTTP Client 3: Faraday

Explore the [Faraday Gem Docs](https://lostisland.github.io/faraday/). Then create a Ruby file and require the Faraday library and Pry at the top of it. In this newly created Ruby file, use the Faraday docs to make the same HTTP request to the GitHub users endpoint.

* How did you make this request using Faraday?
* What is the return of the of the request?
* How can you access just the body of the response?

### Practice with Postman

We've practiced making a `GET` request, so now let's try making requests using other HTTP verbs.

Using Postman, try to get a successful response from each of the endpoints below. If you haven't installed Postman you can do so [here](https://www.postman.com/product/api-client/). 

Then, use Faraday to get a successful response from each of the endpoints below. You'll need to install the [Faraday gem](https://github.com/lostisland/faraday), create a Ruby file and require the Faraday library along with a debugger such as [pry](https://github.com/pry/pry). In this new Ruby file, write requests for each endpoint and use your debugger to check the response body.

#### Endpoints

__Request `GET https://pets-api.turingschool-examples.com/api/v1/pets`__

Example Response:
```json
[
  {
    "id": 1,
    "name": "Wile E.",
    "animal_type": "coyote",
    "age": 4,
    "created_at": "2020-05-05T14:41:55.013Z",
    "updated_at": "2020-05-05T14:41:55.013Z"
  },
  {
    "id": 2,
    "name": "Road Runner",
    "animal_type": "bird",
    "age": 1,
    "created_at": "2020-05-05T14:41:55.021Z",
    "updated_at": "2020-05-05T14:41:55.021Z"
  },
  {
    "id": 3,
    "name": "Tweety",
    "animal_type": "bird",
    "age": 15,
    "created_at": "2020-05-05T14:41:55.028Z",
    "updated_at": "2020-05-05T14:41:55.028Z"
  },
  {
    "id": 4,
    "name": "Sylvester",
    "animal_type": "cat",
    "age": 2,
    "created_at": "2020-05-05T14:41:55.037Z",
    "updated_at": "2020-05-05T14:41:55.037Z"
  }
]
```

__Request `GET https://pets-api.turingschool-examples.com/api/v1/pets/:id`__

Example Response: 
```json
{
  "id": 1,
  "name": "Wile E.",
  "animal_type": "coyote",
  "age": 4,
  "created_at": "2020-05-05T14:41:55.013Z",
  "updated_at": "2020-05-05T14:41:55.013Z"
}
```

__Request `POST https://pets-api.turingschool-examples.com/api/v1/pets?name=Bugs&animal_type=bunny&age=5`__

Example Response:
```json
{
    "id": 6,
    "name": "Bugs",
    "animal_type": "bunny",
    "age": 5,
    "created_at": "2023-05-11T17:11:43.883Z",
    "updated_at": "2023-05-11T17:11:43.883Z"
}
```

SPICY DIFFICULTY: This API will accept data via query params, but some providers will require you to send information in the _body_ of your HTTP requests. Try sending the data for a new pet via the request body.

__Request `DELETE https://pets-api.turingschool-examples.com/api/v1/pets/:id`__

Example Response:
`204 No Content`

__Request `PUT https://pets-api.turingschool-examples.com/api/v1/pets/:id?animal_type=doggo`__

Example Response:
```json
{
    "id": 8,
    "animal_type": "doggo",
    "name": "Athena",
    "age": 3,
    "created_at": "2023-05-11T17:12:20.345Z",
    "updated_at": "2023-05-11T17:12:56.662Z"
}
```

SPICY DIFFICULTY: Try sending the data for the update via the request body.

### Check for Understanding

* What is a limitation of using a browser as an HTTP client?
* How can we use Faraday to pass a body or header information in an HTTP Request?
* Describe the way you might use Postman during the development process.


---

Looking for more practice? Try [here](./exercises/additional_api_consumption_practice)
