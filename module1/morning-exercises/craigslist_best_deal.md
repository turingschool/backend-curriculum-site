*Baseline:* Given an array of data listing cost, quantity, and distance from your location (`[cost, quantity, distance]`), write a method that will print two strings to terminal.  You will need to incorporate the federal reimbursement mileage rate of $0.535 into your calculations.

```ruby
deals = [
[50, 50, 4],
[100, 30, 20],
[3, 200, 100]
]
```

> The best value is 50 for 5 dollars.
> The second best value is 10 for 5 dollars

*Extension:* Do the same with data coming in with a hash and unstandardized prices.

```ruby
deals = {
"Denver" => ["50 dollars", 50, 4],
"Aurora" => ["100.00", 30, 20],
"Wherever" => ["$3", 200, 100]
}
```

https://denver.craigslist.org/art/5974436208.html
