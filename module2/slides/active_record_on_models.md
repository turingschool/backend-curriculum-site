# AR on Models

---

# Warmup

Assume I have a Horse model and that Horses belong to Owners.

* How do I access the age of a particular horse?
* How do I access the owner of a particular horse?
* How do I generate an array of all horse names?
* How do I determine the average horse age?

---

# Methods on AR Models

* Can access attributes of instances using **method calls**.
* Can access related instances (e.g. `owner`) using **method calls**.

---

# Example Accessing Attributes

```ruby
def years_until_30
  30 - age
end
```

---

# Example Accessing Related Instances

```ruby
def owner_name
  owner.name
end
```

---

# Class Methods

* Can access all instances of a class.
* Can also be called on a subset of instances of a class.

---

# Writing a Class Method

```ruby
# Horse.rb
def self.names
  pluck(:name)
end
```

---

# Utilizing Class Method: All Instances

```
# Horses Index View (All Horses)
@horses.names
```

---

# Utilizing Class Method: Subset

```
# Owner Model (Horses Belonging to an Owner)
def horse_names
  horses.names
end
```

---

# Clone Election

* See lesson plan.
* Make Tests Pass

