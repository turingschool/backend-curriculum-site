# Sessions, Cookies, & Flashes

---

# Warmup

* You've already been using the `flash` hash in your Rails projects. What does it do?
* What do you remember about the HTTP request/response cycle? What are the main parts of an HTTP request? An HTTP response?

---

# HTTP Review

* Request/Response
* Clone *[Cookie Practice](https://github.com/s-espinosa/cookie_practice)*
* `bundle`
* `rake db:create db:migrate db:test:prepare`
* Open `127.0.0.1:3000/horses` in the browser
* `curl 127.0.0.1:3000/horses -v`

---

# Cookies

* Tool to maintain state between requests
* EditThisCookie
* `curl 127.0.0.1:3000/horses -v -c cookies`
* In the `horses#index`: `cookies[:message] = "It's a cookie!"`
* `curl 127.0.0.1:3000/horses -v -c cookies -b cookies`
* Open in the browser

---

# Sessions

* Additional security to prevent user from tampering with the information stored in the cookie
* `session[:message] = "It's a session!"`
* Open in the browser

---

# Flashes

* In the `horses#index`: `flash[:message] = "It's a flash!"`
* Try the different query params available in the `horses#show` in the browser

---

# Additional Notes

* Can't store an object in your cookies/sessions/flashes
* Information is stored as strings (even numbers)

---

# Summary

* *Cookie:* Way to maintain state over HTTP
* *Session:* Special cookie with some protection against user tampering
* *Flash:* Self deleting part of the session
