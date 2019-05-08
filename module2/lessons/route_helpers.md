---
title: Rails Route Helpers and View Helpers

tags: routes, helpers, rails
---

##  Learning Goals

By the end of this lesson, you will know/be able to:

* Understand the 5 pieces of information `rake routes` gives us.
* Use a route helper to easily refer to a relative and absolute path.
* Understand the difference between what `_url` and `_path` return when combined with a routes prefix.
* Find a routes prefix and use that prefix to build a helper.
* Understand how to use link_to and button_to view helpers.

## Vocab

* routes
* path helper
* url helper

## WarmUp

* How have you been sending a user to another route, say in your tests or in a controller?
* Read the following sections of the Rails Guides for Routing:
    - [1.1 Connecting URLs to Code](https://guides.rubyonrails.org/routing.html#connecting-urls-to-code)
    - [2.1 Resources on the Web](https://guides.rubyonrails.org/routing.html#resources-on-the-web)
    - [2.2 CRUD, Verbs and Actions](https://guides.rubyonrails.org/routing.html#crud-verbs-and-actions)
    - [4.6 Restricting the Routes Created](https://guides.rubyonrails.org/routing.html#restricting-the-routes-created)
* What is the syntax for creating a single route?
* What shortcut does Rails give us to create multiple routes at once?

## Routes

With your partner, take a look at the entries in the table that `rake routes` gives you and fill out the table below in your notebook or on your computer.

| Table Heading | Prefix | Verb | URI Pattern | Data Collection | Controller#Action | Redirect or Render? | View | Path Helper | URL Helper |
| photos | photos | get | /photos | Photo.all | photos#index | render | index | photos_path | photos_url |

Fill in your answers [here](https://docs.google.com/spreadsheets/d/1AGjUE49UJajPEQHvh3plKjaem5RAGvuv5SNjZzvjD9U/edit#gid=0).

#### Large group share

* What is the path helper for each CRUD action? Which ones take an argument?
* What is the url helper for each? How do these compare to the path helpers?

### Using prefix names to make path helpers

- Rails will use the "prefix" column to build our "path helpers", we just need to add `_path` to the end of the prefix name
- Generally, any row that does not include a "prefix" uses the same "prefix" as the line above it


## Passing Parameters to Path Helpers

Any time a path helper needs a dynamic parameter, like `:id` we MUST pass a value to the path helper.

Best practice is to pass the entire object to the path helper, such as:

```ruby
journey = Artist.create(name: 'Journey')
visit artist_path(journey)
```

Rails will check if the object has an ID value and build the path helper appropriately.

**Turn & Talk**

- What happens if we forget to pass a parameter to a path helper that needs it?
- What error do we see?
- Practice reading the ENTIRE error message to understand what's going on

Point out to students that the error message will start to look like a "missing route" error, but when they read the ENTIRE error, it will actually tell them the path helper is missing a parameter.


### Using `rake routes` as a debugging tool

We can use `rake routes` as a debugging tool for our path helpers:

- examine the `edit` path helper for an album:

`edit_album GET    /albums/:id/edit(.:format) albums#edit`

We can see in the `rake routes` output that we need a "dynamic parameter" in our URI path, called `/:id/`. Here, `rake routes` is telling us exactly what the parameter is called, and that also indicates how we can access this value in our params hash: `params[:id]`

If you add a custom route to `config/routes.rb` with its own "dynamic parameter", like:
- `get '/albums/:album_id', to: 'albums#show'`
and run `rake routes` again
- `GET    /albums/:album_id(.:format) albums#show`

Again, `rake routes` shows us a dynamic parameter in the URI path, called `:album_id`, and we would also access this as `params[:album_id]`

**Be sure to remove any custom routes for albums**

---

# We only want to see you using path helpers moving forward, no exceptions

---

#### Independent Practice

Update your test suite to use path helpers instead of direct paths (i.e. "/songs")

#### Partnered Workshop

Research how to use link helpers with your path helpers to create a navigation bar. This navigation bar would contain a link that leads to all songs and one that leads to all artists. It also includes a link to go home. Your home would show links to create a new song or artist.

#### Partnered Share

Turn to a new partner and share out how you used path helpers to dry up your code.

### WrapUp

* What does artists_path evaluate to outside of a link helper?
* What does artists_url evaluate to outside of a link helper?
* What does artist_path(@artist) give you? Why do you need to pass it @artist? Which other routes need you to pass a resource?
