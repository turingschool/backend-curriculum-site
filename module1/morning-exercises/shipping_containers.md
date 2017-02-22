*BASELINE*
Given a hash of companies pointing to number of containers, write a method that will assign companies to ships. No ship can hold more than 100 containers.

```ruby
companies = { "Company A" => 30, "Company B" => 75, "Company C" => 15, "Company D" => 40, "Company E" => 4, "Company F" => 25, "Company G" => 35 }

def assign_companies(companies)
  #(your code here)
end

p assign_companies(companies)
#=> { "Ship 1" => ["Company A", "Company C", "Company D", "Company E"],
    "Ship 2" => ["Company B", "Company F"],
    "Ship 3" => ["Company G"]
```

*EXTENSION*
Pseudocode a strategy for ensuring each ship has as close to 100 containers as possible.
