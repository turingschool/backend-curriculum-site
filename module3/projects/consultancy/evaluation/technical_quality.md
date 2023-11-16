---
layout: page
title: Consultancy - Evaluation
type: project
---
_[Back to Consultancy Home](../index)_ 

_[Back to Evaluation Index](./index)_ 

### Technical Quality

Each Repo meets the following:

- Code follows DRY and SRP design
    - [ ] Frontend
    - [ ] Rails Backend

- Routes follow RESTful patterns (PMs have some discretion here)
    - [ ] Frontend, User-facing routes are friendly (not necessarily RESTful)
    - [ ] Rails Backend

- Controllers utilize Facades
    - [ ] Frontend
    - [ ] Rails Backend

- Facades utilize Service calls to store/retrieve data
    - [ ] Frontend
    - [ ] Rails Backend

- Good serialization patterns are implemented to return JSON
    - [ ] Rails Backend

- Exposed API routes are versioned well
    - [ ] Rails Backend

- Facades, Services, and/or Serializers are used.
    - [ ] Rails Backend

- Deploy to the internet (using Render, Heroku, etc)
    - [ ] Frontend
    - [ ] Rails Backend


Frontend

- [ ] No data storage (models, database schema, etc) is done at this layer; user info, sessions and caching are the exception
- [ ] Application is easy to navigate for non-technical users


Rails Backend

- [ ] Database migrations are managed well, database schema is well planned and executed
- [ ] Facades read/write data from Models and Services as appropriate

---

__When the above criteria is met, here are additional points to achieve Exceed Expectations__


- Optimization technique is implemented in one of the following:
    - [ ] Frontend
    - [ ] Rails Backend

- CircleCI deploys to the internet (Heroku, Render, etc.)
    - [ ] Frontend
    - [ ] Rails Backend

- Private methods in classes are used as appropriate
    - [ ] Frontend
    - [ ] Rails Backend

