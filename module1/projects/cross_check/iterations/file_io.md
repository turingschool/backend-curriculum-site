---
layout: page
title: File I/O and Setup
---

_[Back to Cross Check Home](../index)_

## Setup

We have provided a starting repository for this project. That repository has the usual `lib` and `test` directories that you have seen in the past, but also includes a `data` directory that includes three `.csv` files. These files are text files that include tables represented as comma separated values (hence `.csv`). The first row includes headers, while every other row includes entries in the table.

Begin by picking one team member to fork the project repository [here](https://github.com/turingschool-examples/cross_check).
Once one of you has forked the repository, each of the other team members should clone that repository.

In order to complete your setup:

* One team member forks the repository [here](https://github.com/turingschool-examples/cross_check) and adds the other(s) as collaborators.
* Each of the other team members accepts the invitation to collaborate and then clones the repository.
* Setup [SimpleCov](https://github.com/colszowka/simplecov) to monitor test coverage along the way.
* Create a [Rakefile](https://github.com/ruby/rake) that will run each of your test files without having to run them individually. See [this lesson plan](http://backend.turing.edu/module1/lessons/project_etiquette) for more details.

Note: we have linked the GitHub repositories for SimpleCov and Rake above, but you should not expect that those are the only resources you will use to set up these tools in your project. Use your research skills to find other resources to help you determine how to use these tools. You may want to consider using [Rubys CSV class](https://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html).

## File I/O

In order to get data into the system we're going to create, we're going to read information from CSV files. At this point, we don't expect that you have determined exactly what you will be doing with the information that you collect, so for now you may just want to print some information to the terminal about each record you read in.

At a high level, if you create a runner file including the code below, you should drop into a pry session with an instance of StatTracker held in the `stat_tracker` variable.

Note that `from_csv` is a method you have defined called directly on the StatTracker class, and not an instance of StatTracker.

`::from_csv` returns an instance of StatTracker. That instance of StatTracker will hold all of the information you need for the methods included in the remainder of the project description.

```ruby
# runner.rb
require './lib/stat_tracker'

game_path = './data/game.csv'
team_path = './data/team_info.csv'
game_teams_path = './data/game_teams_stats.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry
```
