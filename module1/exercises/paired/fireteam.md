---
layout: page
title: Practice Paired Assessment
---

### Iteration 1

Drive the development of the functionality described below.

```ruby
soldier_1 = Soldier.new("Bill Murray", "E-1", "35,000")
#=> <Soldier...>
soldier_1.name
#=> "Bill Murray"
soldier_1.grade
#=> "E-1"
soldier_1.salary
#=> 35000
vehicle_1 = Vehicle.new("MRAP", 18)
#=> <Vehicle...>
vehicle_1.type
#=> "MRAP"
vehicle_1.tonnage
#=> 18
```

### Iteration 2

Writing your own tests to drive development, create a `Crew` class with the functionality described below.

```ruby
soldier_1 = Soldier.new("Bill Murray", "E-1", "35,000")
vehicle_1 = Vehicle.new("MRAP", 18)
crew = Crew.new(soldier_1, vehicle_1)
#=> <Crew...>
crew.soldier
#=> <Soldier...>
crew.vehicle
#=> <Vehicle...>

soldier_2 = Soldier.new("Harold Ramis", "E-2", "36,000")
vehicle_2 = Vehicle.new("JLTV", 7)
crew_2 = Crew.new(soldier_2, vehicle_2)
#=> <Crew...>

fireteam = FireTeam.new("Alpha")
#=> <FireTeam...>
fireteam.name
#=> "Alpha"
fireteam.soldiers
#=> []
fireteam.vehicles
#=> []
```


### Iteration 3

```ruby
soldier_1 = Soldier.new("Bill Murray", "E-1", "35,000")
vehicle_1 = Vehicle.new("MRAP", 18)
crew = Crew.new(soldier_1, vehicle_1)
#=> <Crew...>
crew.soldier
#=> <Soldier...>
crew.vehicle
#=> <Vehicle...>

soldier_2 = Soldier.new("Harold Ramis", "E-2", "36,000")
vehicle_2 = Vehicle.new("JLTV", 7)
crew_2 = Crew.new(soldier_2, vehicle_2)
#=> <Crew...>

fireteam = FireTeam.new("Alpha")
#=> <FireTeam...>
fireteam.name
#=> "Alpha"
fireteam.soldiers
#=> []
fireteam.vehicles
#=> []

fireteam.add_crew(crew_1)
fireteam.add_crew(crew_2)

fireteam.soldiers
#=> [<Soldier...>, <Soldier...>]

fireteam.vehicles
#=> [<Vehicle...>, <Vehicle...>]

fireteam.average_salary
#=> 35500
```
