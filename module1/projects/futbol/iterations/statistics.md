---
layout: page
title: Statistics
---

_[Back to Futbol Home](../index)_

Each of the methods described below and in future iterations should be implemented as instance methods on `StatTracker`.

### Game Statistics

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
|`highest_total_score`| Highest sum of the winning and losing teams' scores | Integer |
|`lowest_total_score`| Lowest sum of the winning and losing teams' scores | Integer |
|`percentage_home_wins`| Percentage of games that a home team has won (rounded to the nearest 100th) | Float |
|`percentage_visitor_wins`| Percentage of games that a visitor has won (rounded to the nearest 100th)  |  Float |
|`percentage_ties`| Percentage of games that has resulted in a tie (rounded to the nearest 100th)  |  Float |
|`count_of_games_by_season`| A hash with season names (e.g. 20122013) as keys and counts of games as values  | Hash |


### League Statistics

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
|`count_of_teams`| Total number of teams in the data. | Integer |
| `best_offense` | Name of the team with the highest average number of goals scored per game across all seasons. | String |
| `worst_offense` | Name of the team with the lowest average number of goals scored per game across all seasons. | String |

### Season Statistics

These methods each take a season id as an argument and return the values described below.

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
| `winningest_coach` | Name of the Coach with the best win percentage for the season | String |
| `worst_coach` | Name of the Coach with the worst win percentage for the season | String |
| `most_accurate_team` | Name of the Team with the best ratio of shots to goals for the season | String |
| `least_accurate_team` | Name of the Team with the worst ratio of shots to goals for the season | String |


### Team Statistics

Each of the methods below take a team id as an argument. Using that team id, your instance of StatTracker will provide statistics for a specific team.

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
| `team_info` | A hash with key/value pairs for the following attributes: team_id, franchise_id, team_name, abbreviation, and link | Hash |
| `best_season` | Season with the highest win percentage for a team. | String |
| `worst_season` | Season with the lowest win percentage for a team. | String |
| `average_win_percentage` | Average win percentage of all games for a team. | Float |
| `most_goals_scored` | Highest number of goals a particular team has scored in a single game. | Integer |
| `fewest_goals_scored` | Lowest numer of goals a particular team has scored in a single game. | Integer |
