---
layout: page
title: Intro to Postman and Faraday
length: 180
tags: apis, rails, faraday
---

### Learning Goals

- Understand how to consume API endpoints
- Gain familiarity with the Faraday and Postman HTTP clients
- Consume an API using different HTTP clients

---

#### Warmup

- What is the purpose of an API?
- Why do we expose data through APIs?
- What format is the data in when it is exposed through an API endpoint?

---

#### Exercise - HTTP Requests and Responses

List out the parts of a generic HTTP GET request and response

---

#### Exercise - HTTP Client 1: The Browser

Using the browser, make a GET request to hit the [Github users](https://developer.github.com/v3/users/#get-a-single-user) API endpoint.

`https://api.github.com/users/<username>`

---

#### Exercise - HTTP Client 2: Postman

Download the [Postman API Client](https://www.getpostman.com/product/api-client)

- Using postman, make a GET request to hit the Github users API endpoint.

  - List out the parts of the http request made to hit the Github API endpoint.
  - List out the parts of the http response received from the Github API

---

#### Exercise - HTTP Client 3: Faraday

* Install the [Faraday gem](https://github.com/lostisland/faraday)
* Create a ruby file and require the Faraday library along with your debugger of choice.
* In this newly created Ruby file, make the same HTTP request as the two previous challenges.

---

#### More Practice with Postman and Faraday

Complete the exercises included in this [README](https://github.com/turingschool-examples/pets_api)


#### More API Consumption

In our next class we will be consuming an API in the context of a Rails project. Take a look at the user story and try to complete the exercises to help you prepare for the class.

The user story we will be working on during our next class is as follows:

```
As a user
When I visit "/"
And I select "Colorado" from the dropdown
And I click on "Locate Members of the House"
Then my path should be "/search" with "state=CO" in the parameters
And I should see a message "7 Results"
And I should see a list of 7 the members of the house for Colorado
And they should be ordered by seniority from most to least
And I should see a name, role, party, and district for each member
```

This user story requires us to use the Propublica API to determine the members of the house for a given state. The [Lists of Members](https://projects.propublica.org/api-docs/congress-api/members/#lists-of-members) documentation tells us how to retrieve this data.

---

#### Exercise - Make an API Call Using Postman

1. Sign up for an API key [here](https://www.propublica.org/datastore/api/propublica-congress-api)

2. Use Postman to make an API call to the [members endpoint](https://projects.propublica.org/api-docs/congress-api/members/#lists-of-members)

---

#### Exercise - Make the Same API Call Using Faraday

Do this in a similar way as the previous Faraday challenge where you write your code in a simple Ruby file.

---

#### Whole Group

Q&A
