### State Capitals

You have 2 hashes, one which maps state names to state abbreviations,
and one which maps state abbreviations to their capital:

```
states = {"Oregon" => "OR",
          "Alabama" => "AL",
          "New Jersey" => "NJ",
          "Colorado" => "CO"}

capitals = {"OR" => "Salem",
            "AL" => "Montgomery",
            "NJ" => "Trenton",
            "CO" => "Denver"}
```

* Level 1: Write some code which given a state name ("Oregon") outputs
  its capital ("Salem")
* Level 2: Handle the case when a state's information is not known by
  returning "Unknown"
* Level 3: Now let's go the other way. Given a capital name ("Denver"),
  return the state name for which it is the capital ("Colorado")
