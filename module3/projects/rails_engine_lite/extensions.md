---
layout: page
title: Rails Engine Lite Extensions
length: 1 week
tags:
type: project
---

Once your Rails Engine project is complete, you may choose any of the following extensions for additional points:

- Complete all of the find_one/find_all endpoints (Part 2)
- Complete all of the "edge cases" tests and see if you can get the entire test suites to pass for both Part 1 and Part 2.
- Implement pagination for `GET /api/v1/items` and `GET /api/v1/merchants`. 
  These Endpoints should: 
    * render a JSON representation of all records of the requested resource, one "page" of data at a time
    * allow for the following OPTIONAL query parameters to be sent by the user:
    * `per_page`, an integer value of how many resources should be in the output; defaults to 20 if not specified by the user
    * `page`, an integer value of a "page" of resources to skip before returning data; defaults to 1 if not specified by the user
    * do not use any third-party gems for pagination

    Example use of query parameters:

    * `GET /api/v1/items?per_page=50&page=2`
    * `GET /api/v1/merchants?per_page=50&page=2`

    This should fetch items 51 through 100, since we're returning `50` per "page", and we want "page `2`" of data.
    If a user tries to fetch a page for which there is no data, then `data` should report an empty array.
