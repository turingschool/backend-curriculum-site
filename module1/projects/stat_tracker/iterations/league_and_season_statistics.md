---
layout: page
title: League and Season Statistics
---

## League Statistics

These statistics are calculated

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
|`count_of_teams`| Total number of teams in the data. | Integer |
| `best_offense` | Name of the team with the highest average number of goals scored per game across all seasons. | String |
| `worst_offense` | Name of the team with the lowest average number of goals scored per game across all seasons. | String |
| `best_defense` | Name of the team with the lowest average number of goals allowed per game across all seasons. | String |
| `worst_defense` | Name of the team with the highest average number of goals allowed per game across all seasons. | String |
| `highest_scoring_visitor` | Name of the team with the highest average score per game across all seasons when they are home. | String |
| `highest_scoring_home_team` | Name of the team with the highest average score per game across all seasons when they are home. | String |
| `lowest_scoring_visitor` | Name of the team with the lowest average score per game across all seasons when they are a visitor. | String |
| `lowest_scoring_home_team` | Name of the team with the lowest average score per game across all seasons when they are at home. | String |
| `winningest_team` | Name of the team with the highest win percentage across all seasons. | String |
| `best_fans` | Name of the team with biggest difference between home and away win percentages. | String |
| `worst_fans` | List of names of all teams with better away records than home records. | Array |

## Season Statistics

These methods each take a season id as an argument and return the values described below. The last method also takes a second argument representing the team id and the hash returned is specific to that team.

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
| `biggest_bust` | Name of the team with the biggest decrease between preseason and regular season win percentage. | String |
| `biggest_surprise` | Name of the team with the biggest increase between preseason and regular season win percentage. | String |
| `season_summary` | A hash with two keys (`:preseason`, and `:regular_season`) each pointing to a hash with the keys `:win_percentage`, `:goals_scored`, and `:goals_against` | Hash |
