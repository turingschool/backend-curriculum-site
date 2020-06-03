---
title: Cart Implementation
length: 120
tags: cart, order
---

## Goals

* represent a cart using a PORO in Rails
  * Start thinking about opportunities for using POROs to extract logic from the controller.
* use a `flash` to send messages to the view
* load an object to be used throughout the app using a `before_action` filter in the ApplicationController

## Structure

* Warm Up
* Code-along

## Vocabulary
* Session
* PORO

## Video

* [Cart and Order Lifecycle](https://vimeo.com/126190416)

## Warm Up

  * How do we make a class in Ruby?
  * How do we make an instance of a class?
  * Where does plain old Ruby data (like a class instance) "live"?

## Intro

We'll build out an app where a user should be able to add songs to their cart. The added songs are not saved to the database until the user has decided so.

## Code-Along

We are going to use the `SetList` project for this example.

### Writing a Test

```ruby
# spec/features/cart/add_song_spec.rb

require 'rails_helper'

RSpec.describe "When a user adds songs to their cart" do
  it "displays a message" do
    artist = Artist.create(name: 'Rick Astley')
    song = artist.songs.create(title: 'Never Gonna Give You Up', length: 250, play_count: 1000000)

    visit "/songs"

    within("#song-#{song.id}") do
      click_button "Add Song"
    end

    expect(page).to have_content("You now have 1 copy of #{song.title} in your cart.")
  end
end
```

### Creating a Cart and Adding a Flash Message

Run the test and it complains about not finding the css with the song id. Inside of `views/songs/index.html.erb`, wrap each song in a section with that id:

```erb
<h1>All Songs</h1>

<% @songs.each do |song| %>
  <ul>
    <section id="song-<%= song.id %>">
      <li>
        <%= link_to song.title, "/songs/#{song.id}" %>
        Play Count: <%= song.play_count %>
      </li>
    </section>
  </ul>
<% end %>
```

Now the test isn't finding the button. Let's add a button inside our section:

```erb
<%= button_to "Add Song" %>
```

Our error now is:

```
No route matches [POST] "/songs"
```

`button_to`, by default, will send a `POST` request, and since we haven't specified the path, it uses the current path which is `/songs`.

So we need a route to handle adding a song, but what route should it be? We aren't going to store Carts in our database, so there's no ReSTful routing convention to follow in this case. Let's try to make our route look as ReSTful as possible. If you think about every user having an empty cart by default, what we want to do is update that cart, so it would make sense to use a `PATCH` verb. Since we are updating the cart, it also makes sense that our path includes `/cart`. Finally, we need to know what song we are putting in the cart, so we'll include a `:song_id` parameter in our route. Putting this all together, we'll use the route:

```
patch '/cart/:song_id'
```

Our route will also need a controller and action to route to. Since we're updating the cart, it makes sense to create a new `cart` controller with an `update` action. Add this to your routes file:

```
patch '/cart/:song_id', to: 'cart#update'
```

As always, run `rake routes` and make sure your new route is there.

Now that we have a route, let's  make our button go to this route:

```
<%= button_to "Add Song", "/cart/#{song.id}", method: :patch %>
```

Now we get a new error:

```
ActionController::RoutingError:
     uninitialized constant CartController
```

Make a controller: `touch app/controllers/cart_controller.rb` and add the `CartController class`. If you run the test again, it will complain about missing the action `update`. So, inside of the controller file:

```ruby
class CartController < ApplicationController
  def update
  end
end
```

And now our error is funky, harder to decipher:

```terminal
Unable to find visible xpath "/html"
```

This is because we are sending this action nowhere; Capybara cannot see any HTML to parse. There is no direct view that corresponds with `update` so we need to redirect it somewhere. Let's bring the user back to the songs index.

```ruby
class CartController < ApplicationController
  def update
    redirect_to '/songs'
  end
end
```

Does it work? Start up your server, visit the songs index page, and click the "Add Song" button. Does it redirect you back to the same page? Good.

When you run the test, it fails looking for the content "You now have 1 of #{@song.title} in your cart." This should be a flash message. Let's update our action to find the requested song and display the message

```ruby
class CartController < ApplicationController
  def update
    song = Song.find(params[:song_id])
    flash[:notice] = "You now have 1 copy of #{song.title} in your cart."
    redirect_to '/songs'
  end
end
```

If you don't already have something to render flash messages, you will need to add one. In the `/app/views/layouts/application.html.erb` file, add this code right before the `yield` tag.

```erb
<% flash.each do |type, message| %>
    <section class=<%= type %>>
      <p><%= message %></p>
    </section>
<% end %>
```

Because we put this code in `application.html.erb`, we can put a flash message in any controller action and it will appear in any view!

Great! That test is passing. But what happens if we add two songs?

### Adding Multiple Songs and Updating Our Flash

Let's update our test to check and see.

```ruby
#spec/features/cart/add_song_spec.rb

RSpec.describe "When a user adds songs to their cart" do
  it "displays a message" do
    ...
  end

  it "the message correctly increments for multiple songs" do
    artist = Artist.create(name: 'Rick Astley')
    song_1 = artist.songs.create(title: 'Never Gonna Give You Up', length: 250, play_count: 1000000)
    song_2 = artist.songs.create(title: "Don't Stop Believin'", length: 300, play_count: 1)

    visit '/songs'

    within("#song-#{song_1.id}") do
      click_button "Add Song"
    end

    within("#song-#{song_2.id}") do
      click_button "Add Song"
    end

    within("#song-#{song_1.id}") do
      click_button "Add Song"
    end

    expect(page).to have_content("You now have 2 copies of #{song_1.title} in your cart.")
  end
end

```

If we run this now it fails because even though we've added two songs, our flash message will always say that we have one song. We need a way to store information about how many songs have been added.

Thinking through this a little bit, we could store something in the database every time someone adds a songs to their cart, but there are a few drawbacks to that approach:

* It would require multiple updates (and potentially deletions) while someone makes up their mind about what to actually keep in their cart. That's a lot of extra database work.
  * It would also require the user to log in before they could add anything to their cart so that we could create that association in our database anyway.
* It could potentially result in some abandoned database records if a user decides not to finalize their cart contents.

Instead, we need to find a way to store the state of a cart (which songs have been added to our cart and how many of each type). Can we store data in a session?

Let's go back into the CartController:

```ruby
class CartController < ApplicationController
  def update
    song = Song.find(params[:song_id])
    song_id_str = song.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][song_id_str] ||= 0
    session[:cart][song_id_str] = session[:cart][song_id_str] + 1
    flash[:notice] = "You now have #{session[:cart][song_id_str]} copy of #{song.title} in your cart."
    redirect_to "/songs"
  end
end
```

#### Slight Detour
You might be wondering why we're converting the song's integer ID to a string, and initializing it to 0 even though we're telling `Hash` to initialize all `new` keys with a value of 0. While our code could certainly process the song ID as an integer in memory, when the session is packed up as one big string to store in the client cookie, and read back again after the next request, the song ID is no longer an integer. Also, the `Hash.new(0)` functionality is also lost when we read a cart from the cookie, since `[:cart]` now exists, so on subsequent requests, `Hash.new(0)` is never run.

#### Back to our code ...

This is close. Our test will still fail, but it looks like our number is incrementing correctly. Our error likely looks something like:

```
  1) User adds a song to their cart the message correctly increments for multiple songs
     Failure/Error: expect(page).to have_content("You now have 2 copies of Song 1 in your cart.")
       expected to find text "You now have 2 copies of #{song.title} in your cart." in ""You now have 2 copy of #{song.title} in your cart.""
     # ./spec/features/user_adds_song_to_cart_spec.rb:25:in `block (2 levels) in <top (required)>'
```

It's the plural of "copy/copies" that's giving us a hard time. Luckily we have a tool for that with `#pluralize`. This is a view helper method, so in order to use it here in our controller to set a flash message, we'll need to include `ActionView::Helpers::TextHelper` explicitly in our controller.

```ruby
class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    song = Song.find(params[:song_id])
    song_id_str = song.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][song_id_str] ||= 0
    session[:cart][song_id_str] = session[:cart][song_id_str] + 1
    quantity = session[:cart][song_id_str]
    flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{song.title} in your cart."
    redirect_to "/songs"
  end
end
```

And there we have another passing test.

That's nice, but wouldn't it be better to see how many songs total we have in our cart? Yes. Yes it would.

### Adding a Cart Tracker

First, let's update our feature test.

```ruby
require 'rails_helper'

RSpec.feature "When a user adds songs to their cart" do
  it "displays a message" do
    ...
  end

  it "the message correctly increments for multiple songs" do
    ...
  end

  it "displays the total number of songs in the cart" do
    artist = Artist.create(name: 'Rick Astley')
    song_1 = artist.songs.create(title: 'Never Gonna Give You Up', length: 250, play_count: 1000000)
    song_2 = artist.songs.create(title: "Don't Stop Believin'", length: 300, play_count: 1)

    visit "/songs"

    expect(page).to have_content("Cart: 0")

    within("#song-#{song_1.id}") do
      click_button "Add Song"
    end

    expect(page).to have_content("Cart: 1")

    within("#song-#{song_2.id}") do
      click_button "Add Song"
    end

    expect(page).to have_content("Cart: 2")

    within("#song-#{song_1.id}") do
      click_button "Add Song"
    end

    expect(page).to have_content("Cart: 3")
  end
end
```

If we run our test now, we'll see that we have not included "Cart: 0" in our view or main app layout. It's easy enough to get past that error. Let's open the `app/views/layouts/application.html.erb` file and add a paragraph tag with the cart information just below our flash message. For now let's hardcode it so that we can see what happens, then think through how we want to implement this permanently.

```html
<p>Cart: 0</p>
```

Sure enough, that gets us to a new error where now our test is looking for "Cart: 1" and not finding it on our page (because we're still displaying "Cart: 0" since it's hard-coded in our view).

We could potentially pass in a count specifically to use in that slot, but it's starting to feel like we're doing a LOT of logic with this cart. More than should probably just be handled in the controller.

What we *really* want to do here is to have some sort of an object that I can call `#total` on to get the number of objects in the cart. I don't have a model to use since we're not saving the cart in the database, but that doesn't stop me from creating a `Cart` class that doesn't interact with the database. We call these types of classes "POROS" (Plain Old Ruby Objects). The question becomes where to start, and what to refactor.

Since we're thinking of implementing this here in the view, let's start there with how we'd *like* this object to behave. Change the new line that we added to the view to the following:

```
<p>Cart: <%= @cart.total_count %></p>
```

Run our test, and ... we've broken everything!!!

```
  3) User adds a song to their cart the total number of items in the cart increments
     Failure/Error: <p>Cart: <%= @cart.total_count %></p>

     ActionView::Template::Error:
       undefined method `total_count' for nil:NilClass`
```

That's okay! We can fix this!!

In our SongsController, let's go ahead and add the instance variable `@cart`. Let's also assume that we'll need to pass it the contents currently sitting in our session to make it work.

```ruby
  def index
    @songs = Song.all
    @cart = Cart.new(session[:cart])
  end
```

When we run our tests again, we see another failing test telling us that we don't have a Cart class:

```
      Failure/Error: @cart = Cart.new(session[:cart])

      NameError:
        uninitialized constant SongsController::Cart
```

At this point, we're going to have to create our PORO, so let's start with a model test.

### Creating Our Cart PORO

In our `spec/models` folder, add a new test for our Cart class: `spec/models/cart_spec.rb`. Within our new test file, add the following:

```ruby
require 'rails_helper'

RSpec.describe Cart do

  describe "#total_count" do
    it "can calculate the total number of items it holds" do
      cart = Cart.new({
        '1' => 2,  # two copies of song 1
        '2' => 3   # three copies of song 2
      })
      expect(cart.total_count).to eq(5)
    end
  end
end
```

Run that test using `rspec spec/models` so we can avoid the distraction of all of our feature tests failing.

And now we see the error that we need to actually go create our Cart class:

```
NameError:
  uninitialized constant Cart
```

In our `app/models` folder, add `cart.rb` and insert the following code:

```ruby
class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents
  end

  def total_count
    @contents.values.sum
  end
end
```

#### Side note

Our PORO does not inherit from ApplicationRecord (or ActiveRecord::Base) because we don't store PORO's in our database. They're used "in transit" for one request/response life cycle and then discarded.

#### Back to code...

And that makes our model test pass!

Unfortunately, our feature tests still don't pass for us.

```
  3) User adds a song to their cart the total number of songs in the cart increments
     Failure/Error: contents.values.sum

     ActionView::Template::Error:
       undefined method `values' for nil:NilClass`
