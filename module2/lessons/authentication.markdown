---
title: Authentication in Rails
length: 180
tags: authentication, rails, bcrypt
---

### Goals

By the end of this workshop, you will know/be able to:

* create a structure to allow guests to register for an account
* store passwords as the output of the BCrypt hashing function
* create a structure to allow users to log in
* create a structure to allow users to log out
* create a helper method `current_user` to use around an app

## Structure

| - | - |
| 25 | Diagram && FUNdamentals |
| 5 | POM |
| 60 | Worktime |
| 25 | Share Out && Review |
| 5 | POM |
| 25 | Slides |
| 5 | POM |
| 25 | QA && Closing |

## Diagram && FUNdamentals

### What you already know:

* Booleans && Control Flow `return nil if false`
* Ruby hashes `{}`
* Gems and bundling `gem pry`
* Database Migrations `rails g migration ...`
* MVC flow `app/models`, `app/views`, `app/controllers`
* RESTful routes `rake routes`

| VERB | path | action |
| `GET` | `/things` | `index` |
| `GET` | `/things/new` | `new` |
| `POST` | `/things` | `create` |
| `GET` | `/things/:id` | `show` |
| `GET` | `/things/:id/edit` | `edit` |
| `PUT/PATCH` | `/things/:id` | `update` |
| `DELETE` | `/things/:id` | `destroy` |

* Passing data via forms `<%= form_for ... %>`
* ActiveRecord queries like `.find_by`
* Sessions and cookies `session[:hit_counter]`
* Links `<%= link_to ... %>`

Don't be too worried about the new terrain of authentication. All of these foundations you've worked so hard at are at the core of all of this. The skill now is keeping track of where and how all the above components interact. You. Got. This.

## PAUSE && APPLAUSE

## Worktime

1. Watch the Video - [Authentication with steps](https://vimeo.com/134451454)
2. Go over the steps - [It's just 24 easy steps](https://gist.github.com/rwarbelow/fc48a47d713103b3b66f)
3. Implement the steps in the [Authentication Starter Repo](https://github.com/turingschool-examples/authentication)

## Share Out && Review

1. Take five minutes to chat with your neighbor about main take-aways and main questions.
2. Each group shares one take-away and one question.
3. Locate each take-away and question in the diagram flow.

## Lecture

* [Slides](https://www.dropbox.com/sh/k8jsy5i9wgwk52x/AADpCVwnRuZThsmTVfFU2i3na?dl=0)

## Closing

Sticks are coming out. No one is safe.

Think of BCrypt authentication in Rails as some abstract hash, with broad concepts as keys and implementations as values. What values could the following keys have?

* `:gem`
* `:helper_method`
* `:essential_user_column`
* `:login`
* `:logout`
* `:state`
* `:new_account`

### Resources

* [It's just 24 easy steps](https://gist.github.com/rwarbelow/fc48a47d713103b3b66f)
