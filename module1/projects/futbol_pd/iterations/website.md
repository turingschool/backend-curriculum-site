---
layout: page
title: Build a Website
---

_[Back to Futbol Home](../index)_

Creating a website will require you to explore some topics not covered in class or in previous projects. There are many different ways to achieve this goal, but we're going to recommend that you use Embedded Ruby (ERB) along with HTML and CSS to create a simple web page that includes the information that you gathered in your `StatTracker` class.

At a high level, you'll create an instance of `StatTracker` and then use the methods available on `StatTracker` in a template that you create to generate a web page dynamically. We should be able to run the following code from the terminal and see a web page with our data when you are finished.

```
ruby page_generator.rb
open site/index.html
```

In order to make this work it will likely help you to research:

* ERB
* HTML
* CSS

It might help you to know that ERB is used in Rails projects to generate HTML. You will want to make sure that you look for resources that describe how to use ERB *outside of* the Rails context.
