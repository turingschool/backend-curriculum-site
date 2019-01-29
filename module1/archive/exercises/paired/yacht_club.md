---
layout: page
title: Practice Paired Assessment
---

Clone this repo: git@github.com:turingschool-examples/yacht_club.git

## Iteration 1 (tests provided)

```ruby
yacht = Yacht.new("S.S. Minnow", 40)
# => <#Yacht...>
yacht.name
# => "S.S. Minnow"
yacht.length
# => 40
yacht.sailing?
# => false
yacht.sail
# => "Aye, aye!"
yacht.sailing?
# => true
```

## Iteration 2

```ruby
yacht_1 = Yacht.new("S.S. Minnow", 40)
# => <#Yacht...>
yacht_2 = Yacht.new("Vajoliroja", 200)
# => <#Yacht...>
captain = Captain.new("Thurston", "Howell", "10_000_000")
# => <#Captain...>
captain.full_name
# => "Thurston Howell"
captain.net_worth
# => 10000000
captain.yachts
# => []
captain.add_yacht(yacht_1)
# => <#Yacht...>
captain.yachts
# => [<#Yacht...>]
captain.add_yacht(yacht_2)
# => [<#Yacht...>, <#Yacht...>]
```

## Iteration 3

```ruby
yacht_club = YachtClub.new("Mike's Yacht Club")
# => <#YachtClub...>
captain = Captain.new("Thurston", "Howell", "10_000_000")
# => <#Captain...>
yacht_1 = Yacht.new("S.S. Minnow", 40)
# => <#Yacht...>
captain.add_yacht(yacht_1)
# => <#Yacht...>


yacht_club.add_member(captain)
# => "Thurston Howell added!"
yacht_club.members
# => ["Howell"]
```

## Iteration 4


```ruby
yacht_club = YachtClub.new("Mike's Yacht Club")
# => <#YachtClub...>

captain_1 = Captain.new("Thurston", "Howell", "10_000_000")
# => <#Captain...>
yacht_1 = Yacht.new("S.S. Minnow", 40)
# => <#Yacht...>
captain.add_yacht(yacht_1)
# => <#Yacht...>

captain_2 = Captain.new("Kathryn", "Janeway", "100_000_000" )
# => <#Captain...>
yacht_2 = Yacht.new("Voyager", 500)
# => <#Yacht...>
captain_2.add_yacht(yacht_2)
# => <#Yacht...>

yacht_club.add_member(captain_1)
# => "Thurston Howell added!"

yacht_club.add_member(captain_2)
# => "Kathryn Janeway added!"

yacht_club.ship_log
# => {"S.S. Minnow" => "Thurston Howell", "Voyager" => "Kathryn Janeway"}
```

