---
title: Customizing JSON in your API
length: 90
tags: json, javascript, rails, ruby, api
---

## Learning Goals

* Generate and customize Rails Serializers
* Discuss other serialization options, like Jbuilder
* Understand what constitutes presentation logic in the context of serving a JSON API and why formatting in the model is not the right place

## Slides

Available [here](../slides/customizing_json)

## Warmup

Research ActiveModel Serializers

* What do serializers allow us to do?
* What resources were you able to find? Which seem most promising?
* What search terms did you use that gave the best results?

## Active Model Serializers

AMS allow us to break from the concept of views fully with our API, and instead, mold that data in an object-oriented fashion.

When we call `render json:`, Rails makes a call to `as_json` under the hood unless we have a serializer set up. Eventually, `as_json` calls `to_json` and our response is generated.

With how we've used `render json:` up til now, all data related with the resources in our database is sent back to the client as-is.

Let's imagine that you don't just want the raw guts of your model converted to JSON and sent out to the user -- maybe you want to customize what you send back.

## Scavenger Hunt

With a partner, based on the resources you found, how do you:

* set up AMS in your Rails project?
* create a new serializer?
* tell a serializer which attributes to display?
* tell a serializer to display related objects?
* tell a serializer to display a calculated value?

Share your findings with the class.

## Code Along

### Adding to Our Existing Project

We're going to start where we left off in the internal API testing lesson. Feel free to use the repository that you created yesterday. Otherwise, you can clone the repo below as a starting place.

```bash
git clone https://github.com/s-espinosa/building_internal_apis.git
bundle
git checkout building_api_complete
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
  - Create routes.
  - Set `index` and `show` methods to render appropriate json

### Desired Responses

Use Postman or your browser to view the current responses that your API is providing to the routes listed below:

* api/v1/items
* api/v1/items/:id
* api/v1/orders
* api/v1/orders/:id

Compare those responses to the responses below. How do they differ?

**api/v1/items**

```javascript
[
  {
    "id": 1,
    "name": "Hammer",
    "price": 11
  },
  {...}
]
```

**api/v1/items/:id**

```javascript
{
  "id": 1,
  "name": "Hammer",
  "price": 11,
  "num_orders": 5,
  "orders": [
    {"order_number": "12345ABC"},
    {...}
  ]
}
```

**api/v1/orders**

```javascript
[
  {
    "id": 1,
    "order_number": "12345ABC",
  },
  {...}
]
```

**api/v1/orders/:id**

```javascript
{
  "id": 1,
  "order_number": "12345ABC",
  "num_items": 5,
  "items": [
    {
      "id": 1,
      "name": "Hammer",
      "price": 11
    },
    {...}
  ]
}
```

### Using Active Model Serializers to modify `as_json`

Install AMS with a gem: `gem 'active_model_serializers', '~> 0.10.0'`

We're going to create a serializer for `Order`.

- Create your serializer
  - `rails g serializer order`

- Add a few attributes
  - Some existing fields
    - `id`, `order_number`
  - Some custom fields
    - `num_items`
  - A relationship
    - `items`

Our final product should look something like this:

```ruby
# controllers/api/v1/orders_controller.rb
class Api::V1::OrdersController < ApplicationController
  def index
    render json: Order.all
  end

  def show
    render json: Order.find(params[:id])
  end
end
```

```ruby
# serializers/order_serializer.rb
class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_number, :num_items

  has_many :items

  def num_items
    object.items.count
  end
end
```

## Lab

Do what we did to `Order`, but on `Item` now.

- Some existing fields
  - `id`, `name`, `description`
- Some custom fields
  - `num_orders`
- A relationship
  - `orders`


## Additional Resources

Here's some branches of Storedom with customized JSON:

- [Active Model Serializer Docs](https://github.com/rails-api/active_model_serializers/tree/0-10-stable)
- Storedom branch for [Serializers](https://github.com/turingschool-examples/storedom/tree/custom_json_serializers)
- Storedom branch for [Jbuilder](https://github.com/turingschool-examples/storedom/tree/custom_json_jbuilder)
