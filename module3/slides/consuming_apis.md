# Consuming an API

---

# Today's Agenda

* Warm Up
* Lesson Goals
* User Story
* Go over what will be need to complete the user story & read some documentation
* Small group exercise to implement concepts
* Review of exercise/Questions

---

# Warmup

* How does a developer interact with an API?
* What are the benefits of using an API?

---

# Goals

* Set up & Configure Faraday within our Rails Application
* Use Faraday to connect to and retrieve information from a 3rd party external API
* Parse the information retrieved from the API

---

# User Story

```
As a user
When I visit "/"
And I select "Colorado" from the dropdown
And I click on "Locate Members of the House"
Then my path should be "/search" with "state=CO" in the parameters
And I should see a message "7 Results"
And I should see a list of the 7 members of the house for Colorado
And I should see a name, role, party, and district for each member
```

---

# What to use to accomplish this user story?

* Faraday
* Figaro
* Propublica API

---

# Faraday

* Using the documentation answer the following
  - How do we make a `get` request?
  - How do we include headers in our request?
  - How do we include params?
  - How do we include a body?

---

# Faraday Continued

```
conn = Faraday.new(
  url: 'http://sushi.com',
  params: {param: '1'},
  headers: {'Content-Type' => 'application/json'}
)
```

```
resp = conn.get('search') do |req|
  req.params['limit'] = 100
  req.body = {query: 'salmon'}.to_json
end
```
---

# Third Party API Research

* Propublica API: https://projects.propublica.org/api-docs/congress-api
* Does this API require authentication?
    * If yes, how do you authenticate?
* What other information can you gather from the documentation?

---

# Reading API Docs

* Is it free?
* Does it require authentication?
  * Is it sent in the headers, parameters, or body?
* Does it have the information that I'm looking for?
* Does it have an example of how to send a request?
* Does it have an example of the response?

---

# Figaro

* Gem used to prevent us from pushing up our API keys
* Uses environment variables
    * Environment Variables are part of the process running the program, rather than part of the program itself.

---

# Putting it all Together
