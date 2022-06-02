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
    - [ ] Frontend
    - [ ] Rails Back End

Frontend
- [ ] 100% or more MVP stories are completed
- [ ] OAuth works error-free in incognito/private

Rails Backend
- [ ] Proxy for Frontend and Micro-Services

__When the above criteria is met, here are additional points to achieve a 4__

- Additional Stories/Features implemented above MVP
    - [ ] Frontend
    - [ ] Rails Back End

- Exposed API routes utilize more than one version (ie, an endpoint exists as both /v1/ and /v2/ that do something slightly different)
    - [ ] Rails Back End

- Frontend
    - [ ] Professional quality HTML and CSS, color palette is pleasing and suitable to the target audience
    - [ ] Application works in multiple browsers (Chrome, Safari, Firefox, etc)

---

## Technical Quality

Each Repo meets the following:

- Code follows DRY and SRP design
    - [ ] Frontend
    - [ ] Rails Back End

- Routes follow RESTful patterns (PMs have some discretion here)
    - [ ] Frontend, User-facing routes are friendly (not necessarily RESTful)
    - [ ] Rails Back End

- Optimization technique is implemented in one of the following:
    - [ ] Frontend
    - [ ] Rails Back End

- Controllers utilize Facades
    - [ ] Frontend

- Facades utilize Service calls to store/retrieve data
    - [ ] Frontend
    - [ ] Rails Back End

- Good serialization patterns are implemented to return JSON
    - [ ] Rails Back End


- Exposed API routes are versioned well
    - [ ] Rails Back End


- Facades, Services, and/or Serializers use 100% class methods so instantiation is unnecessary
    - [ ] Rails Back End


- Deploy to Heroku
    - [ ] Frontend
    - [ ] Rails Back End


- Travis CI is set up
    - [ ] Frontend
    - [ ] Rails Back End



Frontend

- [ ] No data storage (models, database schema, etc) is done at this layer; sessions and caching are the exception
- [ ] Application is easy to navigate for non-technical users


Rails Back End

- [ ] Database migrations are managed well, database schema is well planned and executed
- [ ] Facades read/write data from Models and Services as appropriate

__When the above criteria is met, here are additional points to achieve a 4__

- [ ] Optimization techniques implemented in all repos

- CircleCI deploys to Heroku
    - [ ] Frontend
    - [ ] Rails Back End


- Private methods in classes are used as appropriate
    - [ ] Frontend
    - [ ] Rails Back End


- Bootstrap is utilized well for layout and styling
    - [ ] Frontend

---

## Testing

Each Repo meets the following:

- 50% or more test coverage of happy path expectations
    - [ ] Frontend
    - [ ] Rails Back End


- 75% or more test coverage of happy path expectations
    - [ ] Frontend
    - [ ] Rails Back End


- 90% or more test coverage, includes happy path and sad path expectations
    - [ ] Frontend
    - [ ] Rails Back End



__When the above criteria is met, here are additional points to achieve a 4__

Frontend
- [ ] API calls to backend, and OAuth, are tested using mocks/stubs
- [ ] 95% or more test coverage, every application feature has at least one sad path test

- 95% or more test coverage, every exposed API endpoint and microservice call has at least one sad path test
    - [ ] Rails Back End


- API calls to micro-services or external services are tested using mocks/stubs
    - [ ] Rails Back End



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

Frontend README:
- [ ] has screenshots
- [ ] discusses OAuth

Rails back-end README:
- [ ] includes database schema
- [ ] each endpoint is documented with example request & response

__When the above criteria is met, here are additional points to achieve a 4__

Demo or Presentation
- [ ] ENV variables are changed on Heroku to point to invalid backend/services or API keys, or backend services are somehow taken offline; front-end shows a user-friendly error scenario

Documentation
- A Postman collection JSON file is included in the following repos(except for any portion which needs OAuth)
    - [ ] Rails Back End


- Explains user personas and exhibits user empathy
    - [ ] Frontend
