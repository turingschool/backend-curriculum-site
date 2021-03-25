---
title: Intro to content delivery networks (CDN)
layout: page
---

## Where are our assets being served from?
1. Open up a deployed Rails application on Heroku with a frontend.
2. Open up your console and click on the network tab. 
3. Reload the page and look at the list of assets that are being loaded into your application. 
4. Take a close look by clicking on one of the items and checkout the meta data. 
5. What do you see? Where are your assets being served from? Take note! This will be important for later.  


## What is a CDN?
1. Simply put, it’s a globally distributed network of servers.
2. The content that is served from these servers is replicated throughout the entire network. This allows the content that is needed by a web request is available at all places at once. 
3. In some cases, the client requesting the content  will access everything from the nearest physical location to them. This helps in getting the content back to them as quickly as possible. 

## What do we use CDNs?
If you only have aa single point of failure when attempting to access important assets, it could create many problems for your application. We want to make sure that all users are accessing the assets that make your application’s experience amazing. 

## Benefits of using a CDN
* Users always want a faster downloading experience. Having a data center that is closer to the user will more than likely be faster than one that exists in another city across the world. 
* You can configure the CDN to only serve certain types of assets. This means it could only serve CSS, JS, or even images. You can decide! 
* A CDN can prevent a single source of failure if someone attempts to attack your application. This means that if you have many replicated versions of your assets, you can still serve those to your users if one server goes down. 
* More evenly distributed traffic coming from around the world.

## Even more benefits!
* Reducing bandwidth costs
* Improving page load times
* Increase uptime of necessary content for your application
* Lower load on your servers
* Increase reliability and more uptime
* Some CDN’s could provide data analytics for your company
* Benefits include a focus on a mobile-first approach to building applications

## Let’s try things out ourselves
1. Open up an older Rails application of yours with a frontend. 
2. Open up the link below and follow the directions of how to set one up. 
3. When you’re finished, you’ll see in your network tab in the console that your assets will be pointing to Amazon’s CloudFront service instead of your Heroku instance. 

[Using Amazon CloudFront CDN](https://devcenter.heroku.com/articles/using-amazon-cloudfront-cdn)
