---
layout: page
title: Black Thursday Iteration 4 - Merchant Analytics
---
_[Back to Black Thursday Home](./index)_

Our operations team is asking for better data about our merchants, and have asked for a more advanced set of methods that return some different analytics.



Assuming we have a `SalesEngine` instance called `sales_engine`, let's initialize a `SalesAnalyst` like this:

```ruby
sales_analyst = sales_engine.analyst
```

### 1. Find out the total revenue for a given date:

```rb
sales_analyst.total_revenue_by_date(date) #=> $$
```
**Note:** When calculating revenue the ``unit_price`` listed within ``invoice_items`` should be used. The ``invoice_item.unit_price`` represents the final sale price of an item after sales, discounts or other intermediary price changes.

---

### 2. Find the top x performing merchants in terms of revenue:  

```rb
sales_analyst.top_revenue_earners(x) #=> [merchant, merchant, merchant, merchant, merchant]
```

If no number is given for `top_revenue_earners`, it takes the top 20 merchants by default:

```rb
sales_analyst.top_revenue_earners #=> [merchant * 20]
```

---

### 3. Which merchants have pending invoices:

```rb
sales_analyst.merchants_with_pending_invoices #=> [merchant, merchant, merchant]
```

**Note:** an invoice is considered pending if none of its transactions are successful.


---

### 4. Which merchants offer only one item:

```rb
sales_analyst.merchants_with_only_one_item #=> [merchant, merchant, merchant]
```

#### 5. Merchants that only sell one item by the month they registered (merchant.created_at):

```rb
sales_analyst.merchants_with_only_one_item_registered_in_month("Month name") #=> [merchant, merchant, merchant]
```

---

### 6. Find the total revenue for a single merchant:

```rb
sales_analyst.revenue_by_merchant(merchant_id) #=> $
```

---

#### ___The following two methods are not covered by the spec harness. As a group, write a blog post of approximately 500 words as to how these methods work.___


### 7 & 8. Which item sold most in terms of quantity and revenue:

```rb
sales_analyst.most_sold_item_for_merchant(merchant_id) #=> [item] (in terms of quantity sold) or, if there is a tie, [item, item, item]

sales_analyst.best_item_for_merchant(merchant_id) #=> item (in terms of revenue generated)
```
