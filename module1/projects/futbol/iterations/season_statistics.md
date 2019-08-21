---
layout: page
title: Season Statistics
---

These methods each take a season id as an argument and return the values described below.

For the purposes of the methods in this section *only* use the goals as recorded in the GameTeams CSV file.

| Method | Description | Return Value |
| ------ | ----------- | ------------ |
| `biggest_bust` | Name of the team with the biggest decrease between regular season and postseason win percentage. | String |
| `biggest_surprise` | Name of the team with the biggest increase between regular season and postseason win percentage. | String |
| `winningest_coach` | Name of the Coach with the best win percentage for the season | String |
| `worst_coach` | Name of the Coach with the worst win percentage for the season | String |
| `most_accurate_team` | Name of the Team with the best ratio of shots to goals for the season | String |
| `least_accurate_team` | Name of the Team with the worst ratio of shots to goals for the season | String |
| `most_hits` | Name of the Team with the most hits in the season | String |
| `fewest_hits` | Name of the Team with the fewest hits in the season | String |
| `power_play_goal_percentage` | Percentage of goals that were power play goals for the season (rounded to the nearest 100th) | Float |
