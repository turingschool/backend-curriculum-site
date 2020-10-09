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

Each Repo meets the following:

- 50% or more MVP stories are completed
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2
   
Rails Front End
- [ ] 100% or more MVP stories are completed
- [ ] OAuth works error-free in incognito/private

Rails Back End
- [ ] Proxy for Rails Front End and Microservices

__If the above criterea is met, below are additional points to achieve a 4__

- Additional Stories/Features impleneted above MVP
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2

- Exposed API routes utilize more than one version (ie, an endpoint exists as both /v1/ and /v2/ that do something slightly different)
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2

- Rails Front End
    - [ ] Professional quality HTML and CSS, color palette is pleasing and suitable to the target audience
    - [ ] Application works in multiple browsers (Chrome, Safari, Firefox, etc)




### Technical Quality

Each Repo meets the following:

- Code follows DRY and SRP design
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2

- Routes follow RESTful patterns (PMs have some discretion here)
    - [ ] Rails Front End, User-facing routes are friendly (not necessarily RESTful)
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2
 
- Optimization technique is implemented in one of the following:
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2
 
 - Controllers utilize Facades
    - [ ] Rails Front End
    - [ ] Rails Back End
    
 - Facades utilize Service calls to store/retrieve data
    - [ ] Rails Front End
    - [ ] Rails Back End
 
 - Good serialization patterns are implemented to return JSON
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2
    
- Exposed API routes are versioned well
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2
    
- Facades, Services, and/or Serializers use 100% class methods so instantiation is unnecessary
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2
    
 - Deploy to Heroku
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2
    
- Travis CI is set up
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2
 

Rails Front End

- [ ] No data storage (models, database schema, etc) is done at this layer; sessions and caching are the exception
- [ ] Application is easy to navigate for non-technical users


Rails Back End

- [ ] Database migrations are managed well, database schema is well planned and executed
- [ ] Facades read/write data from Models and Services as appropriate


__If the above criterea is met, below are additional points to achieve a 4__

- [ ] Optimization techniques implemented in all repos

- Travis-CI deploys to Heroku
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2
    
 - Private methods in classes are used as appropriate
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Sercive 2

- Bootstrap is utilized well for layout and styling
    - [ ] Rails Front End
    

### Testing

Each Repo meets the following:

- 50% or more test coverage of happy path expectations
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Service 2
- 75% or more test coverage of happy path expectations
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Service 2
- 90% or more test coverage, includes happy path and sad path expectations
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Service 2

__If the above criterea is met, below are additional points to acheive a 4__

Rails Front End
- [ ] API calls to backend, and OAuth, are tested using mocks/stubs
- [ ] 95% or more test coverage, every application feature and back-end endpoint has at least one sad path test

Rails Back End
- [ ] API calls to micro-services are tested using mocks/stubs
- [ ] 95% or more test coverage, every application feature and back-end endpoint has at least one sad path test

Microservice 1
- [ ] calls to external API services are tested using mocks/stubs
- [ ] 95% or more test coverage, every application feature and back-end endpoint has at least one sad path test

Microservice 2
- [ ] calls to external API services are tested using mocks/stubs
- [ ] 95% or more test coverage, every application feature and back-end endpoint has at least one sad path test


### Presentation and Documentation

Slide Presentation
- [ ] Outlines MVP of the project
- [ ] Discusses end users, persona analysis
- [ ] Discusses technical design choices made

__Choose either Live Demo or Video Presentation to Complete:__ 

- [ ] Team members who are not part of the demo/presentation, participate in Q&A

    Live Demo
    - [ ] End-to-end demo on localhost
    - [ ] End-to-end demo in production

    Video Presentation
    - [ ] Team has prepared a demonstration video
    - [ ] Video displays end-to-end application demo of happy path
    - [ ] Video discusses persona analysis and user empathy
    - [ ] Video discusses service-oriented architecture

README and Documentation

Each Repo's ReadMe meets the following:
- [ ] links to other repos & production links
- [ ] contain a list of contributors, their GitHub profiles and LinkedIn profiles
- [ ] discuss the purpose of its repo's existence and how it fits into the project SOA
- [ ] how to install and test the repo
    
Rails front-end
- [ ] has screenshots
- [ ] discusses OAuth

    
Rails back-end
- [ ] includes database schema
- [ ] each endpoint is documented with example request & response

README for Microservices:
  - [ ] each endpoint exposed to the back-end
  - [ ] its use of external service API

__If the above criterea is met, below are additional points to acheive a 4__

Demo or Presentation
- [ ] ENV variables are changed on Heroku to point to invalid backend/services or API keys; front-end shows a user-friendly error scenario

Documentation
- A Postman collection JSON file is included in the following repos(except for any portion which needs OAuth)
    - [ ] Rails Back End
    - [ ] Micro-Service 1
    - [ ] Micro-Service 2

- Explains user personas and exhibits user empathy
    - [ ] Rails Front End

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
