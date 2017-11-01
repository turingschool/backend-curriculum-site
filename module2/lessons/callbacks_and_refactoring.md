---
title: Callbacks and Refactoring
---

## Goals

* Understand how callbacks work
* Know some common callbacks
* Use callbacks to your advantage

## Setup

* We are going to continue and use `movie_mania`.

## When to Use a Callback

- Almost never.
- After callbacks can get messy.
- A PORO is a better option, most of the time.

## Callbacks in Models. A use case.

- We want to access our movies by title in the url. for example `/movies/drop_dead_fred`. Right now, we have access to our movie show page by `/movies/:id`. How do we create this new url?

### Updating Our Test

```ruby
require 'rails_helper'

describe "user sees one movie" do
  it "user sees one with title and description" do
    movie = create(:movie)

    visit movie_path(movie.slug)

    expect(current_path).to eq("/movies/#{movie.title}")

    expect(page).to have_content(movie.title)
    expect(page).to have_content(movie.description)
  end
end
```

- But what is a slug???
  - A slug is a piece of the URL’s path that is typically a hyphenated version of the title or main piece of a webpage you’re on.

## [Rails/ActiveRecord Callbacks](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html)

What are [callbacks](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html)?

Pick of a few below that sound useful to you. Let's take a few minutes to research those.

1. Creating an Object
  * `before_validation`
  * `after_validation`
  * `before_save`
  * `around_save`
  * `before_create`
  * `around_create`
  * `after_create`
  * `after_save`
  * `after_commit`/`after_rollback`
1. Updating an Object
  * `before_validation`
  * `after_validation`
  * `before_save` **__Note: before_save gets called when we update and when we create.__**
  * `around_save`
  * `before_update`
  * `around_update`
  * `after_update`
  * `after_save`
  * `after_commit`/`after_rollback`
1. Destroying an Object
  * `before_destroy`
  * `around_destroy`
  * `after_destroy`
  * `after_commit`/`after_rollback`

### Workshop: Visit Movie By Slug

## Callbacks Are Often Code Smells

Callbacks are super powerful, but why should we use them with care?

Let's break up into 4 groups to research this.

Try to be diligent with your research and come to your own conclusions. This practice will come in handy when navigating opinionated developers in your career.
