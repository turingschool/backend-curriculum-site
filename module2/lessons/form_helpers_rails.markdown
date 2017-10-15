---
layout: page
title: Forms in Rails
---

## Learning Goals

* Explain why we use/need forms
* Understand the role of `form_for`
* Construct a basic form with the help of documentation/references
* Practice building a small CRUD application with a form

### Setup

* Open up a working version of `movie_mania`.
* **Get familiar with the new route.** What functionality is there?

### User Story

1. `As a user, when I visit "/directors/new" , I see a form where I can create a new director`
2. `When I fill in name and click "Create Director", I am taken to the director that I just created's show page`

### Tests

- First things first, let's run our test suite since we added our Directors table. Why isn't it passing? Let's use pry and our errors to see if we can figure it out.

#### New Director Test

```ruby

visit "/directors/new"

fill_in "director[name]", with: "Sal Espinosa"

click_on "Create Director"

expect(current_path).to eq("/directors/#{Director.last.id}")
expect(page).to have_content("Sal Espinosa")
```

### Exercise: `form_for`

* What is `form_for`?
* Why do we need a new `Director` object defined at our route?
* What happens when `@director` is set to something different?
  - `<%= form_for @post, :as => :post, :url => posts_path, :html => { :class => "new_post", :id => "new_post" } do |f| %>`
* Can you change the `name` field in this form to `first_name`? What happens? What error do you get?
* How does this form know where to submit to?

### `form_for` vs `form_tag`

Turn and talk with your neighbor to discuss the following.

*   What is `form_for`? How is this different from a `form_tag`?
*   When would we want to use one over the other?

### Code Along

Let's submit this form. Why do we need another route to handle the submission of this form? What is the naming convention for this route?

### Exercise: Create Categories

We also have categories. We have only have the functionality to view all categories currently. Add the functionality for a user to add a new category. Don't forget - you'll need two routes for this!
