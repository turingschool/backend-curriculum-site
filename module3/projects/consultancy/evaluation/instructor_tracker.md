# Instructor Tracker for Consultancy Project

Copy to a gist, share with your team, edit during standups so the team can see progress towards scores. You could break each portion into a separate section in your gist as well if you so desired.


## Evaluation at a High Level

Project evaluation will be done on a continual basis through check-ins and the final evaluation. Teams will have checkbox items to complete. To achieve a 3 (_meets expectations_) in each category, all checkboxes for the 4 criteria should be completed.

Typically, scores higher than 3.0 will be for going "above and beyond" expectations, learning tools and implementing concepts we don't teach in class. Each category has specific criteria to help guide the "above and beyond" goals.

However, we will not reward "heroics". Staying up late, pulling all-nighters, is not what this project is about. We're here to work together as a team, and solo efforts will generally be discouraged by your project managers.


---

## Feature Delivery

Each Repo meets the following:

- 50% or more MVP stories are completed
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Microservice 1

Rails Front End
- [ ] 100% or more MVP stories are completed
- [ ] OAuth works error-free in incognito/private

Rails Back End
- [ ] Proxy for Rails Front End and Micro-Services

__When the above criteria is met, here are additional points to achieve a 4__

- Additional Stories/Features implemented above MVP
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Microservice 1

- Exposed API routes utilize more than one version (ie, an endpoint exists as both /v1/ and /v2/ that do something slightly different)
    - [ ] Rails Back End
    - [ ] Microservice 1

- Rails Front End
    - [ ] Professional quality HTML and CSS, color palette is pleasing and suitable to the target audience
    - [ ] Application works in multiple browsers (Chrome, Safari, Firefox, etc)

---

## Technical Quality

Each Repo meets the following:

- Code follows DRY and SRP design
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Microservice 1

- Routes follow RESTful patterns (PMs have some discretion here)
    - [ ] Rails Front End, User-facing routes are friendly (not necessarily RESTful)
    - [ ] Rails Back End
    - [ ] Microservice 1

- Optimization technique is implemented in one of the following:
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Microservice 1

- Controllers utilize Facades
    - [ ] Rails Front End
    - [ ] Rails Back End

- Facades utilize Service calls to store/retrieve data
    - [ ] Rails Front End
    - [ ] Rails Back End

- Good serialization patterns are implemented to return JSON
    - [ ] Rails Back End
    - [ ] Microservice 1

- Exposed API routes are versioned well
    - [ ] Rails Back End
    - [ ] Microservice 1

- Facades, Services, and/or Serializers use 100% class methods so instantiation is unnecessary
    - [ ] Rails Back End
    - [ ] Microservice 1

- Deploy to Heroku
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Microservice 1

- Travis CI is set up
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Microservice 1


Rails Front End

- [ ] No data storage (models, database schema, etc) is done at this layer; sessions and caching are the exception
- [ ] Application is easy to navigate for non-technical users


Rails Back End

- [ ] Database migrations are managed well, database schema is well planned and executed
- [ ] Facades read/write data from Models and Services as appropriate

__When the above criteria is met, here are additional points to achieve a 4__

- [ ] Optimization techniques implemented in all repos

- Travis-CI deploys to Heroku
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Microservice 1

- Private methods in classes are used as appropriate
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Microservice 1

- Bootstrap is utilized well for layout and styling
    - [ ] Rails Front End

---

## Testing

Each Repo meets the following:

- 50% or more test coverage of happy path expectations
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Microservice 1

- 75% or more test coverage of happy path expectations
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Microservice 1

- 90% or more test coverage, includes happy path and sad path expectations
    - [ ] Rails Front End
    - [ ] Rails Back End
    - [ ] Microservice 1


__When the above criteria is met, here are additional points to achieve a 4__

Rails Front End
- [ ] API calls to backend, and OAuth, are tested using mocks/stubs
- [ ] 95% or more test coverage, every application feature has at least one sad path test

- 95% or more test coverage, every exposed API endpoint and microservice call has at least one sad path test
    - [ ] Rails Back End
    - [ ] Microservice 1

- API calls to micro-services or external services are tested using mocks/stubs
    - [ ] Rails Back End
    - [ ] Microservice 1


---

## Presentation and Documentation

__Choose either Live Demo or Video Presentation to Complete:__

- [ ] Team members who are not part of the demo/presentation, participate in Q&A

- Live Demo
    - [ ] End-to-end demo on localhost
    - [ ] End-to-end demo in production

- Video Presentation
    - [ ] Team has prepared a demonstration video
    - [ ] Video displays end-to-end application demo of happy path
    - [ ] Video discusses persona analysis and user empathy
    - [ ] Video discusses service-oriented architecture


Slide Presentation
- [ ] Outlines MVP of the project
- [ ] Discusses end users, persona analysis
- [ ] Discusses technical design choices made


README and Documentation

Each Repo's README meets the following:
- [ ] links to other project repos & production links
- [ ] contains a list of contributors, their GitHub profiles and LinkedIn profiles
- [ ] discusses the purpose of its purpose (how it fits into the project SOA)
- [ ] discusses how to install and test the repo

Rails front-end README:
- [ ] has screenshots
- [ ] discusses OAuth

Rails back-end README:
- [ ] includes database schema
- [ ] each endpoint is documented with example request & response

Each of the Microservices READMEs:
  - [ ] each endpoint exposed to the back-end
  - [ ] its use of external service API

__When the above criteria is met, here are additional points to achieve a 4__

Demo or Presentation
- [ ] ENV variables are changed on Heroku to point to invalid backend/services or API keys, or backend services are somehow taken offline; front-end shows a user-friendly error scenario

Documentation
- A Postman collection JSON file is included in the following repos(except for any portion which needs OAuth)
    - [ ] Rails Back End
    - [ ] Microservice 1

- Explains user personas and exhibits user empathy
    - [ ] Rails Front End
