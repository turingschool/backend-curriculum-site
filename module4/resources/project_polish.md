---
layout: page
title: Project Polish
length: 180
tags: portfolio, github, interview
---

## Learning Goals

Students will be able to...
- explain what considerations go into a polished project
- do an audit of a current project on their resume and improve at least one area of that project


## Warm Up

- What projects are listed on your resume?
- How sure are you that they are as good as they could be?
- If they are as good as they could be, how do you know? What have you done to get them there?
- If they aren't as good as they could be, why not? (not sure what to do, haven't made the time, etc.)

## What should I care about?

You are human, you are not perfect. That's why we have teams; to help each other out with blind spots. You have a lot going on and it can be hard to focus on getting the little things done.

Many projects are littered with issues! The exercise of building software is never-ending. Today we are going to discuss some specific things you should consider as you polish projects, specifically for your resume.

### Error Handling
- Human readable errors are important!
- This includes error handling on the frontend and on the backend
- Focus on the user experience

### Validations
- Client side: Let this be your first guard against the user doing something they aren’t supposed to do.
- Server side: Let this be your last line of defense if client side validations fail for some reason.

### Navigation and Standard UX
- Making sure UX is simple and useful
- Making sure that you can go back after you reached a particular page
- If you don’t know much about UX, you should read this book: _Don't Make Me Think_ by Steve King

### Understanding Basic Style
- Understanding a decent amount of CSS (or SASS): https://learn.shayhowe.com/
- Picking better color palettes: https://flatuicolors.com/
- Picking great typography: https://fonts.google.com/
- Making it accessible to users: https://www.usability.gov/what-and-why/accessibility.html

### Edge Cases
- If user does X, what happens to your application? Are there any unwanted consequences?

You’ll surely discover new edge cases along the way. It’ll make you wonder how a user even did a certain action in the first place. Mapping out edge cases will save you a lot of headaches in the future. It will also make you look thoughtful and thorough, which people who consider paying you a lot of money to write code will like.

### No passing tests === no deploys
- While you should have a decent amount of test coverage, your spec must be passing before it gets deployed.
- If you see that your tests are not passing while being ran in continuous integration tool, then the deploy should be stopped.

Moral of the story: Use CI.

### Test the most crucial front-end features
- You should be making sure that your most crucial features are being tested, even on the front-end.
- Many times, you’ll hear that it works on my machine but then it doesn’t in other environments.
- Testing foundational interactions that your user will encounter is essential to building great software.

### Documentation/README
I’d like to know a few things:
- What does your project do?
- What does it look like? (screenshots)
- How can I get set up and start contributing?
- Is there any strange configuration that I need to know about?
- Is this project dependent on another project?

### Git Commit messages
Sometimes projects can get a little crazy and we commit code with messages that are incoherent. We can fix this by doing a few things:
- Abiding by a git commit message template
- Sqashing old commits into something more readable
- Be professional. Don’t be like these people: http://www.commitlogsfromlastnight.com

## Project Audit

- Take 5 minutes to select one of the projects listed on your resume that you would like to polish. Copy and paste the repo link and your resume into the cohort channel.
- Take 30 minutes to go into your partner's repo. Do an audit and give them feedback on each category
- Take 3 minutes to read through the feedback, 3 minutes to clarify anything with your partner.
- Decide what you are going to prioritize polishing _today_. You can absolutely continue on this throughout the coming weeks, and this would be a great thing to talk with your coach about! But for today, pick a bite-sized chunk that you think will take 45 minutes - 1 hour.

## Work Time

Take the next ~1 hour to start working on one bite-sized piece of polishing based on your partners feedback!

## Wrap Up

DM your career coach and instructors letting us know...
  - The feedback I got
  - The area I focused on
  - The steps I took, the outcome (show your group!)
  - The steps I plan to take in the future (and where they are documented)


### Audit Rubric

#### Git Workflow
- Are the commits following a consistent pattern?
- How were branches utilized?
- Was a PR template used?
- If a pair/group project, are code reviews/conversations present?

#### Testing
- Are you able to clone down the app and run tests?
- If so, do all tests pass?
- Is there documentation on how to show coverage?
- If so, is coverage > 99%?

#### Deployed Application
- Do you know how to use the application?
- Is navigation clear and easy?
- Try to poke holes in the app - Did you get any errors? Should you have gotten any errors?
- Run an accessibility audit (in DevTools, either use the aXe tool or under the Audits tab). Any issues with accessibility?
- Were you confused about what the app did, how to use it, or anything, at **any** time? Please be as specific as possible, and provide solutions if you have any!

#### Documentation / Resume
- Does the resume highlight things that set this developer apart from other applicants for a Junior Developer position?
- Is wording in resume and README consistent?
- README (lower priority for today - we will have a more in-depth workshop on READMEs later in the mod!)
  - Is there an explanation of the purpose of the app/problem it is solving?
  - Are there screenshots?
  - Are there crystal-clear instructions on how to get the project up and running on your machine?
  - Is there detailed info on endpoints (verb, human readable explanation of the data, endpoint, response (body and codes), expected request if applicable, errors that will come back and why)?
  - Is this dependent on any other project? Is that project linked?


### Feedback Synthesis (to be completed by author of project)
- What are 2-3 main takeaways from this feedback?
- What feels most urgent to you?
- What feels highest leverage?
- What are you going to start on today (~45 minutes of work time)?
- What other pieces would you like to continue polishing?
