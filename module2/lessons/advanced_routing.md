---
layout: page
title: Advanced Routing
tags: router, routing, rails
---

## Learning Goals
- Become familiar with the DSL within the `routes.rb` file
- Become familiar with the common path helpers and where to use them
- Review the 7 restful routes

## Lesson

Use [this video](https://www.loom.com/share/604d8bb6a2dc41f6b97dd9a0dc01272f) and the [Rails guides on routing](https://guides.rubyonrails.org/v5.2/routing.html#resource-routing-the-rails-default) to answer some questions


## To Do
- How can I create the 7 restful routes for a resource?
- What are the 7 restful routes?
- If my resource is authors, which controller will my routes map to?
- If my request is `GET 'authors/4'`, which action in which controller will my route be mapped to? - How could I create a link to the above route using a path helper in my view?

Suppose I have this setup:

```ruby
class Author < ApplicationRecord
  has_many :books
end

class Book < ApplicationRecord
  belongs_to :author
end
```

- If my request is `GET 'authors/4/books/3'` (nested resource), which action in which controller will my route be mapped to?
- How could I create a link to the above route using a path helper in my view?
- How deep should I nest routes?
- What are the advantages of using path helpers?
- How can I view all available path helpers within an application?
- How can I view all available routes for a specific controller?
