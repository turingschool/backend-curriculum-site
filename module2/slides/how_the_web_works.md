autoscale: true

# How the Web Works

## The Hour Version

---

# Warmup

* What happens when you enter an address into your nav bar and hit return? Be as specific as possible and draw a diagram.
* What do the following acronyms mean?
    * DNS
    * ISP
    * IP
    * HTTP
    * HTML
    * CSS
    * W3C
* What are the parts of an HTTP request and response?

---

Share & Diagram

---

# cURL

* `curl google.com -v`
* `curl` to a student personal site

---

# Parts of a URL

* Protocol: `http://`
* Domain: `task-manager.herokuapp.com`
* Path: `/task/new`
* Query String: `?title=New&task=Task`
* Fragment Identifier: `#new_form_anchor`

---

# What is a Server Anyway?

* Physical Box
* Apache, NGINX
* Puma, Thin, Unicorn, Webrick

---

# How Do Our Apps Connect

* Rack
    * Requires a method `#call`
    * `#call` takes an argument `env` (e.g. `def call(env) ... end`)
    * `#call` returns an array with three values:
        * status
        * headers
        * body
* Rack Compatibile Frameworks
  * Sinatra
  * Rails
  * Lots of others
