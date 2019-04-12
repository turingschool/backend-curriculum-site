# Self Directed Project / Sweater Weather

For your Week 1 solo project, you will replicate Sweater Weather as an Express API.

## Learning Goals

* Utilize a project board to create and track details for project completion
* Practice written technical communication with concise and consistent git commits and clear pull requests
* Clearly document Introduction, Initial Setup, How to Use, Known Issues, Running Tests, How to Contribute, Core Contributors, Schema Design, and Tech Stack List
* Implement testing in JavaScript
* Familiarize self with mechanics of building an Express API

### Requirements Overview

For this project we want you to practice both professional and technical skills. You should develop a good work flow to communicate and document technical information and take time to create a process for building and testing an Express API.

Below are listed the six endpoints you are expected to create. You will be using [Google’s Geocoding API](https://developers.google.com/maps/documentation/geocoding/start) to retrieve the lat and long for the city and retrieve forecast data from the [Darksky API](https://darksky.net/dev) using the lat and long.

#### 1. Account Creation
*For storing passwords in your database, we suggest looking into [bcrypt](https://www.npmjs.com/package/bcrypt).*


```json
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "my_email@example.com",
  "password": "password"
  "password_confirmation": "password"
}
```

#### Response

```json
status: 201
body:

{
  "api_key": "jgn983hy48thw9begh98h4539h4",
}
```

#### 2. Login

```json
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "my_email@example.com",
  "password": "password"
}
```

#### Response

```json
status: 200
body:

{
  "api_key": "jgn983hy48thw9begh98h4539h4",
}
```

#### 3. Forecast for City

Requirements
- API key must be sent
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

#### Response

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

#### 4. Favoriting Locations

Requirements
- API key must be sent
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

#### Successful Response

```json
status: 200
body:

{
  "message": "Denver, CO has been added to your favorites",
}
```

#### 5. Listing Favorite Locations

Requirements:
- API key must be sent
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

#### Response

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

6. Removing Favorite Locations

Requirements:

API key must be sent
If no API key or an incorrect key is provided return 401 (Unauthorized)

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

#### Response

```json
status: 204
```

### Workflow Expectations

Even though this is a solo project, you are expected to maintain a professional workflow.
This includes attention to branches, commit messages, and yes, PRs. Think of PRs as the story of your application - it is not for you as you build the application, it is for your later self or someone else potentially jumping into codebases. This is where we should see rationale for decisions, what other options you considered and the pros/cons, as well as notes about what is missing next, etc. Please see the rubric for details.

### PR Reviews

Since you are working solo on this, we are providing two requirements (opportunities!) for feedback from others on your code. By 8:00am on Monday of the project, you need to have made at least two PRs that tag and ask for specific feedback from two peers.
In order for this requirement to be fulfilled,
- You need to make the PR and tag them with a specific review ask
- They need to respond in the PR conversation with actionable feedback
- You need to make a change, tag them again for their review (you may need to ask a clarifying question before doing so, if that's the case, ask in the PR conversation instead of Slack or in person)
- If they continue the conversation great, if not, that's fine at this point

### Check-In

You will check in with one of your instructors on Monday and Thursday afternoons. At this time, instructors expect that you have the following in place/ready to show us:

Monday:

- Repo created - add your PM as a contributor
- Agile board created, all user stories written in detail - invite your PM/send us the link
- Project successfully deployed
  -   Link:   

Thursday:

- At least 3 of the endpoints are being hit successfully and the app is returning formatted data
- Project is still successfully deployed

### Evals

The evaluation for this project will be held on Monday of Week 2 from 9-12 - the last commit we will accept is at 8am. The rubric that will be used can be found [here](./express_sweater_weather_rubric) - it is highly recommended that you check in with this rubric regularly.
