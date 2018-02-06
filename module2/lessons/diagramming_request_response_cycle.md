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
10 min -   
5 min - Break  
20 min -  
5 min - Wrap Up

## Vocabulary  
* request
* response
* client
* server

## Warm Up  
* In your notebook, draw a diagram of how the web works. Assume the IP address for the website you're visiting is stored in cache (and therefore no need to go through the DNS lookup). Include in this diagram how your server would go about creating the response. You can assume your server is built with an MVC structure.


## The Request Response Cycle
With a group of 3-4 people, draw out a diagram on a poster of how a client and server interact. 

#### Walk the Room    
Take a minute to circulate through the room. Mentally compare and contrast the other posters to your own groups'.

** break **

## Following the Bread Crumbs 
Following the user stories listed below, take turns talking through the steps of how the process works starting with the user clicking a button on their browser. Physically utilize the diagram your group created.


```
As a user, 
When I visit /movies,
Then I see a listing of each movie and its title
```

```
As a user,
When I visit /movies/1,
Then I see the title and description of that movie
```

```
As a user,
When I visit /movies/new
Then I see a new movie form
And I see input fields for title and description
When I click "Create Movie"
Then I see the title and description of that movie
```

```
As a user,
When I visit /movies/1/edit
Then I see a new movie form
And I see input fields for title and description
And I see the movie's current title and description in the input fields
When I click "Update Movie"
Then I see the updated title and description of that movie
```

```
As a user,
When I visit /movies/1
Then I see a "Delete" button
When I click the "Delete" button
Then I see a listing of all current movies and their titles
```

If you work through each of these user stories. Follow the same patterns for `/directors`. Make sure each person talks through a different piece of functionality than before.

## Group Share
As a group, let's talk through an example from each piece of CRUD functionality.

## Wrap Up  
* How many requests are involved in creating a new record?
* Which part of the process is in charge of packaging up and sending the response?
* Explain in detail what happens when a user visits `www.example.com/movies`


## Additional Resources

* How the Web Works [lesson](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module2/lessons/how_the_web_works.md), [prework](https://github.com/turingschool/intermission-assignments/blob/master/2be/details/how_the_web_works.md)
* [Internals of a Rails Request/Response Cycyle](https://www.rubypigeon.com/posts/examining-internals-of-rails-request-response-cycle/). I recommend focusing on sections 5-8.