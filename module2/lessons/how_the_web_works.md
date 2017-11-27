---
title: How the Web Works
length: 60
tags: http, dns, servers, rack
---

### Learning Goals

* Describe how DNS lookup works.
* Identify the parts of an HTTP request.
* Identify the parts of an HTTP response.
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
* What are the parts of an HTTP request and response?

### Share & Diagram

Based on the homework from the night before, the diagram should include:

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

### Parts of a URL

A URL can be split into distinct parts:

* Protocol: `http://` - Tells us the application protocol we will be using to interact on the web.
* Domain: `task-manager.herokuapp.com` - Tells us where the resources we are trying to access are located (tied to an IP address using DNS).
* Path: `/task/new` - The specific path for the resources that we are trying to access at that location.
* Query String: `?title=New&task=Task` - Params that give our server additional information about what we would like to access.
* Fragment Identifier: `#new_form_anchor` - An indicator of a specific section of a website we would like to view (e.g. if there is an anchor tag tied to a heading half way down the page). This can be seen by visiting [this](http://guides.rubyonrails.org/active_record_querying.html#array-conditions) link to the rails docs which references the `array-conditions` section of the Query Interface page.

### cURL

#### curl google.com

Enter `curl google.com -v` in a terminal window and review the output.

```
* Rebuilt URL to: google.com/
*   Trying 2607:f8b0:400f:800::200e...
* Connected to google.com (2607:f8b0:400f:800::200e) port 80 (#0)
> GET / HTTP/1.1
> Host: google.com
> User-Agent: curl/7.43.0
> Accept: */*
>
< HTTP/1.1 301 Moved Permanently
< Location: http://www.google.com/
< Content-Type: text/html; charset=UTF-8
< Date: Thu, 31 Aug 2017 01:09:30 GMT
< Expires: Sat, 30 Sep 2017 01:09:30 GMT
< Cache-Control: public, max-age=2592000
< Server: gws
< Content-Length: 219
< X-XSS-Protection: 1; mode=block
< X-Frame-Options: SAMEORIGIN
<
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
* Connection #0 to host google.com left intact
```

The `>` symbols indicate part of the request. The `<` symbols indicate part of the response. Notice:

* Request
    * The request  line with a verb, URI, and HTTP protocol.
    * The headers providing a host, agent, and an indication of the type of response the client will accept.
    * Empty body.
* Response
    * The status line with an HTTP protocol, the status code and reason phrase.
    * Headers.
    * A Body with HTML.

Sending a `curl` request to https://google.com will provide the actual site that is displayed when we visit google in a browser.

#### curl Student Site

Send a `curl` request to a student personal site. Note many of the same pieces from the request/response above, with slightly more HTML. Also note, the CSS is not in any way included in the response when you make a request to a student site (unless they used inline CSS). In order to get a CSS file we need to make a second request to something like `https://username.github.io/main.css`.

### Questions

* What are the parts of an HTTP request?
* What are the parts of an HTTP response?
* Why do we need the DNS system?
* What is the purpose of the different parts of a URL?
