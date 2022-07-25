---
layout: page
title: Consultancy - Ideation
type: project
---

## Timeline

* End of Week 2: Students begin brainstorming project ideas individually using the following guidelines.
* Week 3: Students share their project ideas and vote on which projects they would like to work on.
* End of Week 3: Students choose their preference among the most popular projects

### Project Template

Fill out the following template for your project idea.

```markdown
### [Project Name]

### Pitch

2 - 3 sentences that explains what the application will do.

### End User

* Who is this app target towards? Who is your user?

### Problem

* What problem is your app trying to solve? Why is your app different from any of the other 'similar' apps that are out there.

### Features

* What features will your app include?

### Integrations

* Which APIs will you use?
* Which OAuth integration are you planning to use? How will you use OAuth to do something on the user's behalf?
```

### APIs

Your application **must make good use of at least two external datasets or APIs**. Some examples include:

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

* [Facebook](https://developers.facebook.com)
* [Instagram](https://instagram.com/developer)
* [Github](https://developer.github.com/v3)
* [FitBit](https://dev.fitbit.com)
* [Spotify](https://developer.spotify.com/web-api)
* [Strava](https://www.strava.com/developers)
* [Google Maps](https://developers.google.com/maps)

#### Features/Technologies

* SMS messaging
* Email
* Optical Character Recognition (OCR)
* Natural Language Processing (NLP)
* Machine Learning
* Data Analytics
* Websockets
* Messaging Brokers/Queues
* Data Visualization
* Location Services (Google Maps/Directions)
* IOT Hardware (ex: Raspberry PI)


The following links are catalogs of APIs on rapidapi.com. You will not implement RapidAPI, it's just a great place to find other APIs.

free/discounted apis for students:
- [https://rapidapi.com/collection/rapidapi-school](https://rapidapi.com/collection/rapidapi-school)

free public APIs:
- [https://rapidapi.com/collection/list-of-free-apis](https://rapidapi.com/collection/list-of-free-apis)

covid-19 apis:
- [https://rapidapi.com/collection/coronavirus-covid-19](https://rapidapi.com/collection/coronavirus-covid-19)

job postings and job search data:
- [https://rapidapi.com/collection/job-search-apis](https://rapidapi.com/collection/job-search-apis)

fun apis like english-to-yoda:
- [https://rapidapi.com/collection/cool-apis](https://rapidapi.com/collection/cool-apis)

google-specific apis:
- [https://rapidapi.com/collection/google-api](https://rapidapi.com/collection/google-api)

online databases of collections of some sort of data (ie, movies, music, etc):
- [https://rapidapi.com/collection/database-apis](https://rapidapi.com/collection/database-apis)

alternatives to Google Maps:
- [https://rapidapi.com/collection/alternatives-to-google-maps-api](https://rapidapi.com/collection/alternatives-to-google-maps-api)

Other API Sources:

- [https://apilist.fun/](https://apilist.fun/)
- [https://github.com/public-apis/public-apis](https://github.com/public-apis/public-apis)
- [https://api.data.gov/list-of-apis/](https://api.data.gov/list-of-apis/)

However, the list is not limited to these. You can choose to integrate with a service of your choosing, as long as it is approved ahead of time.

---

## Some Project Ideas to get the Creative Process Started

### Previous Student Pitches

#### Social Workout
Individuals who have a hard time to motivate themselves to workout but use social media. 15minutes of working out get 50 posts for facebook/instagram and use spotify for music to work out too. Possible fitbit to track workout information.

#### Elephant Resume
Build a long-form resume, and build an app that trims it down to a smaller version. Store all of your resume points in one place. Focused on collaboration / achievement. App would analyze bullet points (NLP), #leadership, generate the best resume for a job application. Scans job posts and analyze keywords.

#### Tinder for Netflix 
Tinder for Netflix, swipe left/right on movies and match you with friends who want to view those shows. Match on content taste. Could we scan Netflix accounts for matching, closeness of friends, language of films, show open viewing parties for others.

#### Tabbouleh 
Instagram type layout, sign up to be a chef, post recipes, link that to a non-profit. If you like a recipe, it contributes to a non-profit organization. Kroger API for grocery list, ratings, comments, newsfeed (GetStream.io), Shipd for grocery delivery.

#### The Green Book App
Green Book in days of segregation, written and maintained to let people know which businesses were allowed to serve BIPOC, businesses can be rated, and if a company gets a bad rating, link them to orgs who help businesses improve that score



### Ideas from Instructors

#### GitHub Scanner

Login with GitHub, analyze forked repos to find things you haven't maintained where original repo had been updated, or suggest pull requests for work you've done that haven't been pushed/merged yet. Get list of your popular language/tech, find jobs for those technologies, suggest resume ideas for which projects to list for a customized resume for each job. Find your repos where you don't have a readme (or grade the quality of readme) and make suggestions.


#### License Plate Messenger

Could we upload a picture of a license plate and leave a message for the driver(s) (not while driving of course!); use IBM Watson for sentiment analysis for whether the message is mean or not. Users would sign up and upload a photo of their own license plate to "register" and access their messages.

- Google Vision API is free for 1000 calls per month
- Cloudmersive has 50,000 free images
- Microsoft Computer Vision is 5000 free images


#### Pantry/Recipe "quick grocery run"

Ian's unscientific survey (sample size: himself) shows that without a plan, wandering around a grocery store for long durations (a) exposes you to COVID-19 risks, and (b) makes you overspend on things you didn't really need, and (c) you're likely to forget some of the critical things you went to the store to purchase in the first place.

Users can register, track what's in their pantry/fridge/freezer (bar code scanning maybe?), then search a database of recipes of meals they would like to make for the week. The app will scan the recipes, and generate a shopping list, but also use Kroger's grocery API to track where in the store these ingredients are found (ie, aisle numbers), to allow users to optimize their trip. Spend less, get out faster.

- https://developer.kroger.com/
- https://rapidapi.com/collection/food-apis


#### Twitter Senitment

Enter a person's Twitter handle, search their feed for a given topic or keywords, run those messages through IBM Watson for sentiment analysis, track the sentiment over time and chart the data of whether that user likes that topic/keyword more or less over time

Students will need to work with Ian to get a new API key set up since Twitter takes a REALLY long time to approve new Twitter API applications, and Ian has an approved Twitter Developer account

Extension idea: could we determine if the user is talking about a business, and check stock prices to see if the stock goes up or down soon after the user tweeted? (is there a correlation of a user tweeting about a business or ticker symbol, and the stock price changing?)


#### Whose turn is it to do chores?

Roommates register and add each other to a living space, then set up regular chores. Chores are added to each user's Google Calendar on alternating time periods to trade off whose turn it is to, say, clean the bathroom every 3rd day, track how long the chore should take. Second API could be to find a playlist of songs while working on the task (secondary OAuth through Spotify, for example), or send an SMS reminder (not through Google Calendar reminders)


#### Holiday/birthday/anniversary gift lists

Users can authenticate, build wishlists with URLs to items they want from multiple sites (ie, Amazon, Etsy, etc); family members and friends can friend each other in the app (maybe we scan the user's gmail account to link others who are registered on the site?), they can see your list of gift ideas, search for product reviews based on the item, and choose to buy the item, or split the cost with others; family members can see who is 'reserving' a gift or splitting the cost, but original person will not know. Perhaps set a calendar event for when to order the gift so it arrives in time for that holiday. Send notices to other family/friends via group email, perhaps.

- https://rapidapi.com/collection/review-apis


#### What do you know?

Users can authenticate, and receive a hisotrical fact about the today in history. Users can then complete a daily trivia quiz, track their scores over time, create friendly competitions between a registered friend and compete for highest weekly score to earn a "trophy".

- [Trivia API](https://opentdb.com/api_config.php)
- [Today in Histroy](https://history.muffinlabs.com/)
