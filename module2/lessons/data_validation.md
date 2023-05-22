---
title: Data Validation
length: 90
layout: page
---

## Learning Goals

- Understand why we validate data in our applications
- Become familiar with common validation helpers in rails
- Become familiar with common testing matchers from ShouldaMatchers

## Set Up

We'll start this lesson using [this branch](https://github.com/turingschool-examples/set-list-7/tree/data-validations-setup) of our Set List repo.

## Consider This

- Have you begun validating your data in your projects? Why or why not?
- What kind of real world scenarios can you imagine an app needing to validate?
- Why do we need to validate data on the backend if we use form helpers to disallow input on the frontend?

[FE form validation limitations screencast 5 minutes](https://www.loom.com/share/8e4e5b831dd74a2885a5b403b7f494d9)

[From the Rails Guides:](https://edgeguides.rubyonrails.org/active_record_validations.html)

#### 1.1 Why Use Validations?

Validations are used to ensure that only valid data is saved into your database. For example, it may be important to your application to ensure that every user provides a valid email address and mailing address. Model-level validations are the best way to ensure that only valid data is saved into your database. They are database agnostic, cannot be bypassed by end users, and are convenient to test and maintain. Rails provides built-in helpers for common needs, and allows you to create your own validation methods as well.

There are several other ways to validate data before it is saved into your database, including native database constraints, client-side validations and controller-level validations. Here's a summary of the pros and cons:

- Database constraints and/or stored procedures make the validation mechanisms database-dependent and can make testing and maintenance more difficult. However, if your database is used by other applications, it may be a good idea to use some constraints at the database level. Additionally, database-level validations can safely handle some things (such as uniqueness in heavily-used tables) that can be difficult to implement otherwise.
- Client-side validations can be useful, but are generally unreliable if used alone. If they are implemented using JavaScript, they may be bypassed if JavaScript is turned off in the user's browser. However, if combined with other techniques, client-side validation can be a convenient way to provide users with immediate feedback as they use your site.
- Controller-level validations can be tempting to use, but often become unwieldy and difficult to test and maintain. Whenever possible, it's a good idea to keep your controllers skinny, as it will make your application a pleasure to work within the long run.

Choose these in certain, specific cases. It's the opinion of the Rails team that model-level validations are the most appropriate in most circumstances.

There are two kinds of Active Record objects: those that correspond to a row inside your database and those that do not. When you create a fresh object, for example using the new method, that object does not belong to the database yet. Once you call save upon that object it will be saved into the appropriate database table. Active Record uses the new_record? instance method to determine whether an object is already in the database or not.

**app/models/artist.rb**

```ruby
class Artist < ApplicationRecord
  has_many :songs

  def average_song_length
    self.songs.average(:length)
  end
end
```

Let’s open up a rails console.

```bash
irb(main):001:0> a = Artist.new(name: "Carly Rae Jepsen")
=> #<Artist:0x000000010abd7fd0 id: nil, name: "Carly Rae Jepsen", created_at: nil, updated_at: nil>
irb(main):002:0> a.new_record?
=> true
# Not saved to the database yet, no validations have run. Notice the nil values.
irb> a.save
irb(main):003:0> a.save
  TRANSACTION (0.4ms)  BEGIN
  Artist Create (1.2ms)  INSERT INTO "artists" ("name", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["name", "Carly Rae Jepsen"], ["created_at", "2023-02-23 16:48:17.820040"], ["updated_at", "2023-02-23 16:48:17.820040"]]
  TRANSACTION (2.8ms)  COMMIT
=> true
# Validations were checked as part of the process for inserting a new record into the database.
# Looking at our object now:
irb(main):004:0> a
=> #<Artist:0x000000010abd7fd0 id: 8, name: "Carly Rae Jepsen", created_at: Thu, 23 Feb 2023 16:48:17.820040000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:48:17.820040000 UTC +00:00>
irb(main):005:0> a.new_record?
=> false
# This object now corresponds with a row in the database
```

Creating and saving a new record will send an SQL INSERT operation to the database. Updating an existing record will send an SQL UPDATE operation instead. **Validations are typically run before these commands are sent to the database.** If any validations fail, the object will be marked as invalid and Active Record will not perform the INSERT or UPDATE operation. This avoids storing an invalid object in the database. You can choose to have specific validations run when an object is created, saved, or updated with the `:on` option.

The following methods trigger validations, and will save the object to the database only if the object is valid:

- create
- create!
- save
- save!
- update
- update!

**The bang versions (e.g. save!) raise an exception if the record is invalid. The non-bang versions don't: save and update return false, and create returns the object.**

## Boolean Gotcha

Since `false.blank?` is true, if you want to validate the presence of a boolean field, you should use one of the following validations:

```ruby
validates :boolean_field_name, inclusion: [true, false]
validates :boolean_field_name, exclusion: [nil]
```

By using one of these validations, you will ensure the value will NOT be nil, which would result in a `NULL` value in most cases.

## Try It!

Use [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers) and [validation helpers](https://edgeguides.rubyonrails.org/active_record_validations.html) to accomplish the following:

**Basics**
- Add a validation that validates the uniqueness of an Artist's name
- Add a validation that validates the presence of a Playlist's name
- Add a validation for the Song's `play_count` column that validates numericality
- Add a validation that adds a max length for a Song title
- Add a validation to check for the presence of a boolean value for one of your models.

You can find a completed set of these basic examples in [this branch](https://github.com/turingschool-examples/set-list-7/tree/data-validations-complete). 

**Advanced**
- Access validation errors when a validation fails on a model in your console
- Access validation errors for a specific attribute when a validation fails on a model in your console
- Add a new column to the playlists table that has a validation that only runs on an `update`
- Add a custom validation method to assign a default length attribute for a Song when none is provided

### Checks for Understanding
- Why do we use validations?
- What are some common validation helpers?
- When do validations happen?
- Where do validations happen? (DB, Rails application, FE, etc)