---
title: Cart Implementation
length: 120
tags: cart, order
---

## Goals

* represent a cart using a PORO in Rails
  * Start thinking about opportunities for using POROs to extract logic from the controller.
* use a `flash` to send messages to the view
* load an object to be used throughout the app using a `before_action` in the ApplicationController

## Structure

* Code-along

## Video

* [Cart and Order Lifecycle](https://vimeo.com/126190416)

## Repository

* [BackPacking](https://github.com/turingschool-examples/backpacking/tree/rails-5-ruby-2-4)

## Intro

We'll build out an app where a user should be able to add supplies to his/her backpack. The added supplies are not saved to the database until the user has decided.

This will mimick the cart-order lifecycle. Items represent items that you would be adding to your cart, the backpack is the cart, and an order is the saved items.

## Code-Along

* `git clone -b rails-5-ruby-2-4 https://github.com/turingschool-examples/backpacking`
* `cd backpacking/`
* `bundle install`
* `rake db:{create,migrate,seed}`
* `rails s`
* navigate to `http://localhost:3000`

### Writing a Test

* `mkdir spec/features`
* `touch spec/features/user_can_add_items_to_their_backpack_spec.rb`
* Navigate to `spec/features/user_can_add_items_to_their_backpack_spec.rb`
* Inside of that file add the following:

```ruby
require 'rails_helper'

RSpec.feature "When a user adds items to their backpack" do
  before(:each) do
    Item.create!(
      name: "Rollerball Pen",
      image_url: "/images/rollerball_pen.jpeg"
    )
  end

  scenario "a message is displayed" do
    visit root_path
    click_button "Add Item"

    expect(page).to have_content("You now have 1 Rollerball Pen.")
  end
end
```

### Creating a Backpack and Adding a Flash Message

Run the test and it complains about not having a add item button. Let's make a button and talk about what the path should be. Inside of views/items/index.html.erb:

```erb
  <%= button_to "Add Item", backpacks_path, class: "btn btn-danger" %>
```

Our error now is:

```
  1) User adds a pen to their backpack a message is displayed
     Failure/Error: click_button "Add Item"

     ActionController::RoutingError:
       uninitialized constant BackpacksController
```

Make a controller: `touch app/controllers/backpacks_controller.rb`. If you run the test again, it will complain about missing the action `create`. So, inside of the controller file:

```ruby
class BackpacksController < ApplicationController
  def create
    redirect_to root_path
  end
end
```

Does it work? Start up your server and click the "Add Item" button. Does it redirect you back to the same page? Good.

When you run the test, it fails on line 16, which is looking for the content "You now have 1 Rollerball Pen." This should be a flash message, but right now we don't know which item was added when we click the "Add Item" button. How do we pass an Item ID to the create action? Let's modify our button:

```erb
  <%= button_to "Add Item", backpacks_path(item_id: item.id), class: "btn btn-danger" %>
```

We can pass key/value pairs in our path helpers to pass extra data as string query params!

And modify our `create` action in the controller:

```ruby
class BackpacksController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    flash[:notice] = "You now have 1 #{item.name)}."
    redirect_to root_path
  end
end
```

And display the flash notice using a content tag in the application.html.erb:

```erb
<% flash.each do |type, message| %>
  <%= content_tag :div, message, class: type %>
<% end %>
```

Great! That test is passing. But what happens if we add two pens?

### Adding Multiple Items and Updating Our Flash

Let's update our test to check and see.

```ruby
require 'rails_helper'

RSpec.feature "When a user adds items to their backpack" do
  before(:each) do
    Item.create!(
      name: "Rollerball Pen",
      image_url: "/images/rollerball_pen.jpeg"
    )
  end

  scenario "a message is displayed" do
    visit root_path
    click_button "Add Item"

    expect(page).to have_content("You now have 1 Rollerball Pen.")
  end

  scenario "the message correctly increments for multiple items" do
    visit root_path
    click_button "Add Item"
    expect(page).to have_content("You now have 1 Rollerball Pen.")
    click_button "Add Item"

    expect(page).to have_content("You now have 2 Rollerball Pens.")
  end
end

```

If we run this now it fails because even though we've added two pens, our flash message will always say that we have one pen. We need a way to store information about how many pens have been added.

Thinking through this a little bit, we could store something in the database every time someone adds an item to their backpack, but there are a few drawbacks to that approach:

* It would require multiple updates (and potentially deletions) while someone makes up their mind about what to actually keep in their backpack.
* It would require us to log a user in before they could add anything to their backpack so that we could create that association in our database.
* It could potentially result in some abandoned records if a user decides not to finalize their backpack contents.

Instead, we need to find a way to store the state of a backpack (which items have been added to our backpack and how many of each type). Can we store data in a session?

Let's go back into the BackpacksController:

```ruby
class BackpacksController < ApplicationController
  def create
    id   = params[:item_id].to_s
    item = Item.find_by(id: id)
    session[:backpack] ||= {}
    session[:backpack][id] = (session[:backpack][id] || 0) + 1
    flash[:notice] = "You now have #{session[:backpack][id]} #{@item.name)}."
    redirect_to root_path
  end
end
```

This is close. Our test will still fail, but it looks like our number is incrementing correctly. Our error likely looks something like:

```
  1) User adds a pen to their backpack the message correctly increments for multiple items
     Failure/Error: expect(page).to have_content("You now have 2 Rollerball Pens.")
       expected to find text "You now have 2 Rollerball Pens." in "BackPacking You now have 2 Rollerball Pen. Rollerball Pen"
     # ./spec/features/user_adds_pen_to_backpack_spec.rb:25:in `block (2 levels) in <top (required)>'
```

It's the plural of "Rollerball Pen" that's giving us a hard time. Luckily we have a tool for that with `#pluralize`. This is a view helper, so in order to use it here in our controller to set a flash message, we'll need to include `ActionView::Helpers::TextHelper` explicitly.

```ruby
class BackpacksController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    id   = params[:item_id].to_s
    item = Item.find_by(id: id)
    session[:backpack] ||= {}
    session[:backpack][id] = (session[:backpack][id] || 0) + 1
    flash[:notice] = "You now have #{pluralize(session[:backpack][id], @item.name)}."
    redirect_to root_path
  end
end
```

And there we have another passing test.

That's nice, but wouldn't it be better to see how many items total we have in our cart? Yes. Yes it would.

### Adding a Backpack Tracker

First, let's update our feature test.

```ruby
require 'rails_helper'

RSpec.feature "When a user adds items to their backpack" do
  before(:each) do
    Item.create!(
      name: "Rollerball Pen",
      image_url: "/images/rollerball_pen.jpeg"
    )
  end

  scenario "a message is displayed" do
    visit root_path
    click_button "Add Item"

    expect(page).to have_content("You now have 1 Rollerball Pen.")
  end

  scenario "the message correctly increments for multiple items" do
    visit root_path
    click_button "Add Item"
    expect(page).to have_content("You now have 1 Rollerball Pen.")
    click_button "Add Item"

    expect(page).to have_content("You now have 2 Rollerball Pens.")
  end

  scenario "the total number of items in the backpack increments" do
    visit root_path
    expect(page).to have_content("Backpack: 0")
    click_button "Add Item"

    expect(page).to have_content("Backpack: 1")
  end
end

```

If we run our test now, we'll see that we have not included "Backpack: 0" in our view in any place. It's easy enough to get past that error. Let's open the `app/views/layouts/application.html.erb` file and add a paragraph with the backpack information just below our flash message. For now let's hardcode it so that we can see what happens and think through how we want to implement.

```html
<!DOCTYPE html>
<html>
  <head>
    <title>BackPacking</title>
    <%= csrf_meta_tags %>

    <%= stylesheet_link_tag    'application', media: 'all' %>
    <%= javascript_include_tag 'application' %>
  </head>

  <body>
    <nav class="navbar navbar-default">
      <div class="container-fluid">
        <a class="navbar-brand" href="#">BackPacking</a>
      </div><!-- /.container-fluid -->
    </nav>

    <% flash.each do |type, message| %>
      <%= content_tag :div, message, class: type %>
    <% end %>

    <p>Backpack: 0</p>

    <%= yield %>
  </body>
</html>
```

Sure enough, that gets us to a new error where now our test is looking for "Backpack: 1" and not finding it on our page (because we're still displaying "Backpack: 0" since it's hard coded).

We could potentially pass in a count specifically to use in that slot, but it's starting to feel like I'm doing a lot with this backpack. More than should probably just be handled in the controller. What I *really*, more than anything want to do here is to have some sort of an object that I can call `#total` on to get the number of objects in the backpack. I don't have a model to use, but that doesn't stop me from creating a `Backpack` PORO. The question becomes where to start and what to refactor.

Since we're thinking of implementing this here in the view, let's start there with how we'd *like* this object to behave. Change the new line that we added to the view to the following:

```
<p>Backpack: <%= @backpack.total_count %></p>
```

Run our test, and we've broken everything.

```
  3) User adds a pen to their backpack the total number of items in the backpack increments
     Failure/Error: <p>Backpack: <%= @backpack.total_count %></p>

     ActionView::Template::Error:
       undefined method `total_count' for nil:NilClass`
```

That's o.k. We can fix this.

In our ItemsController, let's go ahead and add the instance variable `@backpack`. Let's also assume that we'll need to pass it the contents currently sitting in our session to make it work.

```ruby
  def index
    @items    = Item.all
    @backpack = Backpack.new(session[:backpack])
  end
```

New failing test telling us that we don't have a Backpack class. At this point, we're going to have to create our PORO, so let's dip down into a model test.

### Creating Our Backpack PORO

Create a `spec/models` folder, and a new test for our Backpack class: `spec/models/backpack_spec.rb`. Within our new test file, add the following:

```ruby
require 'rails_helper'

RSpec.describe Backpack do
  subject { Backpack.new({"1" => 2, "2" => 3}) }

  describe "#total_count" do
    it "can calculate the total number of items it holds" do
      expect(subject.total_count).to eq(5)
    end
  end
end
```

Sounds good. Run that test and we find that we need to actually go create our Backpack class. In our models folder touch `backpack.rb` and add the following code:

```ruby
class Backpack
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents
  end

  def total_count
    contents.values.sum
  end
end
```

And that makes our model test pass!

Unfortunately, our feature tests still don't pass for us.

```
  3) User adds a pen to their backpack the total number of items in the backpack increments
     Failure/Error: contents.values.sum

     ActionView::Template::Error:
       undefined method `values' for nil:NilClass`
```

We're trying to call `#values` on our initial contents, but the first time that we render our `index` our session hasn't been set, so `initial_contents` evaluates to `nil`. Let's fix that by adding some code to ensure that `@contents` is always defined as a hash. In your Backpack class:

```ruby
class Backpack
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def total_count
    contents.values.sum
  end
end
```

And now, our feature tests pass as well. Great!

### Refactoring BackpacksController

Let's take another look at the current status of our BackpacksController

```ruby
class BackpacksController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    id   = params[:item_id].to_s
    item = Item.find_by(id: id)
    session[:backpack] ||= {}
    session[:backpack][id] = (session[:backpack][id] || 0) + 1
    flash[:notice] = "You now have #{pluralize(session[:backpack][id], @item.name)}."
    redirect_to root_path
  end
end
```

Currently we're doing a lot of work in this controller with our backpack. Now that we have a Backpack PORO, it seems like we could refactor this to have the PORO take on some of that load.

Let's refactor the BackpacksController so that it looks like this:

```ruby
class BackpacksController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    item = Item.find(params[:item_id])

    @backpack = Backpack.new(session[:backpack])
    @backpack.add_item(item.id)
    session[:backpack] = @backpack.contents

    flash[:notice] = "You now have #{pluralize(@backpack.count_of(item.id), item.name)}."
    redirect_to root_path
  end
end
```

We're still letting the controller handle getting and setting the session, but we're putting our PORO in charge of managing the hash that we're storing there: both 1) adding items to it, and 2) reporting on how many of a particular item we have.

Since we've added these methods to our controller, we now have a missing method error when we run our test. Let's add both methods to our model test to see that they do what we expect them to. The `subject` syntax is a nice RSpec feature to use if you're using a similar setup in many tests. In this case, we abstract the logic for creating a `Backpack` instance, and can call that return value with `subject`. I like how this reads, but feel free to forego this pattern if you don't like it as much.

```ruby
require 'rails_helper'

RSpec.describe Backpack do
  subject { Backpack.new({"1" => 2, "2" => 3}) }

  describe "#total_count" do
    it "calculates the total number of items it holds" do
      expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_item" do
    it "adds an item to its contents" do
      subject.add_item(1)
      subject.add_item(2)

      expect(subject.contents).to eq({"1" => 3, "2" => 4})
    end
  end

  describe "#count_of" do
    it "reports how many of a particular item" do
      expect(subject.count_of(1)).to eq(2)
      expect(subject.count_of(2)).to eq(3)
    end
  end
end
```

In order to get these tests to pass, add the following two methods to our Backpack PORO.

```ruby
def add_item(id)
  contents[id.to_s] = (contents[id.to_s] || 0) + 1
end

def count_of(id)
  contents[id.to_s]
end
```

What if we ask for the count of a non-existant item?  Add `expect(subject.count_of(0)).to eq(0)` to your test for the `count_of` method. What's the matter, got `nil`? Let's **coerce** `nil` values to `0` with `#to_i`.

```
def count_of(id)
  contents[id.to_s].to_i
end
```

And all passing tests!

### Controller Cleanup

One more thing to look at in our Controllers. Notice that in both our BackpacksController and our ItemsController we're setting `@backpack` as one of our first actions. This is likely something that we'll continue to want to have access to in our controllers, particularly since we've put a reference to `@backpack` in our `application.html.erb`. Let's move that action out to our ApplicationController to ensure that it always gets set.

In ApplicationController, add the following:

```ruby
before_action :set_backpack

def set_backpack
  @backpack ||= Backpack.new(session[:backpack])
end
```

If for some reason we access the backpack more than once in a given request/response cycle, the backpack object is memoized with `||=`.

Then delete the following line from both your ItemsController and BackpacksController:

```ruby
  @backpack = Backpack.new(session[:backpack])
```

Double check to see that our tests are still passing, and we should be in good shape!

## You want more?

#### Showing the cart

Let's say that you wanted users to be able to click on "View Backpack" (similar to "View Cart" on an e-commerce site).

* Which controller?
* What does the view look like?
* How can we make the backpack have access to Backpack objects instead of just iterating through a hash of keys and values?

#### Ending and saving the backpack contents

What about allowing users to save their backpack items as a package? You might approach it something like this:

```erb
  Backpack: <%= @backpack.total_count %>
  <%= button_to "Save Package", packages_path %>
```

In your routes:

```ruby
  resources :packages, only: [:create]
```

Make a Packages Controller:

```ruby
class PackagesController < ApplicationController
  include ActionView::Helpers::TextHelper
  def create
    # the four lines below probably would be best delegated to a PackageCreator PORO
    package = Package.new(user_name: "Rachel")
    backpack.contents.each do |item_id, quantity|
      package.items.new(item_id: item_id, quantity: quantity)
    end

    if package.save
      session[:backpack] = nil
      flash[:notice] = "Your bag is packed! You packed #{package.items.count} items."
      redirect_to root_path
    else
      # implement if you have validations
    end
  end
end
```
