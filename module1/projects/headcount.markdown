---
layout: page
title: HeadCount
---

Federal and state governments publish a huge amount of data. You can find
a large collection of it on [Data.gov](http://data.gov) -- everything from land surveys
to pollution to census data.

As programmers, we can use those data sets to ask and answer questions. We'll build upon a dataset centered around schools in Colorado provided by the Annie E. Casey foundation. What can we learn about education across the state?

Starting with the CSV data we will:

* build a "Data Access Layer" which allows us to query/search the underlying data
* build a "Relationships Layer" which creates connections between related data
* build an "Analysis Layer" which uses the data and relationships to draw conclusions

## Project Overview

The learning goals covered by this project will become foundational understanding throughout upcoming modules at Turing.

Most importantly, this project guides you through building from scratch an Object Relational Mapping tool (ORM) to communicate with and manipulate the data stored in various CSV files. These CSV files imitate a database. Thusly, this way of understanding and working with data will carry on through your learning of web applications.

### Learning Goals

* Use tests to drive both the design and implementation of code
* Decompose a large application into components such as parsers, repositories, and analysis tools
* Use test fixtures instead of actual data when testing
* Connect related objects together through references
* Learn an agile approach to building software

### Getting Started

1. One team member forks the repository at https://github.com/turingschool-examples/headcount and adds the other(s) as collaborators.
2. Everyone on the team clones the repository
3. Setup [SimpleCov](https://github.com/colszowka/simplecov) to monitor test coverage along the way

## Key Concepts

### Districts

During this project, we'll be working with a large body of data
that covers various information about Colorado school districts.

The data is divided into multiple CSV files, with the concept of
a __District__ being the unifying piece of information across the
various data files.

__Districts__ are identified by simple names (strings), and are listed
under the `Location` column in each file.

So, for example, the file `Kindergartners in full-day program.csv` contains
data about Kindergarten enrollment rates over time. Let's look at the file headers
along with a sample row:

```
Location,TimeFrame,DataFormat,Data
AGUILAR REORGANIZED 6,2007,Percent,1
```

The `Location`, column indicates the District (`AGUILAR REORGANIZED 6`), which
will re-appear as a District in other data files as well. The other columns
indicate various information about the statistic being reported. Note that
percentages appear as decimal values out of `1`, with `1` meaning 100% enrollment.

### Aggregate Data Categories

With the idea of a __District__ sitting at the top of our overall data hierarchy
(it's the thing around which all the other information is organized), we can now
look at the secondary layers.

We will ultimately be performing analysis across numerous data files within the
project, but it turns out that there are generally multiple files dealing with
a related concepts. The overarching data themes we'll be working with include:

* __Enrollment__ - Information about enrollment rates across various
grade levels in each district
* __Statewide Testing__ - Information about test results in each district
broken down by grade level, race, and ethnicity
* __Economic Profile__ - Information about socioeconomic profiles of
students and within districts

### Data Files by Category

The list of files that are relevant to each data "category" are listed below. You'll find the data files in the `data` folder of the cloned repository.

#### Enrollment

* `Dropout rates by race and ethnicity.csv`
* `High school graduation rates.csv`
* `Kindergartners in full-day program.csv`
* `Online pupil enrollment.csv`
* `Pupil enrollment by race_ethnicity.csv`
* `Pupil enrollment.csv`
* `Special education.csv`

#### Statewide Testing

* `3rd grade students scoring proficient or above on the` CSAP_TCAP.csv
* `8th grade students scoring proficient or above on the` CSAP_TCAP.csv
* `Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv`
* `Average proficiency on the CSAP_TCAP by race_ethnicity_` Reading.csv
* `Average proficiency on the CSAP_TCAP by race_ethnicity_` Writing.csv
* `Remediation in higher education.csv`

#### Economic Profile

* `Median household income.csv`
* `School-aged children in poverty.csv`
* `Students qualifying for free or reduced price lunch.csv`
* `Title I students.csv`

Ultimately, a crude visualization of the structure might look like this:

```
- District: Gives access to all the data relating to a single, named school district
|-- Enrollment: Gives access to enrollment data within that district, including:
|  | -- Dropout rate information
|  | -- Kindergarten enrollment rates
|  | -- Online enrollment rates
|  | -- Overall enrollment rates
|  | -- Enrollment rates by race and ethnicity
|  | -- High school graduation rates by race and ethnicity
|  | -- Special education enrollment rates
|-- Statewide Testing: Gives access to testing data within the district, including:
|  | -- 3rd grade standardized test results
|  | -- 8th grade standardized test results
|  | -- Subject-specific test results by race and ethnicity
|  | -- Higher education remediation rates
|-- Economic Profile: Gives access to economic information within the district, including:
|  | -- Median household income
|  | -- Rates of school-aged children living below the poverty line
|  | -- Rates of students qualifying for free or reduced price programs
|  | -- Rates of students qualifying for Title I assistance
```

## Project Iterations and Base Expectations

Because the requirements for this project are lengthy and complex, we've broken
them into Iterations in their own files:

* [Iteration 0](http://backend.turing.edu/module1/projects/headcount_iterations/iteration_0) - District Kindergarten Data Access
* [Iteration 1](http://backend.turing.edu/module1/projects/headcount_iterations/iteration_1) - District Kindergarten Relationships & Analysis
* [Iteration 2](http://backend.turing.edu/module1/projects/headcount_iterations/iteration_2) - Remaining Enrollment Access & Analysis: High School Graduation
* [Iteration 3](http://backend.turing.edu/module1/projects/headcount_iterations/iteration_3) - Data Access & Relationships: Statewide Testing
* [Iteration 4](http://backend.turing.edu/module1/projects/headcount_iterations/iteration_4) - Data Access & Relationships: Economic Profile
* [Iteration 5](http://backend.turing.edu/module1/projects/headcount_iterations/iteration_5) - Analysis: Statewide Testing
* [Iteration 6](http://backend.turing.edu/module1/projects/headcount_iterations/iteration_6) - Analysis: Economic Profile
* Iteration 7 - Total Enrollment (coming soon)
* Iteration 8 - Special Education, Remediation, and Dropout Rates (coming soon)

## Test Harness
The test harness for Headcount is [here](https://github.com/turingschool-examples/headcount_test_harness).

## Evaluation Rubric

The project will be assessed with the following guidelines:

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

**Expectations:**

### 1. Ruby Syntax & Style

* Applies appropriate attribute encapsulation  
* Developer creates instance and local variables appropriately
* Naming follows convention (is idiomatic)
* Ruby methods used are logical and readable  
* Developer implements best-choice enumerable methods
* Code is indented properly
* Code does not exceed 80 characters per line
* A directory/file structure provides basic organization via lib/ and/or /test

### 2. Breaking Logic into Components

* Code is effectively broken into methods & classes
* Developer writes methods less than 6 lines
* No more than 3 methods break the principle of SRP

### 3. Test-Driven Development

* Each method is tested  
* Functionality is accurately covered
* Tests implement Ruby syntax & style   
* Balances unit and integration tests
* Evidence of edge cases testing
* Test Coverage metrics are present (SimpleCov)
* A test RakeTask is implemented

### 4. Functionality

* Application meets all requirements (all relevant tests pass the spec harness)

### 5. Version Control

* Developer commits at a pace of at least 1 commit per hour
* Developer implements branching and PRs
* The final submitted version is merged into master

### 6. Code Sanitation

* The output from `rake sanitation:all` shows five or fewer complaints

<!--
## Appendix - Data Sources

The original data files and more information about the data can be found here:

* [Search Index](http://datacenter.kidscount.org/data#CO/10/0)
* [Median Household Income](http://datacenter.kidscount.org/data/tables/6228-median-household-income?loc=7&loct=10#detailed/10/1278-1457/false/1376,1201,1074,880,815/any/12960)
* [School Aged Children in Poverty](http://datacenter.kidscount.org/data/tables/435-school-aged-children-in-poverty?loc=7&loct=10#detailed/10/1278-1457/false/36,868,867,133,38/any/11775,1084)
* [Pupil Enrollment](http://datacenter.kidscount.org/data/tables/5678-pupil-enrollment?loc=7&loct=10#detailed/10/1278-1457/false/869,36,868,867,133/any/12280)
* [Special Education](http://datacenter.kidscount.org/data/tables/5314-special-education?loc=7&loct=10#detailed/10/1278-1457/false/869,36,868,867,133/any/14675,11828)
* [Title 1 Students](http://datacenter.kidscount.org/data/tables/5325-title-i-students?loc=7&loct=10#detailed/10/1278-1457/false/869,36,868,867,38/any/11841)
* [Students Qualifying for Free and Reduced Price Lunch](http://datacenter.kidscount.org/data/tables/469-students-qualifying-for-free-or-reduced-price-lunch?loc=7&loct=10#detailed/10/1278-1457/false/869,36,868,867,133/109,110,111/11515,7665)
* [Kindergarteners in Full-Day Program](http://datacenter.kidscount.org/data/tables/449-kindergartners-in-full-day-program?loc=7&loct=10#detailed/10/1278-1457/false/869,36,868,867,133/any/11012)
* [High School Graduation Rates](http://datacenter.kidscount.org/data/tables/6134-high-school-graduation-rates?loc=7&loct=10#detailed/10/1278-1457/false/869,36,868,867,133/any/12806)
* [Dropout Rates by Race and Ethnicity](http://datacenter.kidscount.org/data/tables/7296-dropout-rates-by-race-and-ethnicity?loc=7&loct=10#detailed/10/1278-1457/false/868,867/785,786,787,788,789,790,791,792,3494,2302/14353)
* [Online Pupil Enrollment](http://datacenter.kidscount.org/data/tables/7141-online-pupil-enrollment?loc=7&loct=10#detailed/10/1278-1457/false/36,868,867/any/14171)
* [Remediation in Higher Education](http://datacenter.kidscount.org/data/tables/7663-remediation-in-higher-education?loc=7&loct=10#detailed/10/1278-1457/false/867,133,38/any/14818)
* [3rd Grade Students Scoring Proficient or Above on the CSAP/TCAP](http://datacenter.kidscount.org/data/tables/5651-3rd-grade-students-scoring-proficient-or-above-on-the-csap-tcap?loc=7&loct=10#detailed/10/1278-1457/false/869,36,868,867,133/129,130,145/12252)
* [8th Grade Students Scoring Proficient or Above on the CSAP/TCAP](http://datacenter.kidscount.org/data/tables/5657-8th-grade-students-scoring-proficient-or-above-on-the-csap-tcap?loc=7&loct=10#detailed/10/1278-1457/false/869,36,868,867,133/129,130,145/12262)
* [Pupil Enrollment by Race & Ethnicity](http://datacenter.kidscount.org/data/tables/3736-pupil-enrollment-by-race-ethnicity?loc=7&loct=10#detailed/10/1278-1457/false/869,36,868,867,133/84,87,86,85,88,1849,185,13/11661,7630)
* [AVERAGE PROFICIENCY ON THE CSAP/TCAP BY RACE/ETHNICITY: READING](http://datacenter.kidscount.org/data/tables/6727-average-proficiency-on-the-csap-tcap-by-race-ethnicity-reading?loc=7&loct=10#detailed/10/1278-1457/false/869,36,868,867/2756,2161,2159,2819,2157,2158,2820,2160/13821)
* [AVERAGE PROFICIENCY ON THE CSAP/TCAP BY RACE/ETHNICITY: MATH](http://datacenter.kidscount.org/data/tables/6567-average-proficiency-on-the-csap-tcap-by-race-ethnicity-math?loc=7&loct=10#detailed/10/1278-1457/false/869,36,868,867/2756,2161,2159,2819,2157,2158,2820,2160/13563)
* [AVERAGE PROFICIENCY ON THE CSAP/TCAP BY RACE/ETHNICITY: WRITING](http://datacenter.kidscount.org/data/tables/6729-average-proficiency-on-the-csap-tcap-by-race-ethnicity-writing?loc=7&loct=10#detailed/10/1278-1457/false/869,36,868,867/2756,2161,2159,2819,2157,2158,2820,2160/13823) -->
