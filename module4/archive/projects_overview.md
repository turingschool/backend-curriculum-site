---
layout: page
title: Module 4 Projects
---

To best emulate the workplace, students will work in 4+ person teams on projects lasting the entire module. The six-week project will be broken into three sprints of two weeks each.

The projects themselves emphasize:

* Getting software into production and real usage
* Working with code out of the team’s control
* Making smart use of and contributing to open source
* Adopting “brownfield” code when possible
* Working in tight iterations to deliver value throughout, not just at the end of, the project

## Project Concepts

### Census - An Identity Manager

Census serves as a central location for identity management across the Turing community. Once an applicant is admitted they are a member of census. It tracks their essential identifying information (name, email, phone) but also online identity (twitter, linkedin, etc). Students are members of a cohort. Most importantly, Census is an OAuth provider allowing the other internal apps, included those here, to use it as an identity platform.

* Priority: High
* Status: Project itself is starting greenfield, but the team will need to work with several existing apps to replace their authentication system.

### Monocle - Job Hunt Research Tool

I want to apply for jobs in Fort Collins, Colorado. What companies might I want to investigate? Where have Turing grads applied before? What was their experience? Monocle endeavors to be the “Yelp for Job Hunting”, assisting both with finding companies to apply to and making smarter decisions about possibilities. It starts with a rough dataset of ~2500 companies for the State of Colorado. Monocle should pull job listings from multiple sources. But the real power is in user-generated content/feedback.

* Priority: High
* Status: First prototype exists and can be built upon.

### Enroll - Turing's Student Enrollment & Payment System

Who’s in what cohort? What tuition plan are they on? Have they paid their deposit? What if they want to move to a different start date? Have they received the proper documents and materials? Can we generate custom contracts with the RightSignature API? Estimate upcoming cash flow based on enrollment? Enroll should rely on Census for authentication and authorization, but currently has a complex auth system that should be ripped out. Obviously this project is under daily use and involves both privacy and real money, so we’ll have to tread carefully.

* Priority: Medium
* Status: Production application with two years of history

### Apply - Turing’s Student Application System

The application system was the first app we wrote almost three years ago. Users login with GitHub, which will stay, but once they start apply we can add them to Census. Apply has a complicated State Machine implementation that should likely be replaced with a simpler workflow. We need to add alternate tracks through the application for persons who are exempt from certain elements. We need a better dashboard of data to understand the flow of applications. The logic problem generation should be pulled out to a service. On top of all of the technical changes, we’ll be implementing a new and improved design for the front-end.

* Priority: Medium
* Status: Production application with three years of history

### Briefcase - Turing’s Student Employment Portfolio System

We’ve gone through a few iterations of portfolio systems. We’ve had raw HTML that was simple to work on but not organized. Right now we have a PHP system implemented by an outside consultancy. That’s not so fun, either. What if we rebuilt the portfolio system to take the best features of the PHP system, steal the design where useful, but also integrate with Census?

* Priority: Low
* Status: Production PHP application to be replaced

### Ifill - Slack-Based Group Coordination

Slack is a solid means of communication, but it is a weak tool. Ifill supports the people systems at Turing through a combination of Slack and web. It makes it easy to run portfolio and project evaluations, pinging students via DM when their turn is approaching. It moderates certain channels so that only approved users can post. It deletes the noise of channel join/delete messages for our largest channels. It springs topic-specific channels in response to interesting news topics to reduce the noise in large groups. It coordinates the topics, size, and location for Friday Spike sessions. All in all, Ifill uses Slack to reduce the friction of our day-to-day work.

* Priority: Low
* Status: Greenfield from Scratch
