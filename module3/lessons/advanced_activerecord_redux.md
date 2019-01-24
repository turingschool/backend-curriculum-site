---
layout: page
title: Advanced ActiveRecord
length: 180
tags: rails, active record
---

## Learning Goals

* Students can diagram database relationships.
* Students can identify the tables in a database that hold information required to complete complex queries.
* Students can generate complex ActiveRecord queries using joins, group, order, select, and merge.
* Students can use the rails dbconsole  and rails console to generate ActiveRecord queries.

## Slides

Available [here](../slides/advanced_activerecord)

## Warmup (5 mins)

* What are the tables in our RailsEngine project?
* What information is in each table?
* How are those tables related?
* If we wanted to find the 5 most expensive invoices with successful transactions:
    * What tables would we need to query?
    * What information would we need from each table?
    * What calculations would we need to perform?
    * What SQL would we be able to use to create a table with this information?

## Lecture

The SQL we might use to get those top five invoices might look something like this:

```sql
SELECT invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue FROM invoices
JOIN invoice_items ON invoices.id = invoice_items.invoice_id
JOIN transactions ON transactions.invoice_id = invoices.id
WHERE transactions.result = 'success'
GROUP BY invoices.id
ORDER BY revenue DESC
LIMIT 5;
```

That's great. We could use `find_by_sql`, pass that as an argument, and be done. However, inside of Rails it can sometimes be a little jarring to see raw SQL, and some of our teammates might be more accustomed to ActiveRecord. How can we translate that query into ActiveRecord?

Let's review some tools that we have at our disposal.

### Group

* Used to group by a characteristic
* Needs an aggregate function

```ruby
# On Transaction
# Returns a hash with IDs for keys
def self.results_counts
  group(:result).count
end
```

### Group With Calculation

* Can use calculations as aggregate funcitons

```ruby
# On InvoiceItem
# Returns a hash with IDs for keys
def self.invoice_totals
  group(:invoice_id).sum("quantity * unit_price")
end
```

### Group With Order

```ruby
# On Invoice
# Returns a hash with IDs for keys
def self.merchant_count_of_invoices
  group(:merchant_id).order('count_all DESC').count
end
```

### Group With Order Calculation

```ruby
# On InvoiceItem
def self.invoices_by_cost
  group(:invoice_id).order("sum(quantity * unit_price)")
end
```

### Joins

* Class method
* Pull multiple records on originating model
* Limited to records where related record exists

```ruby
# On the Invoice model
def self.invoices_with_a_transaction
  joins(:transactions)
end
```

### Merge

* Use with a `.joins` to apply a method from the joined model

```ruby
# on the Invoice model
def self.successful_invoices
  joins(:transactions).merge(Transaction.success)
end
```

### Select

```ruby
# On Merchant
def self.no_dates
  select(:id, :name)
end
```

Cool. That's great. I can select only certain elemetns from a table and not others. What good does that do me? Well, in SQL, we can also pass calculations to our SELECT queries.

```ruby
# On Merchant
def self.merchant_plus_invoices
  joins(:invoices)
    .select('merchants.id, name, count(invoices.id) AS count_of_invoices')
    .group('merchants.id')
end
```

There's also a `count` method, but it (and other similar aggregate functions like `sum`, `average`, etc.) will return an integer or float in a way that doesn't allow us to dig down further.

### Putting it All Together

Using the methods we've explored up to this point, we should be able to get a collection of invoices with the highest total cost.

```ruby
# On the Invoice model
# Returns an array of invoices!
def self.expensive_invoices
  joins(:invoice_items, :transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .order("sum(quantity * unit_price)")
    .limit(5)
end
```

### Potential Refactor

There's a portion of this query that we might want to use a lot: finding those invoices that have a successful transaction. One of the neat things about ActiveRecord is that it takes an entire chain of commands and evaluates them before executing a query to our database. Because of that, we can extract a portion of our query to another method or a scope. Then we can rewrite our query to something like the following:

```ruby
def self.expensive_invoices
  success
    .joins(:invoice_items)
    .group(:id)
    .order("sum(quantity * unit_price)")
    .limit(5)
end
```

## Other Things to Know

### Find By SQL

If you're more comfortable in SQL and pressed for time, or if your team generally feels more comfortable in SQL and has decided as a group that the norm will be to use raw SQL for most queries, you can use `find_by_sql` to execute SQL queries against your database.

```ruby
# On the invoice model
def self.successful_invoices
  find_by_sql("SELECT invoices.*, transactions.id AS transaction_id FROM invoices
               JOIN transactions ON transactions.invoice_id = invoices.id
               WHERE transactions.result = 'success'")
end
```

## Practice

With a partner, see if you can find the five customers who have spent the most money.

* What tables will be involved?
* What is the important information from those tables?
* Why?
* Where will this method likely live?

## Resources

* [Video](https://www.youtube.com/watch?v=OccKyvGvLKE&t=1329s) from a past class and the core ideas


