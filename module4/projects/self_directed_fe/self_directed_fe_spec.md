# Self Directed Project / Sweater Weather

For your Week 1 solo project, you will build out a front-end application that consumes your self-directed API (or Sweater Weather).

## Learning Goals

* Create a vanilla JS or jQuery front-end application that makes network requests to an API
* Form opinions and make/defend decisions about how to organize the code in the front-end application

### Requirements Overview

You will be creating a front-end to consume your fully-tested Rails API from Mod3. You can use [this](https://github.com/turingschool-projects/self-directed-fe-starter) as a starter kit, but don't have to. Read the README thoroughly to get set up.

* Your front end should be deployed with [GitHub Pages](https://pages.github.com/) or [Surge](https://surge.sh/). Directions for GitHub Pages deployment are available in the README of the starter kit.

* Since your back end will be deployed to a different address, you will need to override the default of CORS. We recommend using the [rack-cors](https://github.com/cyu/rack-cors) gem.


### Front End Features

As many of you chose your own topic and data, the exact feature set may vary. Even within Sweater Weathers, some applications may behave slightly differently from others - which is ok! Some things to consider:

- You must perform AJAX requests to your API using jQuery
- You should have at least three buttons on the page that are listening for a click - maybe it's to get additional information from the API, to hide or show something, to trigger a search/filter, to favorite a location or to navigate to a different page.
- "Don't Make Me Think" by Steve Krug is a great book for UI/UX best practices. Dribbble.com is also a great place for inspiration. Lastly, [Canva](https://www.canva.com/color-palette/) can help you determine a color palette with a photo, and [Color Space](https://mycolor.space/) will generate multiple palettes for you when you provide one color.

### Workflow Expectations

Even though this is a solo project, you are expected to maintain a professional workflow.
This includes attention to branches, commit messages, and yes, PRs. Think of PRs as the story of your application - it is not for you as you build the application, it is for your later self or someone else potentially jumping into codebases. This is where we should see rationale for decisions, what other options you considered and the pros/cons, as well as notes about what is missing next, etc. and screenshots in a FE application. Please see the rubric for details.

### PR Reviews

Since you are working solo on this, we are providing two requirements (opportunities!) for feedback from others on your code. By 9:30am on Friday of the project, you need to have made at least two PRs that tag and ask for specific feedback from one instructor and one peer or mentor. You are more than welcome to make a FE friend in Mods 3 or 4 and ask them to review it. You can ask a mentor, someone who graduated in the last couple innings and doesn't have a job so will want something to do, or one of your cohort mates! In order for this requirement to be fulfilled,
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
- Two professional web apps that you will use for UI/UX inspiration
- a Color Palette you will use

Thursday:
- Basic structure of the page is set up and looking _good_ (HTML and CSS wise), but may not be finalized
- At least 3 of the endpoints are being hit successfully and the app is showing the data from at least 2 of those endpoints.
- Project is still successfully deployed

### Evals

The evaluation for this project will be held on Monday morning of Week 2 from 9-12 - the last commit we will accept is at 8am. The rubric that will be used can be found [here](./self_directed_fe_rubric) - it is highly recommended that you check in with this rubric regularly.
