---
title: Diagramming the Request & Response Cycle
length: 60min
tags: ruby, http, request_response_cycle
---  


## Learning Goals  
* create a diagram depicting the request/response cycle  
* explain in detail the flow of information through the resquest/response cycle
* speak fluently about technical knowledge

## Structure  
5 min - Warm Up  
10 min - Diagram Request/Response  
20 min - User Stories and the Request/Response Cycle
5 min - Break  
15 min - Large Group Share
5 min - Wrap Up

## Vocabulary  
* request
* response
* client
* server

## Warm Up  
* In your notebook, draw a diagram of how the web works.
* Assume the IP address for the website you're visiting is stored in cache (and therefore no need to draw the entire DNS lookup process).
* Include in this diagram how your server would go about creating the response.
* You can assume your server is built with the MVC design pattern.


## The Request Response Cycle
With a group of 3-4 people, draw out a diagram on a poster of how a client and server interact.

#### Walk the Room    
Take a minute to circulate through the room. Mentally compare and contrast the other posters to the diagram made by your own group. What differences do you see? Which details are included that your group forgot?

** break **

## Following the Bread Crumbs
Following the user stories listed below, take turns talking through the steps of how the process works starting with the user clicking a button on their browser. Physically utilize the diagram your group created.


```
As a user,
When I visit /songs,
Then I see a listing of each song, its title, length, and play count
```

```
As a user,
When I visit /songs/1,
Then I see the title, length and play count of the song matching that ID
```

```
As a user,
When I visit /songs/new
Then I see a new song form
And I see input fields for the song
When I click "Create Song"
Then I see the song listed with its details
```

```
As a user,
When I visit /songs/1/edit
Then I see a new song form
And I see input fields for all attributes
And I see the song's current details in the input fields
And I change any detail about the song
When I click "Update Song"
Then I see the updated details for that song
```

```
As a user,
When I visit /songs/1
Then I see a "Delete" button
When I click the "Delete" button
Then I see a listing of all current songs and their details
And the song I deleted is not longer present
```

Work through each of these user stories with a partner.

Follow the same patterns for `/artists`.

Make sure each person talks through a different piece of functionality than before.

## Group Share
As a group, let's talk through an example from each piece of CRUD functionality.

## Wrap Up  
* How many requests are involved in creating a new record?
* Which part of the process is in charge of packaging up and sending the response?
* Explain in detail what happens when a user visits `www.example.com/songs`


## Additional Resources

* How the Web Works [lesson](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module2/lessons/how_the_web_works.md), [prework](https://github.com/turingschool/intermission-assignments/blob/master/2be/details/how_the_web_works.md)
* [Internals of a Rails Request/Response Cycyle](https://www.rubypigeon.com/posts/examining-internals-of-rails-request-response-cycle/). I recommend focusing on sections 5-8.
* [Completed MVC Diagram](https://drive.google.com/file/d/1-p04Ayx4BtnNwV-WRDlWWSVNp94Kw1in/view?usp=sharing)
