---
title: How the Web Works, DNS Edition
length: 60
tags: http, dns, servers, rack
---

### Learning Goals

* Describe how DNS lookup works.
* Describe the different ways we use the term `server`.

### Warmup

* What happens when you enter an address into your nav bar and hit return? Be as specific as possible and draw a diagram.
* What do the following acronyms mean?
    * DNS
    * ISP
    * IP
    * HTTP
    * HTML
    * CSS
    * W3C


### Share & Diagram

* The DNS lookup
    * Resolving Name Server
    * The Root
    * Top Level Domain Server
    * The Authoritative Name Server
* IP Address (IPv4 and IPv6)
    * IPv4 is an older version of IP address with 32 bits (represented as four numbers between 0 and 255).
    * IPv6 is a newer version with 128 bits (represented as eight hexadecimal numbers between 0000 and FFFF) developed because we were running out of IPv4 addresses (with all of our devices).
* HTTP Request
    * Request Line (with a verb and URI)
    * Headers
    * Optional Body
* HTTP Response
    * Status Line (with a status code and reason phrase)
    * Headers
    * Body
* Server
    * Physical computer (often in server farms)
    * Software running on that computer responding to different types of requests over the internet (Apache/NGINX)
    * Software running on that computer specifically responding to HTTP requests (Puma/Webrick/Unicorn)
* Rack
    * Middleware written in Ruby that allows us to create applications that return a status code, headers, and a body.
* Rails/Sinatra
    * Rack compliant frameworks that prepare responses to HTTP requests.


### Questions

* How do our computers turn domain names into connections to a server?
* Why do we need the DNS system?
* What is a "server"?
