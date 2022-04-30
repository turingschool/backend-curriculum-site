---
layout: page
title: Black Thursday Iteration 2 - Basic Invoices
---
_[Back to Black Thursday Home](./index)_

Now we'll begin to move a little faster. Let's work with invoices to build up the data access layer and business intelligence in one iteration.

Parts to iteration 3:
[Data Access Layer](#data-access-layer)
[Business Intelligence](#business-intelligence)

Data Access Layer
----------

### `InvoiceRepository`

The `InvoiceRepository` is responsible for holding and searching our `Invoice`
instances. It offers the following methods:

*   `all` - returns an array of all known `Invoice` instances
*   `find_by_id` - returns either `nil` or an instance of `Invoice` with a matching ID
*   `find_all_by_customer_id` - returns either `[]` or one or more matches which have a matching customer ID
*   `find_all_by_merchant_id` - returns either `[]` or one or more matches which have a matching merchant ID
*   `find_all_by_status` - returns either `[]` or one or more matches which have a matching status
*    `create(attributes)` - create a new `Invoice` instance with the provided `attributes`. The new `Invoice`'s id should be the current highest `Invoice` id plus 1.
*    `update(id, attribute)` - update the `Invoice` instance with the corresponding `id` with the provided `attributes`. Only the invoice's `status` can be updated. This method will also change the invoice's updated_at attribute to the current time.
*    `delete(id)` - delete the `Invoice` instance with the corresponding `id`

The data can be found in `data/invoices.csv` so the instance is created and used like this:

```ruby
se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
invoice = se.invoices.find_by_id(6)
# => <invoice>
```

---

### `Invoice`

The invoice has the following data accessible:

*   `id` - returns the integer id
*   `customer_id` - returns the customer id
*   `merchant_id` - returns the merchant id
*   `status` - returns the status
*   `created_at` - returns a `Time` instance for the date the item was first created
*   `updated_at` - returns a `Time` instance for the date the item was last modified

We create an instance like this:

```ruby
i = Invoice.new({
  :id          => 6,
  :customer_id => 7,
  :merchant_id => 8,
  :status      => "pending",
  :created_at  => Time.now,
  :updated_at  => Time.now,
})
```

---

Business Intelligence
-------------

Assuming we have a `SalesEngine` instance called `sales_engine`, let's initialize a `SalesAnalyst` like this:

```ruby
sales_analyst = sales_engine.analyst
```

Then, using the `sales_analyst` instance, answer the following questions:

### How many invoices does the average merchant have?

```ruby
sales_analyst.average_invoices_per_merchant # => 10.49
sales_analyst.average_invoices_per_merchant_standard_deviation # => 3.29
```

### Who are our top performing merchants?

Which merchants are *more than __two__* standard deviations *above* the mean?

```ruby
sales_analyst.top_merchants_by_invoice_count # => [merchant, merchant, merchant]
```

### Who are our lowest performing merchants?

Which merchants are *more than __two__* standard deviations *below* the mean?

```ruby
sales_analyst.bottom_merchants_by_invoice_count # => [merchant, merchant, merchant]
```

### Which days of the week see the most sales?

On which days are invoices created at more than one standard deviation *above* the mean?

```ruby
sales_analyst.top_days_by_invoice_count # => ["Sunday", "Saturday"]
```

### What percentage of invoices are not shipped?

What percentage of invoices are `shipped` vs `pending` vs `returned`? (takes symbol as argument)

```ruby
sales_analyst.invoice_status(:pending) # => 29.55
sales_analyst.invoice_status(:shipped) # => 56.95
sales_analyst.invoice_status(:returned) # => 13.5
```
