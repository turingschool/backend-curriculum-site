# Advanced ActiveRecord

---

# Warmup

* What are the tables in our RailsEngine project?
* What information is in each table?
* How are those tables related?
* If we wanted to find the 5 most expensive invoices with successful transactions:
    * What tables would we need to query?
    * What information would we need from each table?
    * What calculations would we need to perform?
    * Can you generate a SQL query for this?

---

# SQL Is Fun

```sql
SELECT invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue FROM invoices
JOIN invoice_items ON invoices.id = invoice_items.invoice_id
JOIN transactions ON transactions.invoice_id = invoices.id
WHERE transactions.result = 'success'
GROUP BY invoices.id
ORDER BY revenue DESC
LIMIT 5;
```

---

# Working with IDs

* Lots of code snippets in the next section
* Often returning IDs instead of objects
* Learning tool that we're using temporarily
* Showing in context of models
* Don't recommend actually adding these methods
* Can practice in the console

---

# Group

* Used to group by a characteristic
* Needs an aggregate function

```ruby
# On Transaction
# Returns a hash with IDs for keys
def self.results_counts
  group(:result).count
end
```

---

# Group With Calculation

* Can use calculations as aggregate funcitons

```ruby
# On InvoiceItem
# Returns a hash with IDs for keys
def self.invoice_totals
  group(:invoice_id).sum("quantity * unit_price")
end
```

---

# Group With Order

```ruby
# On Invoice
# Returns a hash with IDs for keys
def self.merchant_count_of_invoices
  group(:merchant_id).order('count_all DESC').count
end
```

---

# Group With Order Calculation

```ruby
# On InvoiceItem
def self.invoices_by_cost
  group(:invoice_id).order("sum(quantity * unit_price)")
end
```

---

# Joins

* Class method
* Pull multiple records on originating model
* Limited to records where related record exists

```ruby
# On the Invoice model
def self.invoices_with_a_transaction
  joins(:transactions)
end
```

---

# Merge

* Use with a `.joins` to apply a method from the joined model

```ruby
# on the Invoice model
def self.successful_invoices
  joins(:transactions).merge(Transaction.success)
end
```

---

# Select

```ruby
# On Merchant
def self.no_dates
  select(:id, :name)
end
```

---

# Select (So what?)

```ruby
# On Merchant
def self.merchant_plus_invoices
  joins(:invoices)
    .select('merchants.id, name, count(invoices.id) AS count_of_invoices')
    .group('merchants.id')
end
```

---

# Putting it All Together

* Invoices with the highest total cost

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

---

# Potential Refactor

```ruby
def self.expensive_invoices
  success
    .joins(:invoice_items)
    .group(:id)
    .order("sum(quantity * unit_price)")
    .limit(5)
end
```

---

# Find By SQL

```ruby
# On the invoice model
def self.successful_invoices
  find_by_sql("SELECT invoices.*, transactions.id AS transaction_id FROM invoices
               JOIN transactions ON transactions.invoice_id = invoices.id
               WHERE transactions.result = 'success'")
end
```

---

# Partner Practice

Find the 5 customers who have spent the most money

* What tables will be involved?
* What is the important information from those tables?
* Why?
* Where will this method likely live?

