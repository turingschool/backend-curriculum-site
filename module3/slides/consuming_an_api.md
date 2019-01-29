# Consuming an API

---

# Warmup

* What are the parts of an HTTP request?
* What are the parts of an HTTP response?

---

# Tools

* Faraday
* Figaro
* VCR

---

# Faraday

* Ruby library to make HTTP requests.
* Gem documentation [here](https://github.com/lostisland/faraday)

---

# With a Partner

* How do you send a simple `get` request with Faraday?
* What might be some advantages of a Connection object?
* How do you make different kinds of requests using Faraday (e.g. post, etc.)?
* How do you set headers using Faraday?
* How do you add information to the body of your request?
* In either `pry` or a `playground.rb` file, can you make a request to `https://api.chucknorris.io/jokes/random`

---

# Figaro

* Gem used to keep you from pushing your API keys to GitHub.
* Easy integration with Heroku.
* Documentation available [here](https://github.com/laserlemon/figaro)

---

# With a Partner

* What do you need to do to set up Figaro in your Rails project?
* What files are created/changed when you initially install Figaro?
* How do you access your API keys from within your Rails app when you use Figaro?
* How do you configure keys for different environments using Figaro?
* Why might you use different keys for a production/dev environment?
* How do you push your API keys to Heroku using Figaro?

---

# VCR

* Gem used to limit HTTP requests in specs.
* Documentation available [here](https://github.com/vcr/vcr)

---

# With a Partner

* How would you set VCR up in a Rails project?
* How does VCR know where to store your Cassettes?
* How do you create a new Cassette?

---

# Some Notes About APIs

* Different APIs will require different amounts of authentication.
    * None
    * Key
    * Payment
* APIs may require you to authenticate in different ways.
    * Sending keys in your headers.
    * Sending keys in the body of your request.
    * Exchanging a key for a token.
    * Others.

---

# Roadshow

