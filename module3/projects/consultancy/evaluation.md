---
layout: page
title: Consultancy - Evaluation
type: project
---

## Work in Progress

This evaluation rubric is not yet finished.


## Evaluation at a High Level

Project evaluation will be done on a continual basis. Teams will have checkboxed items below which will sum up to total a quantity of points for each rubric item. Rubric items may have a different quantity of points to award, but will all divide into a floating-point score between 1.0 through 4.0.

Typically, scores higher than 3.0 will be for going "above and beyond" expectations, learning tools and implementing concepts we don't teach in class.

However, we will not reward "heroics". Staying up late, pulling all-nighters, is not what this project is about. We're here to work together as a team, and solo efforts will generally be discouraged by your project managers.


### Feature Delivery

20 Points total, every checkbox is worth 0.2 points towards your score.

Rails Front End
- [ ] Professional quality HTML and CSS, color palette is pleasing and suitable to the target audience
- [ ] Application works in multiple browsers (Chrome, Safari, Firefox, etc)
- [ ] OAuth works error-free in incognito/private mode in multiple browsers
- [ ] Good integration tests are built to expect good user workflow within the application
- [ ] No data storage (models, database schema, etc) is done at this layer; sessions and caching are the exception
- [ ] 50% or more MVP stories are completed
- [ ] 100% or more MVP stories are completed

Rails Back End
- [ ] Database migrations are managed well, database schema is well planned and executed
- [ ] Routes are nearly at least 75% RESTful (PMs have some discretion here)
- [ ] Database CRUD endpoints built out properly and well tested
- [ ] 50% or more MVP stories are completed
- [ ] 100% or more MVP stories are completed

Microservice 1
- [ ] Endpoint reoutes attempt to use RESTful patterns (PMs have some discretion here)
- [ ] Sinatra code base is well organized
- [ ] 50% or more MVP stories are completed
- [ ] 100% or more MVP stories are completed

Microservice 2
- [ ] Endpoint reoutes attempt to use RESTful patterns (PMs have some discretion here)
- [ ] Sinatra code base is well organized
- [ ] 50% or more MVP stories are completed
- [ ] 100% or more MVP stories are completed


### Technical Quality

36 Points total, every checkbox is worth ~0.11 points towards your score.

Rails Front End
- [ ] User-facing routes are friendly (not necessarily RESTful)
- [ ] Application is easy to navigate for non-technical users
- [ ] Bootstrap is utilized well for layout and styling
- [ ] Caching is managed well
- [ ] Controllers utilize Facades
- [ ] Facades utilize Service calls well to store/retrieve data from backend
- [ ] Facades and Services are written well with private methods as appropriate
- [ ] Code follows strong DRY and SRP design
- [ ] Travis-CI is set up
- [ ] Travis-CI deploys to Heroku

Rails Back End
- [ ] Exposed API routes are versioned well using namespacing
- [ ] Exposed API routes utilize more than one version (ie, an endpoint exists as both /v1/ and /v2/ that do something slightly different)
- [ ] Caching or Background workers are implemented in some way
- [ ] Database eager-loading is used to optimize database performance
- [ ] Controllers utilize Facades and Serializers
- [ ] Facades and Serializers use 100% class methods so instantiation is unnecessary
- [ ] Facades read/write data from Models and Services as appropriate
- [ ] Facades use POROs appropriately
- [ ] Facades and Services are written well with private methods as appropriate
- [ ] Code follows strong DRY and SRP design
- [ ] Travis-CI is set up
- [ ] Travis-CI deploys to Heroku

Microservice 1
- [ ] Exposed API routes are versioned well
- [ ] Exposed API routes utilize more than one version (ie, an endpoint exists as both /v1/ and /v2/ that do something slightly different)
- [ ] Optimization techniques (ie, caching) are used within the code in some way
- [ ] Good serialization patterns are implemented to return JSON
- [ ] Code follows strong DRY and SRP design
- [ ] Travis-CI is set up
- [ ] Travis-CI deploys to Heroku

Microservice 2
- [ ] Exposed API routes are versioned well
- [ ] Exposed API routes utilize more than one version (ie, an endpoint exists as both /v1/ and /v2/ that do something slightly different)
- [ ] Optimization techniques (ie, caching) are used within the code in some way
- [ ] Good serialization patterns are implemented to return JSON
- [ ] Code follows strong DRY and SRP design
- [ ] Travis-CI is set up
- [ ] Travis-CI deploys to Heroku


### Testing

20 points total, each checkbox is worth 0.2 towards your score.

