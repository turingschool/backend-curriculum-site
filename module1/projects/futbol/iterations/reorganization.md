---
layout: page
title: Reoranization and More Statistics!
---

_[Back to Futbol Home](../index)_

## Reorganization

Now that we have some statistics methods done, its time to do some refactoring!  There are a few things to consider when deciding what methods and classes can be refactored and reorganized:

* Classes should be compact - no longer than 150 lines!
* Classes should have a single responsibility - you should be able to describe what a class is responsible for in one sentence.
* Use the tools we have learned recently when thinking about reorganization - Modules, Inheritance, and Plain Old Ruby Objects (POROs).

As you refactor, you must maintain the integrity of your existing tests by adding tests for any new methods as you go.  **Every** method should have at least one test!

As a **deliverable** for your refactoring and reorganization, include a README in your GitHub repo that describes your design strategy.  This could be a narrative description of your design, or a graphic representation.

## Additional Statistics

Each of the methods described below and should be implemented as instance methods on `StatTracker`.

### Game Statistics

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
|`average_goals_per_game`| Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)| Float |
|`average_goals_by_season`| Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as a key (rounded to the nearest 100th)| Hash |


### League Statistics

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
| `highest_scoring_visitor` | Name of the team with the highest average score per game across all seasons when they are away. | String |
| `highest_scoring_home_team` | Name of the team with the highest average score per game across all seasons when they are home. | String |
| `lowest_scoring_visitor` | Name of the team with the lowest average score per game across all seasons when they are a visitor. | String |
| `lowest_scoring_home_team` | Name of the team with the lowest average score per game across all seasons when they are at home. | String |

### Season Statistics

These methods each take a season id as an argument and return the values described below.

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
| `most_tackles` | Name of the Team with the most tackles in the season | String |
| `fewest_tackles` | Name of the Team with the fewest tackles in the season | String |


### Team Statistics

Each of the methods below take a team id as an argument. Using that team id, your instance of StatTracker will provide statistics for a specific team.

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
| `favorite_opponent` | Name of the opponent that has the lowest win percentage against the given team. | String |
| `rival` | Name of the opponent that has the highest win percentage against the given team. | String |
