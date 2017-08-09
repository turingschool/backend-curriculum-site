---
title: ActiveRecord Exploration
length: 60
tags: activerecord, sinatra
---

## Overview

Fork and clone [this repository](https://github.com/turingschool/activerecord_exploration).

In it, you will find that we have a table of `horses`. An individual `Horse` has a `name`, `age`, and `total_winnings`.

Your job is to start exploring ActiveRecord methods. If you open `app/models/horse.rb`, you'll notice that our `Horse` class inherits from `ActiveRecord::Base`. This is how we have access to all of ActiveRecord's methods.

## Setup
In order to get started, you'll need to run the following commands from the command line:

`bundle install`

`rake db:create`

`rake db:migrate`

`rake db:seed`

Once you've run these commands, if you run `tux` from the command line, you'll enter a console with your code loaded (pretty sweet, right?!).

### Exploration

#### attributes
ActiveRecord gives you reader and setter methods for each field in your database. In this example, a `Horse` has a `name`, `age`, and `total_winnings`. So, if we have an instance of `Horse`, we can access each of these pieces of data like so:

```ruby
horse = Horse.first
horse.name
# Penelope
horse.age
# 29
horse.total_winnings
# 34000
```

#### #find

ActiveRecord's `#find` takes an integer as an argument (the id of the record you're looking for). It returns the record if it finds it; if it doesn't find it - it returns an `ActiveRecord::RecordNotFound` error.

If I was looking for the horse with id 90, I would run `Horse.find(90)`

Practice using `#find`. See if you can find the following:

- The Horse with id 3
- The Horse with id 1
- The Horse with id 7

#### #find_by

Similar to `find`, `find_by` will run a SQL query to find the specific record based on the data you pass it. The difference between `find` and `find_by` is that `find` only accepts the `id`, but with `find_by`, we can pass it the attribute we want to lookup by.

For example, if I wanted to find the horse with the name "Penelope", I'd run `Horse.find_by(name: "Penelope")`. You can also pass `find_by` more than one argument. If I wanted to find the horse with the name "Penelope" and age 29, I could run `Horse.find_by(name: "Penelope", age: 29)`. Notice that I'm passing in key/value pairs to `find_by`.

Another important note is if we pass `find_by` a value that our database doesn't have (for example: `Horse.find_by(name: "Hola")`), the return value with be `nil`. ActiveRecord will not through an error, but rather return `nil`.
Practice using `#find_by`.

See if you can write and execute (in `tux`) ActiveRecord queries to accomplish the following:

- Find the Horse with age 95.
- Find the Horse with total winnings of 4000 and age 55
- Find the Horse with name "Paulo" and total winnings of 45000

**What happens if we have more than one record in our database that satisfies the conditions we pass to our `#find_by` method?**

#### #where

Similar to `#find_by`, `#where` accepts arguments in key/value pairs and queries our database accordingly. We can pass `#where` as many key/value pairs as we'd like and it will return every record that it finds that matches our query.

The difference between `#find_by` and `#where` is that `#find_by` will always return the **first** match from the database. `#where` returns every match that it can find in an Array. If it only finds one match, it will still return the findings in an Array.

If I wanted to find all the horses who are named "Penelope", I'd execute `Horse.where(name: "Penelope")`.

Practice using `#where`. See if you can write and execute (in `tux`) ActiveRecord queries to accomplish the following:

- Find all horses that are 39 years old.
- Find all horses that have total winnings of 78000.
- Find all horses that are named Patricia and 49.

#### #new

In order to create a new horse, we can use the `#new` method. Similar to the method we created previously, this will take a Hash of arguments. This method can be a bit deceving though. When you execute `Horse.new(name: "Patty")` in your `tux` console, what is the return value? Do you see that any SQL was executed?

The answer is no because this `Horse` was not actually sent to the database. `#new` simply creates a new instance of Horse. In order to save this in the database, we need to call `#save` on the instance of `Horse`. You should see an `INSERT INTO` statement in the console after you call this method.

Example:

```ruby
Horse.new(name: "Piper", age: 10, total_winnings: 134203)
# <Horse id: nil, name: "Piper", age: 10, total_winnings: 134203, created_at: nil, updated_at: nil>
```

Notice that the id this specific `Horse` is `nil` along with `created_at` and `updated_at`. We need to `save` this instance if we want it to persist in our database.

```ruby
horse = Horse.new(name: "Piper", age: 10, total_winnings: 134203)
# <Horse id: nil, name: "Piper", age: 10, total_winnings: 134203, created_at: nil, updated_at: nil>
horse.save
# true
```

Practice using `#new` and `#save` in `tux`. Pay attention to the return values of both methods.

#### #create

Wouldn't it be nice if there was a method that did both `#new` and `#save` in one go? ActiveRecord helps us out with this! It's called `#create`. This method will create the new instance AND save it to the database. It takes the same arguments as `#new` does, but it's return value is different.

Practice using `#create` by creating at least 3 new horses. Pay special attention to what calling `#create` returns.

### Recap
ActiveRecord is very powerful. This is just a brief introduction to the methods that ActiveRecord gives us access to. If you have time and want to dive deeper, start by reading some documentation [here](http://guides.rubyonrails.org/active_record_querying.html).
