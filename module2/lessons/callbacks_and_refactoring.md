---
layout: page
length: 60min
title: Callbacks and Refactoring
tags: rails, ruby, callbacks, refactoring, dry
---

## Learning Goals

* Understand how callbacks work
* Know some common callbacks
* Use callbacks to your advantage

## Slides

Available [here](../slides/callbacks_and_refactoring)

## Vocabulary

* callback
* DRY
* slug

## WarmUp

Using the internet:

* In your own words, what is a Rails callback?
* Why do people seem to hate them so much?
* Why might we teach you about them even though people seem to hate them?

## Background

### What is a Callback

From the [Rails Guides](http://guides.rubyonrails.org/active_record_callbacks.html):

> Methods that get called at certain moments of an object's life cycle. With callbacks it is possible to write code that will run whenever an Active Record object is created, saved, updated, deleted, validated, or loaded from the database.

### [Rails/ActiveRecord Callbacks](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html)

1. Creating an Object
  * `before_validation`
  * `after_validation`
  * `before_save`
  * `around_save`
  * `before_create`
  * `after_create`
  * `after_save`
  * `after_commit`/`after_rollback`
1. Updating an Object
  * `before_validation`
  * `after_validation`
  * `before_save`
  * `around_save`
  * `before_update`
  * `after_update`
  * `after_save`
  * `after_commit`/`after_rollback`
1. Destroying an Object
  * `before_destroy`
  * `after_destroy`
  * `after_commit`/`after_rollback`

**Note:** Some of these are called both when an object is created and when it is updated since in both cases the object is saved.

### When to Use a Callback

Almost never. "After" callbacks can get messy. A PORO is a better option, most of the time.

### Callbacks Are Often Code Smells

Callbacks are super powerful, but why should we use them with care?

Let's break up into 4 groups to research this.

Try to be diligent with your research and come to your own conclusions. This practice will come in handy when navigating opinionated developers in your career.

## Exploration

### Setup

We are going to continue to use `Music Box`.

### Use Case

We want to access our songs by title in the url. for example `/songs/my-heart-will-go-on`. Right now, we have access to our song show page by `/songs/:id`. How do we create this new url?

### Updating Our Test

```ruby
require 'rails_helper'

describe "user sees one song" do
  it "user sees one with title and description" do
    song = Song.create(title: "Don't Stop Believin'", length: 123, play_count: 0)

    visit song_path(song.slug)

    expect(current_path).to eq("/songs/#{song.slug}")

    expect(page).to have_content(song.title)
    expect(page).to have_content(song.length)
  end
end
```

But what is a slug??? A slug is a piece of the URL’s path that is typically a hyphenated version of the title or main piece of a webpage you’re on.

### Creating a slug column

We run into an issue when we run the tests that `slug` does not exist for `song`. Lets add that migration:

`rails g migration AddSlugToSongs slug:string`

Check our migration and `rails db:migrate`

### Updating Song with Slug

- The reality is that we want to create our slug and then save our song with the slug we generated. How can we handle this? What type of callback could we use? Research for a few minutes.

- Take a minute to research how to create a hyphenated title. Any suggestions? `parameterize`

```ruby
resources :artists, shallow: true do
  resources :songs, param: :slug
end
```

```ruby
# app/models/song.rb
before_save :generate_slug

def generate_slug
  self.slug = title.parameterize
end
```

### Updating our Songs Controller

Since we are now going to use the slug to access the show page, we need to update our find method to find the song by slug.

```ruby
# app/controllers/songs_controller.rb
def show
  @song = Song.find_by(slug: params[:id])
end
```

One last piece of the puzzle. Right now we are finding our song by it's slug, but we call params[:id] to get that slug. Huh?

## WrapUp

* What is a callback? Name 5 of them.
* When should you use a callback?
