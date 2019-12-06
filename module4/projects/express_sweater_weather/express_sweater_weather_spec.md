# Express Sweater Weather
For your week one solo project, you will replicate Sweater Weather using the lightweight Express framework.

## Learning Goals

* Utilize a project board using Github Projects to create and track details for project completion
* Practice written technical communication with concise and consistent git commits and clear pull requests
* Write clear documentation that conveys the important details of your project, how to get things set up, how things work, and what to expect when using your API. 
* Explore and use a new language by building a simple API with the Express framework. 

### Requirements Overview

For this project we want you to practice both professional and technical skills. You should develop a good work flow to communicate and document technical information and take time to create a process for building an Express API.

Below are the endpoints you are expected to create and You will be using [Google’s Geocoding API](https://developers.google.com/maps/documentation/geocoding/start) to retrieve the lat and long for the city and retrieve forecast data from the [Darksky API](https://darksky.net/dev) using the lat and long.


#### 1. Forecast for City

Requirements:
- API key must be sent along with the request
- If no API key or an incorrect key is provided return 401 (Unauthorized)

```json
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json

body:
{
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

#### Expected successful response

 *The response below is an example that gives only 1 object in the data array for both the hourly and daily. Your response should contain at least __8 hourly objects__ and __7 daily objects__*

```json
{
  "location": "Denver, C0",
  "currently": {
      "summary": "Overcast",
      "icon": "cloudy",
      "precipIntensity": 0,
      "precipProbability": 0,
      "temperature": 54.91,
      "humidity": 0.65,
      "pressure": 1020.51,
      "windSpeed": 11.91,
      "windGust": 23.39,
      "windBearing": 294,
      "cloudCover": 1,
      "visibility": 9.12,
    },
  "hourly": {
    "summary": "Partly cloudy throughout the day and breezy this evening.",
    "icon": "wind",
    "data": [
      {
      "time": 1555016400,
      "summary": "Overcast",
      "icon": "cloudy",
      "precipIntensity": 0,
      "precipProbability": 0,
      "temperature": 54.9,
      "humidity": 0.65,
      "pressure": 1020.8,
      "windSpeed": 11.3,
      "windGust": 22.64,
      "windBearing": 293,
      "cloudCover": 1,
      "visibility": 9.02,
      },
    ]
  },
  "daily": {
    "summary": "No precipitation throughout the week, with high temperatures bottoming out at 58°F on Monday.",
    "icon": "clear-day",
    "data": [
      {
        "time": 1554966000,
        "summary": "Partly cloudy throughout the day and breezy in the evening.",
        "icon": "wind",
        "sunriseTime": 1554990063,
        "sunsetTime": 1555036947,
        "precipIntensity": 0.0001,
        "precipIntensityMax": 0.0011,
        "precipIntensityMaxTime": 1555045200,
        "precipProbability": 0.11,
        "precipType": "rain",
        "temperatureHigh": 57.07,
        "temperatureLow": 51.47,
        "humidity": 0.66,
        "pressure": 1020.5,
        "windSpeed": 10.94,
        "windGust": 33.93,
        "cloudCover": 0.38,
        "visibility": 9.51,
        "temperatureMin": 53.49,
        "temperatureMax": 58.44,
      },
    ]
  }
}
```

#### 2. Favoriting Locations

Requirements:
- API key must be sent along with the request
- If no API key or an incorrect key is provided return 401 (Unauthorized)

```json
POST /api/v1/favorites
Content-Type: application/json
Accept: application/json

body:

{
  "location": "Denver, CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

#### Expected successful response

```json
status: 200
body:

{
  "message": "Denver, CO has been added to your favorites",
}
```

#### 3. Listing Favorite Locations

Requirements:
- API key must be sent along with the request
- If no API key or an incorrect key is provided return 401 (Unauthorized)

```json
GET /api/v1/favorites
Content-Type: application/json
Accept: application/json

body:

{
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

#### Expected successful response

```json
status: 200
body:
[
  {
    "location": "Denver, CO",
    "current_weather": {
      "summary": "Overcast",
      "icon": "cloudy",
      "precipIntensity": 0,
      "precipProbability": 0,
      "temperature": 54.91,
      "humidity": 0.65,
      "pressure": 1020.51,
      "windSpeed": 11.91,
      "windGust": 23.39,
      "windBearing": 294,
      "cloudCover": 1,
      "visibility": 9.12,
    },
    "location": "Golden, CO",
    "current_weather": {
      "summary": "Sunny",
      "icon": "sunny",
      "precipIntensity": 0,
      "precipProbability": 0,
      "temperature": 71.00,
      "humidity": 0.50,
      "pressure": 1015.10,
      "windSpeed": 10.16,
      "windGust": 13.40,
      "windBearing": 200,
      "cloudCover": 0,
      "visibility": 8.11,
    }
  }
]
```

4. Removing Favorite Locations

Requirements:
- API key must be sent along with the request
- If no API key or an incorrect key is provided return 401 (Unauthorized)

```json
DELETE /api/v1/favorites
Content-Type: application/json
Accept: application/json

body:

{
  "location": "Denver, CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

#### Expected successful response

```json
status: 204
```

### Expectations on your workflow

Even though this is a solo project, you are expected to maintain a professional workflow for the duration of the week.

This includes careful attention to: 
- Creating branches and commit work off of them
- Writing concise yet informative commit messages that convey what task you completed 
- Creating pull requests. Please note that PR names will often be the same as your branch name. Instead, you’ll want to update your PR name to reflect what that chunk of work/code did.  

Think of a PR and commits as a part of the story for your application. It is not just for you as you build the application but also for your later self or someone else potentially jumping into codebases. This is where we should see rationale for decisions, what other options you considered and the pros/cons, as well as notes about what is missing next, etc. Please see the project rubric for more details.

### Expectations on pull request reviews

Since you are working on this project by yourself, we are providing one requirement (opportunity!) for feedback from others on your code. By 8:00am on due date of the project, you need to have made at least one PR that tags and asks for specific feedback from a peer in your cohort.

In order for this requirement to be fulfilled,
- You need to make the PR and tag them with a specific review request
- They need to respond in the PR conversation with actionable feedback (Just a thumbs up won’t be counted as actionable feedback). 
- You need to make a change, tag them again for their review (you may need to ask a clarifying question before doing so, if that's the case, ask in the PR conversation instead of Slack or in person)
- If they continue the conversation great, if not, that's fine at this point


### Day 1 Deliverables
After the product kick off, you’ll be expected to send both of your instructors the following links by and no later than 9PM of that same day: 

- Link to your project’s repo on Github
- Link to your sprint board on Github Projects with your first stories. If you want to know our expectations around this, please take a look at the rubric for more details.
- Deployed production link on Heroku

### Expectations for your project check-in

This project will also include one check-in with one of your instructors. Please take a look at your calendar to see when check-ins will take place.

Group checkin expectations:
- At least two of the endpoints are being hit successfully and the app is returning formatted data
- Project is successfully deployed on production

### Expectations for project evaluations

- Make sure to take a look at the calendar for when your evaluations will be
- The last commit that we will accept is at 8am on the morning that the project is due. 
- The rubric that will be used can be found [here](./express_sweater_weather_rubric) - it is highly recommended that you check in with this rubric regularly.
