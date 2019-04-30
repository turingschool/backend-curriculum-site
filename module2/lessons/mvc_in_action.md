---
layout: page
title: MVC in Action
---

## WarmUp

* In small groups, Diagram the MVC workflow and how each part relates to the others.
  - include which logic area belongs to each of the parts of MVC.
  - each area should have examples of what responsibilities should live there.
  - bonus: include file names for each area from your Laugh Tracks project

* Gallery!
  - Post the diagrams around the room and circulate, discussing differences and similarities between diagrams.


## MVC in Action!

For each of the code snippets below, identify where we are breaking MVC logic conventions and talk with a partner about how we should fix each infraction.

### Models

```ruby
class Comedian < ApplicationRecord
  def self.average_age
    average(:age).round(2)
  end
end
```

### Views
```erb
<% @comedians.each do |comic| %>
<h4><%= comic.specials.count %> Specials</h4>
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
  end
end
```

## Peer Code Review

In pairs or small groups, review each other's Laugh Tracks projects.  Help each other identify places where there are MVC infractions similar to the infractions in the code snippets above.

For additional guidance you can consider the following rules:

* No query logic in your Controllers or Views; this should live in your Models.
* No data formatting in your Models or Controllers; this should live in your Views.
