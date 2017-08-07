---
layout: page
---

# ActiveRecord and Database Design

### 1) into-to-ar: Continued Practice (~1-2 hours)

1) Using a migration, add a new table to into-to-ar for jockey. The only attribute of a jockey has a `name`. A horse belongs to a jockey and a jockey can have many horses. Don't forget to add a foreign key of jockey_id to the horses table.

2) Run your migration. Check to see that `schema.rb` was updated properly.

3) From the command line, start Tux:

```
$ tux
```

Tux gives you an interactive console for your app. Go ahead and add some data to your database:

```
james = Jockey.create(name: "James Cameron")
colin = Jockey.create(name: "Colin Trevorrow")
joss = Jockey.create(name: "Joss Whedon")
christopher = Jockey.create(name: "Christopher Nolan")
george = Jockey.create(name: "George Lucas")
lee = Jockey.create(name: "Lee Unkrich")
```

Associate the existing horses in your database with their respective jockey. If you don't know any jockey's (like me), make some up :)

#### Experimenting with Built-in ActiveRecord Methods

What does this do? What table is affected?

```
>> breed = Breed.find(2)
>> breed.horses.create(name: "Age of Ultron", age: 3, total_winnings: 7, jockey_id: 3)
```

What about this?

```
>> jockey = Jockey.first
>> horse = Horse.create(name: "Terminator 2: Judgment Day", age: 2, total_winnings: 6, breed_id: 2)
>> jockey.horses << horse
```

* What's the difference between `Breed.new(name: "Palamino")` and `Breed.create(name: "Clydesdale")`? Play around with Tux and your development environment (use shotgun to see your web interface) to investigate the difference. How does the `save` method play into the relationship between `new` and `create`? What about the `new_record?` method? You may also want to do some Googling.

* What kind of object does `Breed.all` return?
* How can you get a count of all of the Jockeys?
* How do you grab the first Horse? What about the last?
* Can you select all horses where the jockey_id is 3? Try `Horse.where(...` or `Jockey.find(...`
* What's the difference between the query above and `Horse.find_by(jockey_id: 3)`?
* Can you select the breed with a specific id? Try `Breed.find(...`
* What does `Jockey.find_or_create_by(name: "James Cameron")` do? What about `Jockey.find_or_create_by(name: "Stephanie Gibson")`?
* Try calling `.to_sql` on the end of the query `Breed.where(name: "Palamino").to_sql`. What happens?
* What does `Horse.pluck(:name)` do? Can you generate a query to return only the task names?
* Go through the [ActiveRecord docs](http://guides.rubyonrails.org/active_record_querying.html) and find three other methods to try out.

#### Calculations

* Create a route in your controller for `/jockey/:id`. This should prepare an instance variable for the jockey `@jockey = Jockey.find(id)` and render a view with all horses associated with that jockey.
* In this view, display the total winnings for that jockey's horses. Hint: Use the [ActiveRecord Calculations Documentation](http://guides.rubyonrails.org/active_record_querying.html#calculations)
* Display the average winnings for that jockey's horses. Use the documentation linked above.
* I'm not judging, but you probably wrote these calculations right in your view. Can you extract these out to a class method in horse so that you can call something more beautiful like `@jockey.horses.total_winnings`? (Yes, `total_winnins` will be a class method on `Horse`. Any class methods defined in a class that inherits from `ActiveRecord::Base` are also available on associations.)

#### Extension

* Change out the sqlite database for a postgres database.

### 2) HorseFile and CRUD

Add the CRUD functionality for horses. A user should be able to see all the horses, create a new horse, see an individual horse, update a horse, and delete a horse.
