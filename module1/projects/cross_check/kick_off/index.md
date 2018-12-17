# Cross-Check

---

# Overview

* Create a StatTracker class that analyzes NHL data from previous seasons.
* Three `.csv` files of NHL data pulled from [Kaggle](https://www.kaggle.com/martinellis/nhl-game-data).
* Open ended - up to you to determine classes and organize the project.

---

# Learning Goals

* Build classes with single responsibilities.
* Write organized readable code.
* Use TDD as a design strategy
* Design an Object Oriented Solution to a problem
* Practice algorithmic thinking
* Work in a group
* Use Pull Requests to collaborate among multiple partners

---

# Sample Methods

* `most_popular_venue`: Name of the venue with the most total games played.
* `best_fans`: Name of the team with biggest difference between home and away win percentages.
* `biggest_bust`: Name of the team with the biggest decrease between preseason and regular season win percentage.

---

# Files

* `game.csv`
* `team_info.csv`
* `game_teams_stats.csv`

---

# Team Info

* "team_id"
* "franchiseId"
* "shortName"
* "teamName"
* "abbreviation"
* "link"

---

# Game Teams Stats

* "game_id"
* "team_id"
* "HoA"
* "won"
* "goals"

---

# Game

* "game_id"
* "season"
* "type"
* "away_team_id"
* "home_team_id"
* "away_goals"
* "home_goals"
* "outcome"
* "venue"

---

# Method Names and Return Values

* Use the names provided.
* Return the data types specified.

---

# Testing

* Do not use the full CSVs to test these classes.
