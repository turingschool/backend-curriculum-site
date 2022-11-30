---
layout: page
title: Fundamental Rails Security
length: 180
tags: rails, pivot, security
---

## Learning Goals

* Understanding the importance of security in software development
* Learning how to avoid common security exploits
    * Privilege escalation
    * Mass Assignment
    * Cross-site Scripting

## Setup Prior to Class

* Set up [OregonSale](https://github.com/turingschool-examples/store_engine) prior to class. There won't be time for us to set up during class. Look at the `README` for details.
* Download the [Postman App](https://www.getpostman.com/)

`$ git clone https://github.com/turingschool-examples/store_engine.git fundamental_security`

## Structure

* Warmup
* Share
* Exploit an Existing Application
* Share
* Review Prevention Tools

## Warmup

Get into groups of three and assign each person a number.

* Person 1 will research Privilege Escalation.
* Person 2 will research Mass Assignment.
* Person 3 will research Cross Site Scripting.

Each person will complete the task below on their topic.

* Draft a high level definition of the security exploit.
* Provide an example of how we might expose ourselves to this exploit in a Rails application.
* Provide an example of steps we might take to prevent this exploit.

Share with your group, then we will share with the class.

## Attempting an Exploit

In your group, using only tools available to a visitor to your page, see if you can do the following:

* Mass Assignment
    * Create an account and some orders associated with that account in the browser.
    * Using Postman or cURL:
        * change the total for that order to $0.
        * change the status of an order.
        * delete an order
* Mass Assignment/Privilege Escalation
    * See if you can find a way to access admin functionality.
    * *Tip:* where might you be able to set a users role?
* Cross-Site Scripting
    * Adjust the application so that users can use HTML in their comments (e.g. bold certain words, include links, etc.).
    * Create a comment that shows a pop-up message each time users visit a page with that comment on it.
    * *Tip:* `<script>` tags will allow you to embed JavaScript directly into a page. Look into the JavaScript `alert` function.
    * Try to see if you can make other adjustments to the site (e.g. make the body fade out, make item titles bigger/change their color, make buttons blink)

## Prevention

One tool that you can use to help identify vulnerabilities is [Brakeman](https://github.com/presidentbeef/brakeman). Install that now:

```
gem install brakeman
```

This will allow us to run the command `brakeman` from our command line. This should give us a list of potential security vulnerabilities.

One note: Brakeman is a static analysis tool. At a high level, this means that Brakeman will look at our code and report on what it finds. It *will not* monitor traffic to our site or notify us of suspicious activity.

## Things to Remember

* Be suspicious of any class method in a controller.
* Scope all queries to a trusted object, like the current user.
* Be careful with your order of operations, don’t change any data until you've found a specified record.

## Supporting Materials

* [Tutorial](http://tutorials.jumpstartlab.com/topics/architecture/fundamental_security.html)
* [Notes](https://drive.google.com/open?id=0B4C6lfVKu-E7V2F1SzRlQl8wRUk)
* [Slides](https://drive.google.com/open?id=0B4C6lfVKu-E7UGxzdHYyNFBFTVU)
* [Video 1502](https://vimeo.com/129022094)
