---
layout: page
title: Solo Project
length: 2 weeks
tags:
type: project
---

## Project Description

The goal of this project is to build a backend that will eventually be consumed by a separate front end application. The backend must consume at least one third party API. The custom built API will use the data returned from the third party API and add additional functionality or value.

The project requirements are listed below:

* [Learning Goals](#learning-goals)
* [Technical Expectations](#technical-expectations)
* [Project Concepts](#project-concepts)
* [Check-ins](#check-ins-and-milestones)
* [Evaluation](#evaluation)

## <a name="learning-goals"></a> Learning Goals

* Demonstrate mastery of building an API using Rails
* Demonstrate mastery of consuming a third party API
* Find the strengths and gaps in your knowledge of Ruby, Rails, and organizing
a project.

## <a name="technical-expectations"> Technical Expectations

Every project will be a bit different, but they need to share some
common technical characteristics:

* Build an authenticated API in Rails
* Consume a third party API

### Project Scope

A good project idea should:

* Have wireframes with a hierarchy of the most important features
* Ideally has one page with the bulk of functionality
* Has several API endpoints
* Break down into logical iterations
* Have enough *technical* challenge to be worth your time (as opposed to a *content* challenge)

Use this [project spec](./sweater_weather) for inspiration. Students may choose to build this project instead of coming up with their own idea.

### APIs

Your application **must make good use of one external dataset or API**. Some examples include:

#### Government Data

* [Data.gov](https://www.data.gov/)
* [ProPublica](http://www.propublica.org/tools/)
* [NASA](http://data.nasa.gov/api-info/)
* [US Census](http://www.census.gov/data/developers/data-sets.html)
* [Socrata Listings](https://opendata.socrata.com/dataset/Socrata-Customer-Spotlights/6wk3-4ija)
* [Bureau of Labor & Statistics](http://www.bls.gov/developers/api_ruby.htm)
* [United Nations](https://www.undata-api.org/) (3rd party API)
* [Google's Directory of Public Data](http://www.google.com/publicdata/directory)
* [OpenColorado](http://data.opencolorado.org/)
* [Denver Regional Council of Governments](https://drcog.org/services-and-resources/data-maps-and-modeling)

#### Corporate Data

* [Twitter](https://dev.twitter.com)
* [Facebook](https://developers.facebook.com)
* [Instagram](https://instagram.com/developer)
* [Github](https://developer.github.com/v3)
* [FitBit](https://dev.fitbit.com)
* [Spotify](https://developer.spotify.com/web-api)
* [Strava](https://www.strava.com/developers)
* [Google Maps](https://developers.google.com/maps)

However, the list is not limited to these. You can choose to integrate with a service of your choosing, as long as it is approved by your client.

## <a name="project-concepts"></a>Project Concepts

Your idea must be approved by an instructor and should be supplied in a gist using the following template...

### Project Template

```markdown
### [Project Title]

### Pitch

1 sentence that explains the value proposition of the application. How would you explain it to a potential business partner, team member, or investor?

### Problem

1-3 sentences describing the problem that you are trying to solve.

### Solution

1-3 sentences describing how your application will solve that problem.

### Target Audience

1-3 sentences describing what type of user your app would be applicable to.

### Integrations

* Which APIs will you use?
```

### Setup

* Create a Github Projects board and invite your PM as a contributor.
* Before you begin to implement code, write up 5-10 stories on your board. These stories must be written in present tense.
* Once step two is complete, send your tracker board over to your PM.

### "Standup" and Checkins

## <a name="evaluation"></a> Evaluation

### Feature Delivery

* **1:** Project fell well short of agreed upon expectations.
* **2:** Project completed most user stories set out but fell short of agreed upon expectations.
* **3:** Project completed all the user stories and requirements agreed upon.
* **4:** Project well exceeded expectations.

### Technical Quality

* **1:**  Project has significant gaps in understanding of MVC with several examples of logic or hashes in the view/presentation layer (e.g. serializers), controllers remain un-refactored, and models are used for formatting.
* **2:**  MVC is overall good but might has 1 or 2 examples of logic or hashes in the view/presentation layer (e.g. serializers), formatting in models, or controllers with complex logic.
* **3:**  Project uses abstraction in ways that make it easy to change (example: if an API changes, Propublica to Google Civic, we make changes in as few places as possible. Or POROs can be used in custom API or in standard views). Project shows a solid understanding of MVC principles (this may include but is not limited to: no logic in view/presentation layer (e.g. serializers), clean controllers, serializers and presenters to handle formatting rather than models etc.) and includes all expectations of numbers 1 and 2 above.
* **4:**  Project meets expectations from number 3 above and takes on at least one new technology outside the required scope. Examples include: background workers, caching in Redis, GraphQL, etc.

### Testing

* **1:** Test suite coverage is low (less than 80%).
* **2:** Test suite coverage is greater than 80% but misses the most meaningful functionality and I would not be happy paying for/inheriting it.
* **3:** Project demonstrates high value testing at different layers (above 90%). If I were inheriting or paying someone to build this app I would be happy with the coverage.
* **4:** Project demonstrates exceptional testing using advanced techniques such as spies. Meets expectations of point 3 above.
