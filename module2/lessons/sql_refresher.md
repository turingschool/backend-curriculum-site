---
title: SQL Refresher
---

## Learning Goals

* Review SQL concepts from intermission work
* Practice writing SQL queries in a familiar database

## Slides

Available [here](../slides/sql_refresher)


## Warmup

* How do you determine which columns will be returned from a SQL query?
* What else do you remember from your SQL prework?

## Lesson

### Setup

Enter `psql` from your terminal. This should drop you into an interactive postgres session where you can run SQL commends from the terminal.

Note: if you get an error about no user existing, check [this](https://stackoverflow.com/questions/17633422/psql-fatal-database-user-does-not-exist) Stack Overflow post.

The first thing you will see is a helpful note to enter `help` if you need some more information about how to use this interactive session. `\?` will provide you with some terminal specific commands, while `\h` will provide you with a list of SQL commands that offer additional documentation.

In order to interact with our BikeShare database, we'll first need to connect to it. How do we know it exists or what it's named? First type `\list`. This will provide you with a list of databases avaialble to you.

In order to connect to our database, type `\c bike-share-development` (or whatever `\list` tells you your database is called). Now you should be able to run SQL commands.

When you're ready to disconnect type `\q`

### Practice

With a partner, see if you can complete each of the tasks below. After each section we will check in as a group.

#### SELECT FROM LIMIT

* All of the information on the `stations` table.
* Max, min, and mean temp from the `conditions` table.
* `id`, `start_station_id`, and `duration` of five trips.

#### WHERE

* Trips that started at the station with an id of 2.
* Stations that have a `dock_count` of 15.
* id, date, and precipitation for conditions with more than 1 inch of precipitation.

#### max/min/count/average

* Duration of the longest trip.
* Duration of the shortest trip.
* Average `dock_count` at a station.
* Highest `dock_count` at a station.
* Count of days with no rain.
* Name/`dock_count` of the station with the most docks.
* Id, start station id, and duration of the longest trip.
* Id, start station id, and duration of the shortest trips.

#### JOIN

* Name of the station where the longest trip started.
* Name of the stations where the shortest trips started.

#### GROUP

* Count of trips started at each station.
* Count of trips ended at each station.
* Count of trips started on days with more than an inch of precipitation.

#### ORDER

* Top five stations with the most trips started.
* Top five stations with the most trips ended.
* Least popular start station.
* `mean_temperature` and `precipiation` on the five dates with the most trips.

## Additional Resources

1. [Fundamental SQL](http://tutorials.jumpstartlab.com/topics/sql/fundamental_sql.html) (review from intermission work)
1. [SQL by repetition](http://sql-by-repetition.herokuapp.com/)
1. [Intermediate SQL](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/intermediate_sql.md)

