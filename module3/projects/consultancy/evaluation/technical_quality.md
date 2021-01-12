---
layout: page
title: Consultancy - Evaluation
type: project
---

### Technical Quality

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

---

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
