---
title: Viewing Party Solo Requirements
length: 1 week
type: project
---
<style>
summary:hover {
  background-color: #bbe5fa;
}
</style>


_[Back to Viewing Party Home](./index)_

### Requirements Overview

- Consume [The Movie DB API](https://developers.themoviedb.org/3/getting-started/introduction)
  - NOTE: You must first register an account with this service and request an API key. 
  - You must also use the **Faraday** gem to consume this API. 
- Test consumption of your API, making sure to use **Webmock** (and/or a tool like VCR) to stub external HTTP requests.

### Setup
To start, fork from [this base repo](https://github.com/turingschool-examples/viewing_party_solo_7). Follow the setup instructions in that project's README.

Wireframes found [here](./wireframes) can be used as an additional reference for the front-end.

---

## Project Specs

<details><summary><h3>1. Discover Movies: Search by Title</h3></summary>
```
As a user,
When I visit the '/users/:id/discover' path (where :id is the id of a valid user),
I should see
- a Button to Discover Top Rated Movies
- a text field to enter keyword(s) to search by movie title
- a Button to Search by Movie Title
```

**Notes:** 

When the user clicks on the Top Rated Movies OR the search button, they should be taken to the movies results page (more details of this on the `2. Movies Results Page` story). 

The movies will be retrieved by consuming [The MovieDB API](https://developers.themoviedb.org/3/getting-started/introduction).

<hr/>
</details>

<details><summary><h3>2. Movie Results Page</h3></summary>

```
When I visit the discover movies page ('/users/:id/discover'),
and click on either the Discover Top Rated Movies button or fill out the movie title search and click the Search button,
I should be taken to the movies results page (`users/:user_id/movies`) where I see: 

- Title (As a Link to the Movie Details page (see story #3))
- Vote Average of the movie

I should also see a button to return to the Discover Page.
```

**Notes:** 

* There should only be a maximum of 20 results. The above details should be listed for each movie.
<hr/>
</details>

<details><summary><h3>3. Movie Details Page </h3></summary>

```
As a user, 
When I visit a movie's detail page (`/users/:user_id/movies/:movie_id`) where :id is a valid user id,
I should see
- a button to Create a Viewing Party
- a button to return to the Discover Page

I should also see the following information about the movie:

- Movie Title
- Vote Average of the movie
- Runtime in hours & minutes
- Genre(s) associated to movie
- Summary description
- List the first 10 cast members (characters & actress/actors)
- Count of total reviews
- Each review's author and information

```

**Notes** 
* The above information should come from 3 different endpoints from [The Movie DB API](https://developers.themoviedb.org/3/getting-started/introduction).
* The "Create a Viewing Party" button should take the user to the "New Viewing Party" page (`/users/:user_id/movies/:movie_id/viewing_party/new`) - see story #4.

<hr/>
</details>

<details><summary><h3>4. New Viewing Party Page</h3></summary>

```
When I visit the new viewing party page ('/users/:user_id/movies/:movie_id/viewing_party/new', where :user_id is a valid user's id and :movie_id is a valid Movie id from the API),
I should see the name of the movie title rendered above a form with the following fields:

- Duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set to a value less than the duration of the movie
- When: field to select date
- Start Time: field to select time
- Guests: three (optional) text fields for guest email addresses 
- Button to create a party
```
**Notes:**
* When the party is created, the user should be redirected back to the dashboard where the new event is shown.
* The user who created the event should be designated the **host**. There should only ever be 1 host of the party. *(Hint: check your `schema.rb`)*
* The event should also be listed on any other existing user's dashboards that were also invited to the party. 
* Optionally, you can create a [custom validation](https://guides.rubyonrails.org/active_record_validations.html#custom-methods) to help with the duration attribute. 

<hr/>
</details>

<details><summary><h3>5. Where to Watch</h3></summary>
```
As a user, 
When I visit a Viewing Party's show page (`/users/:user_id/movies/:movie_id/viewing_party/:id`), 
I should see 
- logos of video providers for where to buy the movie (e.g. Apple TV, Vudu, etc.)
- logos of video providers for where to rent the movie (e.g. Amazon Video, DIRECTV, etc.)
And I should see a data attribution for the JustWatch platform that reads: 
"Buy/Rent data provided by JustWatch",
as per TMDB's instructions.
```

**Notes**
* The logos used should be provided by the TMDB Watch Providers endpoint. 

<hr/>
</details>

<details><summary><h3>6. Similar Movies</h3></summary>
```
As a user, 
When I visit a Movie Details page (`/users/:user_id/movies/:movie_id`),
I see a link for "Get Similar Movies"
When I click that link
I am taken to the Similar Movies page (`/users/:user_id/movies/:movie_id/similar`)
Where I see a list of movies that are similar to the one provided by :movie_id, 
which includes the similar movies': 
- Title
- Overview
- Release Date
- Poster image
- Vote Average
```
</details>

<details><summary><h3>7. Add Movie Info to User Dashboard</h3></summary>

```
As a user,
When I visit a user dashboard ('/user/:user_id'),
I should see the viewing parties that the user has been invited to with the following details:

- Movie Image
- Movie Title, which links to the movie show page
- Date and Time of Event
- who is hosting the event
- list of users invited, with my name in bold

I should also see the viewing parties that the user has created (hosting) with the following details:

- Movie Image
- Movie Title, which links to the movie show page
- Date and Time of Event
- That I am the host of the party
- List of friends invited to the viewing party
```

**Notes:**
* Some of the information required in this user story is already on the page; you are allowed and expected to change any and all formatting/code required to complete the story. 


</details>

<br>
<hr/>

## Extension Ideas


1. **Provide genres for each movie:** Each `movie` object that is returned from the TMDB api has a `"genre_ids"` key whose value is an array of IDs that correspond to a genre. Wherever the API is able to provide this data, you should provide the appropriate `name` for that genre, based on the TMDB "Genres: Movie List" API. 
  - (Consider - is it possible to store this data? Do you have to make an API call *every* time a Movie endpoint is called?)

2. Additional API consumption (find another API you want to consume that could provide more data on one or more pages)
3. Update the New Viewing Party form to display all users and allows any number of them to be invited to a party using [check boxes](https://apidock.com/rails/ActionView/Helpers/FormHelper/check_box) instead of text fields.
4. Add functionality such that a user must _accept_ an invite to a movie party.
5. Implement basic authentication for a user.
 * require a password field to user registration, and create log-in/log-out functionality 
 * utilize sessions/cookies to remember a logged in user
6. Implement low-level server-side caching for API calls.