```

We're trying to call `#values` on our initial contents, but the first time that we render our `index` our session hasn't been set, so `initial_contents` evaluates to `nil`. Let's fix that by adding some code to ensure that `@contents` is always defined as a hash. In your Cart class:

```ruby
class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end
end
```

And now, our newest test passes, but we have more refactoring and cleanup to do so every other test can pass.

### Refactoring CartController

Let's take another look at the current status of our CartController

```ruby
class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    song = Song.find(params[:song_id])
    song_id_str = song.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][song_id_str] ||= 0
    session[:cart][song_id_str] = session[:cart][song_id_str] + 1
    quantity = session[:cart][song_id_str]
    flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{song.title} in your cart."
    redirect_to "/songs"
  end
end

```

Currently we're doing a lot of work in this controller with our cart. Now that we have a Cart PORO, it seems like we could refactor this to have the PORO take on some of that load.

Let's refactor the CartController so that it looks like this:

```ruby
class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    song = Song.find(params[:song_id])
    @cart = Cart.new(session[:cart])
    @cart.add_song(song.id)
    session[:cart] = @cart.contents
    quantity = @cart.count_of(song.id)
    flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{song.title} in your cart."
    redirect_to songs_path
  end
end
```

We're still letting the controller handle getting and setting the session, but we're putting our PORO in charge of managing the hash that we're storing there: both 1) adding songs to it, and 2) reporting on how many of a particular song we have.

