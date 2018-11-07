---
title: How the Web Works, HTTP Request/Response
length: 60
tags: http, servers
---

### Learning Goals

* Identify the parts of a URL
* Identify the parts of an HTTP request
* Identify the parts of an HTTP response

## What is "URL"

- "Universal Resource Locator"

A URL allows us to send data to, or retrieve, a "resource" on the Internet.

#### URL vs URI

You may also hear 

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
* What is the purpose of the different parts of a URL?
