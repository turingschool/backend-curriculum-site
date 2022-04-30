---
layout: page
title: Black Thursday Iteration 1 - Business Intelligence
---
_[Back to Black Thursday Home](./index)_

Starting the Analysis Layer
-----------

Our analysis will use the data we constructed in iteration 1 to answer questions regarding data calculation.

But, who in the system will answer those questions? Assuming we have a `SalesEngine` instance called `sales_engine`, let's initialize a `SalesAnalyst` like this:

```ruby
sales_analyst = sales_engine.analyst
```

Then, answer the following questions:

### How many products do merchants sell?

Do most of our merchants offer just a few items, or do they represent a warehouse?

```ruby
sales_analyst.average_items_per_merchant # => 2.88
```

And what's the standard deviation?

```ruby
sales_analyst.average_items_per_merchant_standard_deviation # => 3.26
```

### Note on Standard Deviations

There are two ways to calculate standard deviations -- for a population, and for a sample.

For this project, use the _sample_ standard deviation.

As an example, given the set `3,4,5`. We would calculate the deviation using the following steps:

1.  Take the difference between each number and the mean, then square it.
2.  Sum these square differences together.
3.  Divide the sum by the number of elements minus 1.
4.  Take the square root of this result.

Or, in pseudocode:

```
set = [3,4,5]

std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )
```

---

### Which merchants sell the most items?

Maybe we could set a good example for our lower sellers by displaying the merchants who have the most items for sale. Which merchants are more than one standard deviation above the average number of products offered?

```ruby
sales_analyst.merchants_with_high_item_count # => [merchant, merchant, merchant]
```

---

### What are prices like on our platform?

Are these merchants selling commodity or luxury goods? Let's find the average price of a merchant's items (by supplying the merchant ID):

```ruby
sales_analyst.average_item_price_for_merchant(12334159) # => BigDecimal
```

Then we can sum all of the averages and find the average price across all merchants (this implies that each merchant's average has equal weight in the calculation):

```ruby
sales_analyst.average_average_price_per_merchant # => BigDecimal
```

---

### Which are our *Golden Items*?

Given that our platform is going to charge merchants based on their sales, expensive items are *extra* exciting to us. So, which are our "Golden Items", those items that are __two__ standard deviations above the average item price? Return the item objects of these "Golden Items".

```ruby
sales_analyst.golden_items # => [<item>, <item>, <item>, <item>]
```
