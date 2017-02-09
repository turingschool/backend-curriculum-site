# Factory Girl
## An Introduction

---

# Goals

* Overview of Factory Girl
* Write code based on existing code
* Use docs to write new code

---

# Warmup

Visit the link in the lesson plan:

`https://github.com/s-espinosa/bike-share/blob/testing_sample/spec/models/example_spec.rb`

* Describe what's happening in the setup in non-technical language.

---

# Is there a better way?

* *Factory Girl:* create instances without a fuss
    * set default parameters
    * override those parameters
    * create multiples

---

# Syntax to Use

```ruby
station         = create(:station)
invalid_station = create(:station, city_id: nil)
three_stations  = create_list(:station, 3)
```

---

# In a Spec

* Clone the project at https://github.com/s-espinosa/guaranty_bank_500
* `rake db:create db:migrate`
* `bundle`
* Open the `car_spec.rb`, and `car_fg_spec.rb`
* What do you notice?

---

# Practice Together

* Open the `/spec/factories.rb` file.
* What do you notice?
* Open the `/spec/models/race_spec.rb` file.

## With a Partner
* Given the code in the `/spec/factories.rb file`, how might we create a `:race` factory to make the tests for a Race pass?

---

# Car Factory

* With a Partner: Create an `owner_with_cars` Factory
    * Creates an owner with 3 cars by default
    * Use this factory to make remaining skipped tests pass
* Documentation at `http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md`

---

# Share (10 minutes)

---

# Additional Time

* Implement a `#max_car_speed` method on driver that finds the maximum speed of all of the cars they drive.
* Test this using Factory Girl by creating a `:driver_with_cars` Factory

