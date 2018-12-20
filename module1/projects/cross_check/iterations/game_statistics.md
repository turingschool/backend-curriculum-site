---
layout: page
title: Game Statistics
---

_[Back to Cross Check Home](../index)_

Each of the methods described below and in future iterations should be implemented as instance methods on StatTracker.

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
|`highest_total_score`| Highest sum of the winning and losing teams' scores | Integer |
|`lowest_total_score`| Lowest sum of the winning and losing teams' scores | Integer |
|`biggest_blowout`| Highest difference between winner and loser| Integer |
|`most_popular_venue`| Name of the venue with the most total games played | String |
|`least_popular_venue`| Name of the venue with the fewest total games played|  String |
|`percentage_home_wins`| Percentage of games that a home team has won (rounded to the nearest 100th) | Float |
|`percentage_visitor_wins`| Percentage of games that a visitor has won (rounded to the nearest 100th)  |  Float |
|`season_with_most_games`| Integer representation (e.g. 20122013) of the season in which the most games were held | Integer |
|`season_with_fewest_games`| Integer representation (e.g. 20122013) of the season with the fewest games | Integer |
|`count_of_games_by_season`| A hash with season names (e.g. 20122013) as keys and counts of games as values  | Hash |
|`average_goals_per_game`| Average number of goals scored in a game across all seasons (rounded to the nearest 100th)| Float |
|`average_goals_by_season`| Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as a key (rounded to the nearest 100th)| Hash |
