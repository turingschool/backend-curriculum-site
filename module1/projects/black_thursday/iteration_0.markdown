---
layout: page
title: Black Thursday Iteration 0 - Merchants & Items
---
_[Back to Black Thursday Home](./index)_

The goal of this iteration is to get the ball rolling by focusing on a "Data Access Layer" for multiple CSV files.

## Data Access Layer

The idea of a *DAL* is to write classes which load and parse your raw data, allowing your system to then interact with rich Ruby objects to do more complex analysis. In this iteration, we'll build the beginnings of a DAL by building the classes described below:

---

### `Merchant`

The Merchant is one of the critical concepts in our data hierarchy.

*   `id` - returns the integer `id` of the merchant
*   `name` - returns the name of the merchant

We create an instance like this:

```ruby
m = Merchant.new({:id => 5, :name => "Turing School"})
# => <Merchant...>
```

---

### `MerchantRepository`

The `MerchantRepository` is responsible for holding and searching our `Merchant`
instances. It offers the following methods:

*   `all` - returns an array of all known `Merchant` instances
*   `find_by_id(id)` - returns either `nil` or an instance of `Merchant` with a matching ID
*   `find_by_name(name)` - returns either `nil` or an instance of `Merchant` having done a *case insensitive* search
*   `find_all_by_name(name)` - returns either `[]` or one or more matches which contain the supplied name fragment, *case insensitive*
*    `create(attributes)` - create a new `Merchant` instance with the provided `attributes`. The new `Merchant`'s id should be the current highest `Merchant` id plus 1.
*    `update(id, attributes)` - update the `Merchant` instance with the corresponding `id` with the provided `attributes`. Only the merchant's `name` attribute can be updated.
*    `delete(id)` - delete the `Merchant` instance with the corresponding `id`

The data can be found in `data/merchants.csv`. The instance should be created in the `SalesEngine` (see below), so that the instance is created and used like this:

```ruby
se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

mr = se.merchants
merchant = mr.find_by_name("CJsDecor")
# => <Merchant...>
```

---

### `Item`

The Item instance offers the following methods:

*   `id` - returns the integer id of the item
*   `name` - returns the name of the item
*   `description` - returns the description of the item
*   `unit_price` - returns the price of the item formatted as a `BigDecimal`
*   `created_at` - returns a `Time` instance for the date the item was first created
*   `updated_at` - returns a `Time` instance for the date the item was last modified
*   `merchant_id` - returns the integer merchant id of the item

It also offers the following method:

*   `unit_price_to_dollars` - returns the price of the item in dollars formatted as a `Float`

We create an instance like this:

```ruby
i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
})
# => <Item...>

i.unit_price_to_dollars
# => 10.99
```

---

### `ItemRepository`

The `ItemRepository` is responsible for holding and searching our `Item`
instances. This object represents one line of data from the file `items.csv`.

It offers the following methods:

*   `all` - returns an array of all known `Item` instances
*   `find_by_id(id)` - returns either `nil` or an instance of `Item` with a matching ID
*   `find_by_name(name)` - returns either `nil` or an instance of `Item` having done a *case insensitive* search
*   `find_all_with_description(description)` - returns either `[]` or instances of `Item` where the supplied string appears in the item description (case insensitive)
*   `find_all_by_price(price)` - returns either `[]` or instances of `Item` where the supplied price exactly matches
*   `find_all_by_price_in_range(range)` - returns either `[]` or instances of `Item` where the supplied price is in the supplied range (a single Ruby `range` instance is passed in)
*   `find_all_by_merchant_id(merchant_id)` - returns either `[]` or instances of `Item` where the supplied merchant ID matches that supplied
*    `create(attributes)` - create a new `Item` instance with the provided `attributes`. The new `Item`'s id should be the current highest `Item` id plus 1.
*    `update(id, attributes)` - update the `Item` instance with the corresponding `id` with the provided `attributes`. Only the item's `name`, `description`, and `unit_price` attributes can be updated. This method will also change the items `updated_at` attribute to the current time.
*    `delete(id)` - delete the `Item` instance with the corresponding `id`

Similar to the `MerchantRepository`, the `ItemRepository` is initialized from the `SalesEngine` class (see below), and its data can be found in `data/items.csv`. It is initialized and used like this:

```ruby
se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"
})

ir   = se.items
item = ir.find_by_name("Item Repellat Dolorum")
# => <Item...>
```

---

### `SalesEngine`

Once we have an `ItemRepository` and a `MerchantRepository`, we can tie everything together with one common root, a `SalesEngine` instance:

```ruby
se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
```

From there we can find the child instances:

*   `items` returns an instance of `ItemRepository` with all the item instances loaded
*   `merchants` returns an instance of `MerchantRepository` with all the merchant instances loaded
