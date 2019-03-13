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

A URL allows us to send data to, or retrieve, a "resource" on the Internet. A resource could be a page of HTML content, it could be an image or music file, or it could be part of a web application that will save data you send to it.

#### URL vs URI

You may also hear the term "URI" when talking about things on the Internet. A "URI", or "Universal Resource Identifier" is not the same as a URL, but it's easy to confuse them.

A URI is part of a URL. See below:


### Parts of a URL

A URL can be split into distinct parts:

* Protocol: `http://` - Tells us the application protocol we will be using to interact on the web.
* Domain: `task-manager.herokuapp.com` - Tells us where the resources we are trying to access are located (tied to an IP address using DNS).
* Path: `/task/new` - The specific path for the resources that we are trying to access at that location.
* Query String: `?title=New&task=Task` - Params that give our server additional information about what we would like to access.
* Fragment Identifier: `#new_form_anchor` - An indicator of a specific section of a website we would like to view (e.g. if there is an anchor tag tied to a heading half way down the page). This can be seen by visiting [this](http://guides.rubyonrails.org/active_record_querying.html#array-conditions) link to the rails docs which references the `array-conditions` section of the Query Interface page.

The "Domain", "Path", and "Query String" combined indicate a unique "identifier" for a resource, and all three of these pieces are a "URI".


## HTTP Requests and Responses

The HyperText Transfer Protocol gives us rules about how messages should be sent around the Internet. The system that initiates a connection sends a "request", and the system the answers sends a "response".

### HTTP Request

When a "client" (like a web browser) retrieves information, it sends a payload of data to a server as a "request". This request is made up of three main parts:

- A Request line, containing three piece of information:
  - the HTTP method (also called a "verb") for sending or retrieving information
  - the URI "path" of the resource where we're sending or retrieving information
  - the version of the HTTP protocol our "client" software is using

- Headers, which is a key/value pair, which contain supplimental information about our request

- An optional body; we only send data to the server in the body when we are creating or modifying something


### HTTP Response

When the server or web application is finished processing our request, it will send back a response which is a payload of data, and is made up of three main parts:

- a Status line, containing three pieces of information:
  - The version of the HTTP protocol that this response is using
  - a 3-digit numeric "status code"
  - a user-friendly string description of what the "status code" means

- Headers, also sent as key/value pairs similar to the HTTP request

- An optional body; almost all responses will contain additional data in the body. In mod 2, our "body" payload will almost always be HTML.

## Seeing HTTP requests and responses in action

Let's open a terminal and run some commands to connect to Google's home page.

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

The `>` symbols indicate part of the request being sent to the server. The `<` symbols indicate the response coming back to our system. Notice:

* Request
    * The request line with a verb, URI path, and HTTP protocol.
    * The headers providing a host, user agent (identifying the browser or client software), and an indication of the type of response the client will accept.
    * Empty body.
* Response
    * The status line with an HTTP protocol, the status code and reason phrase.
    * Headers.
    * A Body with HTML.

Sending a `curl` request to https://google.com will provide the actual site that is displayed when we visit google in a browser.

#### curl Student Site

Send a `curl` request to a web site of your choice. Note many of the same pieces from the request/response above, with slightly more HTML. Also note, the CSS is not in any way included in the response when you make a request to a student site (unless they used inline CSS). In order to get a CSS file we need to make a second request to something like `https://username.github.io/main.css`.

### Questions

* What are the parts of an HTTP request?
* What are the parts of an HTTP response?
* What is the purpose of the different parts of a URL?
