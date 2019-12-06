---
layout: page
title: Play Play
subheading: A song playlist creator project for Module 4 BE
---

## Learning Goals

* Practice project management (create user stories, daily stand-ups and retros)
* Create an Express API given specified endpoints and response formats
* Test endpoints
* Write good documentation
* Practice articulating code presentation and process
* Maintain a good Git workflow with partner

### Requirements Overview

To get started for this project clone the [all-your-base repo](https://github.com/turingschool-examples/all-your-base).
You will want to rename your repo and make adjustments to some of the files(knexfile, migrations etc.) that have pre-existing code.

Next register for an api key for the [Musixmatch API](https://developer.musixmatch.com/)

For this project, the requirements will be given out in mini-sprints.

#### Sprint 1

For the first sprint you will want to have the following completed:

* DTR as a gist
* Deployment to Heroku
* The endpoints listed below

**POST /api/v1/favorites**

You will use the [Musixmatch API](https://developer.musixmatch.com/) to get song information to create a favorite.
_Please note that the rating system should only allow for a number between 1-100. If a genre is not provided, the genre should be "Unknown"._   

To create a new favorite, use the following request parameters:

```
{ title: "We Will Rock You", artistName: "Queen" }
```

Response Body:

```js
{
  "id": 1,
  "title": "We Will Rock You",
  "artistName": "Queen"
  "genre": "Rock",
  "rating": 88
}
```

If a favorite is successfully created, the item will be returned with a status code of 201.
If the favorite is not successfully created, a 400 status code will be returned.

**GET /api/v1/favorites**

Returns all favorited songs currently in the database.
The index of favorites will be returned in the following format:

```js
[
  {
    "id": 1,
    "title": "We Will Rock You",
    "artistName": "Queen"
    "genre": "Rock",
    "rating": 88
  },
  {
    "id": 2,
    "title": "Careless Whisper",
    "artistName": "George Michael"
    "genre": "Pop",
    "rating": 93
  },
]
```

**GET /api/v1/favorites/:id**

Returns the favorite object with the specific `:id` you've passed in.
A 404 is returned if the favorite is not found.

```js

  {
    "id": 1,
    "title": "We Will Rock You",
    "artistName": "Queen"
    "genre": "Rock",
    "rating": 88
  }

```

**DELETE /api/v1/favorites/:id**

Will delete the favorite with the id passed in and return a 204 status code.
If the favorite can't be found, a 404 will be returned.


### Communication Expectations

- Communicate with your instructors if you feel like your team is falling behind or cannot complete the tasks assigned.
- Communicate with your instructors if your team has completed all requirements before the deadline.
- Tag instructors in pull requests on GitHub wherever you'd like feedback.
- If there is any question about functionality, ASK.


### Rubric

You will be graded by an instructor on the criteria in this [rubric](./play_rubric).