Since we've added these methods to our controller, we now have a missing method error when we run our test. Let's add both methods to our model test to see that they do what we expect them to. The `subject` syntax is a nice RSpec feature to use if you're using a similar setup in many tests. In this case, we abstract the logic for creating a `Cart` instance, and can call that return value with `subject`. I like how this reads, but feel free to forego this pattern if you don't like it as much.

```ruby
require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({'1' => 2, '2' => 3}) }

  describe "#total_count" do
    it "calculates the total number of songs it holds" do
      expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_song" do
    it "adds a song to its contents" do
      cart = Cart.new({
        '1' => 2,  # two copies of song 1
        '2' => 3   # three copies of song 2
      })
      subject.add_song(1)
      subject.add_song(2)

      expect(subject.contents).to eq({'1' => 3, '2' => 4})
    end
  end
end
```

In order to get the Cart PORO tests to pass, add the following method to our Cart PORO.

```ruby
def add_song(id)
  @contents[id.to_s] = @contents[id.to_s] + 1
end
```

What if we ask for the count of a non-existent song? Let's add a test:

```ruby
describe "#count_of" do
  it "returns the count of all songs in the cart" do
    cart = Cart.new({})

    expect(cart.count_of(5)).to eq(0)
  end
end
```

Let's add a `count_of` method that **coerces** `nil` values to `0` with `#to_i`.

