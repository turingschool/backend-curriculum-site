---
layout: page
title: Setup, File I/O, and Statistics
---

_[Back to Futbol Home](../index)_

## Setup

We have provided a starting repository for this project. That repository has the usual `lib` and `spec` directories that you have seen in the past, but also includes a `data` directory that includes three `.csv` files. These files are text files that include tables represented as comma-separated values (hence `.csv`). The first row includes headers, while every other row includes entries in the table.

Begin by picking one team member to fork the project repository [here](https://github.com/turingschool-examples/futbol).
Once one of you has forked the repository, each of the other team members should clone that repository.

In order to complete your setup:

* One team member forks the repository [here](https://github.com/turingschool-examples/futbol) and adds the other(s) as collaborators.
* Each of the other team members accepts the invitation to collaborate and then clones the repository.
* Setup [SimpleCov](https://github.com/colszowka/simplecov) to monitor test coverage along the way.

Note: we have linked the GitHub repository for SimpleCov, but you should not expect that those are the only resources you will use to set up these tools in your project. Use your research skills to find other resources to help you determine how to use these tools. You may want to consider using [Rubys CSV class](https://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html).

## File I/O

In order to get data into the system we're going to create, we're going to read information from CSV files. At this point, we don't expect that you have determined exactly what you will be doing with the information that you collect, so for now you may just want to print some information to the terminal about each record you read in.

At a high level, if you create a runner file including the code below, you should drop into a pry session with an instance of `StatTracker` held in the `stat_tracker` variable.

Note that `::from_csv` is a method you have defined called directly on the `StatTracker` class, and not an instance of `StatTracker`.

`::from_csv` returns an instance of StatTracker. That instance of `StatTracker` will hold all of the information you need for the methods included in the remainder of the project description.

```ruby
# runner.rb
require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry
```

## Statistics

Each of the methods described below should be implemented as instance methods on `StatTracker` in order for the spec harness to work properly.

### Game Statistics

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
|`highest_total_score`| Highest sum of the winning and losing teams' scores | Integer |
|`lowest_total_score`| Lowest sum of the winning and losing teams' scores | Integer |
|`percentage_home_wins`| Percentage of games that a home team has won (rounded to the nearest 100th) | Float |
|`percentage_visitor_wins`| Percentage of games that a visitor has won (rounded to the nearest 100th)  |  Float |
|`percentage_ties`| Percentage of games that has resulted in a tie (rounded to the nearest 100th)  |  Float |
|`count_of_games_by_season`| A hash with season names (e.g. 20122013) as keys and counts of games as values  | Hash |
|`average_goals_per_game`| Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)| Float |
|`average_goals_by_season`| Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)| Hash |


### League Statistics

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
|`count_of_teams`| Total number of teams in the data. | Integer |
| `best_offense` | Name of the team with the highest average number of goals scored per game across all seasons. | String |
| `worst_offense` | Name of the team with the lowest average number of goals scored per game across all seasons. | String |
| `highest_scoring_visitor` | Name of the team with the highest average score per game across all seasons when they are away. | String |
| `highest_scoring_home_team` | Name of the team with the highest average score per game across all seasons when they are home. | String |
| `lowest_scoring_visitor` | Name of the team with the lowest average score per game across all seasons when they are a visitor. | String |
| `lowest_scoring_home_team` | Name of the team with the lowest average score per game across all seasons when they are at home. | String |

### Season Statistics

These methods each take a season id as an argument and return the values described below.

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
| `winningest_coach` | Name of the Coach with the best win percentage for the season | String |
| `worst_coach` | Name of the Coach with the worst win percentage for the season | String |
| `most_accurate_team` | Name of the Team with the best ratio of shots to goals for the season | String |
| `least_accurate_team` | Name of the Team with the worst ratio of shots to goals for the season | String |
| `most_tackles` | Name of the Team with the most tackles in the season | String |
| `fewest_tackles` | Name of the Team with the fewest tackles in the season | String |
