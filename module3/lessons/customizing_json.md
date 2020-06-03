---
title: Customizing JSON in your API
length: 90
tags: json, javascript, rails, ruby, api
---

## Learning Goals

* Generate and customize Rails Serializers
* Understand what constitutes presentation logic in the context of serving a JSON API and why formatting in the model is not the right place

## Warmup

On your own, research serializers. In your notebook, write down the answers to these questions:

* What do serializers allow us to do?
* What resources were you able to find? Which seem most promising?
* What search terms did you use that gave the best results?

## Serializers

Serializers allow us to break from the concept of views fully with our API, and instead, mold that data in an object-oriented fashion. We don’t have views to do our dirty work for us anymore, so we rely on serializers in order to present to whomever is consuming our API what we want them to see.

When we call `render json:`, Rails makes a call to `as_json` under the hood unless we have a serializer set up. Eventually, `as_json` calls `to_json` and our response is generated.

With how we've used `render json:` up til now, all data related with the resources in our database is sent back to the client as-is.

Let's imagine that you don't just want the raw guts of your model converted to JSON and sent out to the user -- maybe you want to customize what you send back.


## Exercise

### Adding to Our Existing Project

We're going to start where we left off in the building internal APIs lesson. Feel free to use the repository that you created yesterday. Otherwise, you can clone the repo below as a starting place.

```bash
git clone https://github.com/turingschool-examples/building_internal_apis.git
bundle
git checkout complete_building_apis
```

We want to work with objects that have related models, so let's add an `Order` model:

```bash
rails g model order order_number
rails g model order_item order:references item:references item_price:integer quantity:integer
bundle exec rake db:migrate
```

Add `gem 'faker'`:

```bash
bundle
```

Add relationships to your models:

```ruby
# in item.rb
has_many :order_items
has_many :orders, through: :order_items

# in order.rb
has_many :order_items
has_many :items, through: :order_items
```

And whip together a quick seed file:

```ruby
10.times do
  Item.create!(
    name: Faker::Commerce.product_name,
    description: Faker::ChuckNorris.fact,
  )
end

10.times do
  Order.create!(order_number: rand(100000..999999))
end

100.times do
  OrderItem.create!(
    item_id: rand(1..10),
    order_id: rand(1..10),
    item_price: rand(100..10000),
    quantity: rand(1..10)
  )
end
```

And seed

```ruby
bundle exec rake db:seed
```

Create your controller:

  - `rails g controller api/v1/orders index show`
  - Note that the generator throws in some routes at the top. This is not great.
  - Set `index` and `show` methods to render appropriate json.

### Desired Responses

Use Postman or your browser to view the current responses that your API is providing to the routes listed below:

* api/v1/orders
* api/v1/orders/:id

So we have our responses from our server, but it isn’t JSON API 1.0 And it has this created at and updated at stuff which we don’t want. So what do we do? We need to use a serializer.



### Using FastJSONAPI to modify `as_json`

Add this line to your Gemfile.

```
gem 'fast_jsonapi'
```

And then `bundle install`


We can now use the built in generator in order to make ourselves a serializer.

```rails g serializer Order id order_number```

This will add the appropriate attributes from the  Order model.  And give us only the id and order number.

Let’s check out what is in the Serializer.

```ruby
class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :order_number
end
```

So now we have this serializer, and we need to modify our controller.

```ruby
class Api::V1::OrdersController < ApplicationController
  def index
    render json: OrderSerializer.new(Order.all)
  end

  def show
    render json: OrderSerializer.new(Order.find(params[:id]))
  end
end
```

So what we are doing is instead of rendering the ActiveRecord stuff in json, we are sending it to the serializer, where the stuff gets serialized, and then that gets rendered as json.

But what if we wanted to show some awesome relationship action?

Easy.

```ruby
class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :order_number

  has_many :items
end
```

Add that to your serializer and refresh.

What if we wanted a custom attribute? We can do so using this format.

Let’s say we wanted an attribute with the number of items

```ruby
class OrderSerializer
  include FastJsonapi::ObjectSerializer
  has_many :items
  attributes :id, :order_number

  attribute :num_items do |object|
    object.items.count
  end
end
```

This syntax is a bit different from what we are used to. We use `attribute` singular, and then as a symbol we pick the name of what we want our attribute to be. We use a do end block similar to an enumerable with a block parameter. Now the block parameter, `object` is a lot like self. We get to use it for each single thing of a collection we pass to the serializer. We are essentially saying for each thing you serialize, grab the items and count them too. In this manner we can add a custom generated value for each item.

We can also have a custom static attribute like so:

```ruby
class OrderSerializer
  include FastJsonapi::ObjectSerializer
  has_many :items
  attributes :id, :order_number

  attribute :num_items do |object|
    object.items.count
  end

  attribute :greeting do
    "HELLO FRIENDS"
  end
end

```

## Extra Practice

Do what we did to `Order`, but on `Item` now.

- Some existing fields
  - `id`, `name`, `description`
- Some custom fields
  - `num_orders`
- A relationship
  - `orders`

## Additional Resources

* [Jbuilder](https://github.com/rails/jbuilder)
* [fast_jsonapi](https://github.com/Netflix/fast_jsonapi)
* [Nested Includes with fast_jsonapi](https://github.com/Netflix/fast_jsonapi/pull/152)
