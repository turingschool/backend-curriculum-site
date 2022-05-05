---
layout: page
title: Black Thursday Iteration 3 - Item Sales
---
_[Back to Black Thursday Home](./index)_

We've got a good foundation, now it's time to actually track the sale of items. There are three new data files to mix into the system, so for this iteration we'll focus primarily on DAL with just a bit of Business Intelligence.

Parts to iteration 3:
[Data Access Layer](#data-access-layer)
[Business Intelligence](#business-intelligence)

Data Access Layer
------------

### `InvoiceItem`
`InvoiceItem` objects are how invoices are connected to items. A single `InvoiceItem` connects a single `Item` with a single `Invoice`.

The `InvoiceItem` has the following data accessible:

*   `id` - returns the integer id
*   `item_id` - returns the item id
*   `invoice_id` - returns the invoice id
*   `quantity` - returns the quantity
*   `unit_price` - returns the unit_price
*   `created_at` - returns a `Time` instance for the date the invoice item was first created
*   `updated_at` - returns a `Time` instance for the date the invoice item was last modified

It also offers the following method:

*   `unit_price_to_dollars` - returns the price of the invoice item in dollars formatted as a `Float`

We create an instance like this:

```ruby
ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal(10.99, 4),
  :created_at => Time.now,
  :updated_at => Time.now
})
# => <InvoiceItem...>

ii.unit_price_to_dollars
# => 23.48
```

---

### `InvoiceItemRepository`

The `InvoiceItemRepository` is responsible for holding and searching our `InvoiceItem`
instances. It offers the following methods:

*   `all` - returns an array of all known `InvoiceItem` instances
*   `find_by_id` - returns either `nil` or an instance of `InvoiceItem` with a matching ID
*   `find_all_by_item_id` - returns either `[]` or one or more matches which have a matching item ID
*   `find_all_by_invoice_id` - returns either `[]` or one or more matches which have a matching invoice ID
*    `create(attributes)` - create a new `InvoiceItem` instance with the provided `attributes`. The new `InvoiceItem`'s id should be the current highest `InvoiceItem` id plus 1.
*    `update(id, attribute)` - update the `InvoiceItem` instance with the corresponding `id` with the provided `attributes`. Only the invoice_item's `quantity` and `unit_price` can be updated. This method will also change the invoice_item's `updated_at` attribute to the current time.
*    `delete(id)` - delete the `InvoiceItem` instance with the corresponding `id`

The data can be found in `data/invoice_items.csv` so the instance is created and used like this:

```ruby
sales_engine = SalesEngine.from_csv(:invoice_items => "./data/invoice_items.csv")
invoice_item = sales_engine.invoice_items.find_by_id(6)
# => <InvoiceItem...>
```

---

### `Transaction`

Transactions are billing records for an invoice. An invoice can have multiple transactions, but should have at most one that is successful.

The transaction has the following data accessible:

*   `id` - returns the integer id
*   `invoice_id` - returns the invoice id
*   `credit_card_number` - returns the credit card number
*   `credit_card_expiration_date` - returns the credit card expiration date
*   `result` - the transaction result
*   `created_at` - returns a `Time` instance for the date the transaction was first created
*   `updated_at` - returns a `Time` instance for the date the transaction was last modified

We create an instance like this:

```ruby
t = Transaction.new({
  :id => 6,
  :invoice_id => 8,
  :credit_card_number => "4242424242424242",
  :credit_card_expiration_date => "0220",
  :result => "success",
  :created_at => Time.now,
  :updated_at => Time.now
})
```

---

### `TransactionRepository`

The `TransactionRepository` is responsible for holding and searching through our `Transaction`
instances. It offers the following methods:

*   `all` - returns an array of all known `Transaction` instances
*   `find_by_id` - returns either `nil` or an instance of `Transaction` with a matching ID
*   `find_all_by_invoice_id` - returns either `[]` or one or more matches which have a matching invoice ID
*   `find_all_by_credit_card_number` - returns either `[]` or one or more matches which have a matching credit card number
*   `find_all_by_result` - returns either `[]` or one or more matches which have a matching status
*    `create(attributes)` - create a new `Transaction` instance with the provided `attributes`. The new `Transaction`'s id should be the current highest `Transaction` id plus 1.
*    `update(id, attribute)` - update the `Transaction` instance with the corresponding `id` with the provided `attributes`. Only the transaction's `credit_card_number`, `credit_card_expiration_date`, and `result` can be updated. This method will also change the transaction's `updated_at` attribute to the current time.
*    `delete(id)` - delete the `Transaction` instance with the corresponding `id`

The data can be found in `data/transactions.csv`. An instance is created and used like this:

```ruby
sales_engine = SalesEngine.from_csv(:transactions => "./data/transactions.csv")
transaction = sales_engine.transactions.find_by_id(6)
# => <Transaction... @id=6>
```

---

### `Customer`
A Customer represents a person who has made one or more purchases in our system.

The `customer` instance has the following data accessible:

*   `id` - returns the integer id
*   `first_name` - returns the first name
*   `last_name` - returns the last name
*   `created_at` - returns a `Time` instance for the date the customer was first created
*   `updated_at` - returns a `Time` instance for the date the customer was last modified

We create an instance like this:

```ruby
c = Customer.new({
  :id => 6,
  :first_name => "Joan",
  :last_name => "Clarke",
  :created_at => Time.now,
  :updated_at => Time.now
})
# => <Customer...>
```

### `CustomerRepository`

The `CustomerRepository` is responsible for holding and searching our `Customer`
instances. It offers the following methods:

*   `all` - returns an array of all known `Customer` instances
*   `find_by_id` - returns either `nil` or an instance of `Customer` with a matching ID
*   `find_all_by_first_name` - returns either `[]` or one or more matches which have a first name matching the substring fragment supplied
*   `find_all_by_last_name` - returns either `[]` or one or more matches which have a last name matching the substring fragment supplied
*    `create(attributes)` - create a new `Customer` instance with the provided `attributes`. The new `Customer`'s id should be the current highest `Customer` id plus 1.
*    `update(id, attribute)` - update the `Customer` instance with the corresponding `id` with the provided `attributes`. Only the customer's `first_name` and `last_name` can be updated. This method will also change the customer's `updated_at` attribute to the current time.
*    `delete(id)` - delete the `Customer` instance with the corresponding `id`

The data can be found in `data/customers.csv` so the instance is created and used like this:

```ruby
sales_engine = SalesEngine.from_csv(:customers => "./data/customers.csv")
customer = sales_engine.customers.find_by_id(6)
# => <Customer... @id=6>
```
---

Business Intelligence
----------------

Assuming we have a `SalesEngine` instance called `sales_engine`, let's initialize a `SalesAnalyst` like this:

```ruby
sales_analyst = sales_engine.analyst
```

*   `sales_analyst.invoice_paid_in_full?(invoice_id)` returns `true` if the `Invoice` with the corresponding id is paid in full
*   `sales_analyst.invoice_total(invoice_id)` returns the total $ amount of the `Invoice` with the corresponding id.

**Notes:**

* Failed charges should never be counted in revenue totals or statistics.
* An invoice is considered paid in full if it has a successful transaction.
