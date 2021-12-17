---
layout: page
title: MVC in Action
---

## MVC in Action!

For each of the code snippets below, take a few minutes to identify where we are breaking MVC logic conventions and then we will talk as a class about how we should fix each infraction.

A bit of context. Imagine that you are working in an app that tracks comedians and their Netflix Specials. Comedians have an age and they also have specials, in a one to many relationship. Specials have a run time which is their length.

### Models

```ruby
class Comedian < ApplicationRecord
  has_many :specials

  def self.average_age
    "#{average(:age).round(2)} Years"
  end

  def average_special_runtime
    specials.average(:runtime)
  end
end
```

### Views
```erb
<% @comedians.each do |comic| %>
<h4><%= comic.specials.count %> Specials</h4>
<% end %>
```

```erb
<h1><%= @comedian.name %></h1>
<% if @comedian.specials > 2 && @longest_special > 20 %>
  <p>Average runtime of all this comedian's specials: <%= @average_special_runtime %></p>
<% end %>
```

### Controllers
```ruby
class ComediansController < ApplicationController
  def index
    @comedians = Comedian.all
    @average_age = Comedian.average(:age)
  end
end
```

```ruby
class ComediansController < ApplicationController
  def show
    @comedian = Comedian.find(params[:id])
    @average_special_runtime = @comedian.average_special_runtime.round(2)
    @longest_special = @comedian.specials.order(runtime: :desc).first
  end
end
```

## Peer Code Review

In small groups, review each other's projects.  Help each other identify places where there are MVC infractions similar to the infractions in the code snippets above.

* Set a timer to ensure each group has equal time to share
* DO NOT spend time attempting to refactor your code when you identify problem areas
* Instead, write yourself a comment in your code like `#MVC`, so that you and your partner can come back to it on your own time

For additional guidance you can consider the following rules:

* No query logic in your Controllers or Views; this should live in your Models.
* No data formatting in your Models or Controllers; this should live in your Views.
