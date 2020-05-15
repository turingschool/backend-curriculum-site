# Consuming an API

---

# Warmup

* What is Postman and what is the benefit of using it?
* What is Faraday and why would you use it?

---

# Today's Goals

* Set up & Configure Faraday within our Rails Application
* Use Faraday to connect to and retrieve information from a 3rd party external API
* Parse the information retrieved from the API

---

# Tools

* Faraday
* Figaro
* Propublica API

---

# Faraday

```ruby
conn = Faraday.new(
  url: 'http://sushi.com',
  params: {param: '1'},
  headers: {'Content-Type' => 'application/json'}
)
```

```ruby
resp = conn.get('search') do |req|
  req.params['limit'] = 100
  req.body = {query: 'salmon'}.to_json
end
```
---

# Third Party API Research

* (Propublica API)[https://projects.propublica.org/api-docs/congress-api/]
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