Rails Front End
- [ ] API calls to backend, and OAuth, are tested using mocks/stubs
- [ ] 50% or more test coverage of happy path expectations
- [ ] 75% or more test coverage of happy path expectations
- [ ] 90% or more test coverage, includes happy path and sad path expections
- [ ] 95% or more test coverage, every application feature and back-end endpoint has at least one sad path test

Rails Back End
- [ ] API calls to microservices are tested using mocks/stubs
- [ ] 50% or more test coverage of happy path expectations
- [ ] 75% or more test coverage of happy path expectations
- [ ] 90% or more test coverage, includes happy path and sad path expections for exposed endpoints
- [ ] 95% or more test coverage, every exposed endpoint and service consumption has at least one sad path test

Microservice 1
- [ ] calls to external API services are tested using mocks/stubs
- [ ] 50% or more test coverage of happy path expectations
- [ ] 75% or more test coverage of happy path expectations
- [ ] 90% or more test coverage, includes happy path and sad path expections for exposed endpoints
- [ ] 95% or more test coverage, every exposed endpoint and API consumption endpoint has at least one sad path test

Microservice 2
- [ ] calls to external API services are tested using mocks/stubs
- [ ] 50% or more test coverage of happy path expectations
- [ ] 75% or more test coverage of happy path expectations
- [ ] 90% or more test coverage, includes happy path and sad path expections for exposed endpoints
- [ ] 95% or more test coverage, every exposed endpoint and API consumption endpoint has at least one sad path test


### Presentation and Documentation

28 points total, each checkbox is worth ~0.14 towards your score.

Slide Presentation
- [ ] Outlines MVP of the project
- [ ] Discusses end users, persona alaysis
- [ ] Discusses technical choices made

Live Demo
- [ ] End-to-end demo of live application
- [ ] End-to-end demo is done 100% in production via web browser
- [ ] Postman is used on production to show backend service working
- [ ] Postman is used on production to show Microservice 1 working
- [ ] Postman is used on production to show Microservice 2 working
- [ ] ENV variables are changed on Heroku to point to invalid backend/services or API keys; front-end shows a user-friendly error scenario
- [ ] Different team members presented this content than other areas of the presentation

Video Presentation
- [ ] Team has prepared a demonstration video
- [ ] Video displays end-to-end application demo of happy path
- [ ] Video discusses persona alaysis and user empathy
- [ ] Video discusses service-oriented architecture
- [ ] Different team members presented this content than other areas of the presentation

README and Documentation
- [ ] Git repos for each codebase have README files which contain:
  - [ ] links to other repos
  - [ ] contain a list of contributors, their GitHub profiles and LinkedIn profiles
  - [ ] discuss the purpose of its repo's existance and how it fits into the project SOA
  - [ ] how to install and test the repo
- [ ] README for front-end has screenshots and discusses OAuth, user personas and exhibits user empathy
- [ ] README for back-end includes database schema and each endpoint is documented
- [ ] README for Microservice 1 documents:
  - [ ] each endpoint exposed to the back-end
  - [ ] its use of external service API
- [ ] a Postman collection JSON file is included in the back-end service repo to test the back-end endpoints in production (except for any portion which needs OAuth)
- [ ] a Postman collection JSON file is included in the Microservice 1 repo to test the back-end endpoints in production (except for any portion which needs OAuth)
- [ ] a Postman collection JSON file is included in the Microservice 2 repo to test the back-end endpoints in production (except for any portion which needs OAuth)
  

---

## Peer Evaluation

In addition to your instructor's scores, you will receive a peer evaluation from each group member with the following rubric:

### Communication

* **4:** Group member did all the things mentioned in the bullet point below, but also was a catalyst for communication with the whole group.
* **3:**  Group member communicated clearly when they would and wouldn’t be available well ahead of time. It was clear what they were working on and what the status was.
* **2:** Group member would communicate when they would or wouldn’t be available, but not until the last minute, or they would miss deadlines and not notify the group until the last minute.
* **1:** It was unclear what the group member was working on, or they would fail to notify the team when they weren’t going to meet a commitment.

### Contribution

Group member contributed code (quantity and quality):

* **4:** Above expectations
* **3:** As expected
* **2:** Below expectations
* **1:** Well below expectations

### Professionalism

Would you like to work with this group member professionally?

* **4:** Absolutely. I will likely seek them out in the future with the hopes of working with them again.
* **3:** Yes, I would enjoy working with them.
* **2:** I would prefer not to.
* **1:** I would actively avoid working with them again.