```ruby
class Cart

...

  def count_of(id)
    @contents[id.to_s].to_i
  end
```

What if we want to add a song that hasn't been added yet?

```ruby
describe "#add_song" do
  it "adds a song to its contents" do
    ...
  end

  it "adds a song that hasn't been added yet" do
    subject.add_song('3')

    expect(subject.contents).to eq({'1' => 2, '2' => 3, '3' => 1})
  end
end
```

We need this test for the case when a user has added some songs and tries to add a new song. Remember, when we initialize a new Cart, we pass it the contents of `session[:cart]`, which acts like a Hash, but it doesn't have a default value. The default value gets lost in translation between our app and the client's cookies.

This test is giving us an `undefined method '+' for nil:NilClass` error because `@contents[id.to_s]` is coming back as nil when a song hasn't been set yet.  Let's use our handy new `count_of` method that coerces `nil`s to 0 to fix this:

```ruby
def add_song(id)
  @contents[id.to_s] = count_of(id) + 1
end
```

And our PORO tests are all passing!

### Controller Cleanup

Our feature tests are still in bad shape. Our newest test should pass, but if you run all the tests you'll see a lot of failures. It's from the line in our `application.html.erb` where we call `@cart.total_count`. `@cart` is nil because, although we set it in our `SongsController#index` and `CartController#update`, we didn't set it in every action. We *could* go through every action and add the line `@cart = Cart.new(session[:cart])` to each one, but that wouldn't be very DRY. Instead, let's do some refactoring.

Instead of creating an `@cart` all over the place, we'll make a method on our `ApplicationController` that will handle creating the `Cart` object:

```ruby
  helper_method :cart

  def cart
    @cart ||= Cart.new(session[:cart])
  end
```

If for some reason we access the cart more than once in a given request/response cycle, the cart object is memoized with `||=`.

We make this new method a helper_method so that we can access it in the views.

Now we can delete the following line from both the SongsController and CartController:

```ruby
  @cart = Cart.new(session[:cart])
```

And now change all the references from `@cart` to `cart`.

Double check to see that our tests are still passing, and we should be in good shape!

## Checkin and Review

* Why fuss with all of this PORO business?
* "Where" does PORO data live?
* How do I add a flash message to a view?

## Extensions

#### Showing the cart

Let's say that you wanted users to be able to click on "View Cart" (similar to "View Cart" on an e-commerce site).

* Which controller?
* What does the view look like?
* How can we make the cart have access to Cart objects instead of just iterating through a hash of keys and values?

#### Ending and saving the cart contents

What about allowing users to save their cart songs as a package? You might approach it something like this:

```erb
  Cart: <%= cart.total_count %>
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
    cart.contents.each do |song_id, quantity|
      package.songs.new(song_id: song_id, quantity: quantity)
    end

    if package.save
      session[:cart] = nil
      flash[:notice] = "Your bag is packed! You packed #{package.songs.count} songs."
      redirect_to songs_path
    else
      # implement if you have validations
    end
  end
end
```
