# Turing School of Software and Design

## Site for the Back End Engineering Program

This site is built with Jekyll. Find the docs [here](https://jekyllrb.com/docs/usage/)

### Contributing

* Clone the repo `git clone git@github.com:turingschool/backend-curriculum-site.git`
* run `bundle install`
* You can now begin to edit the website.
* To start the server run `jekyll serve`.
* Navigate to `localhost:4000` to see the site

## Structure of the site and where to find the most important things:

You will find a module specific directory. eg `module1` and within each directory you will find a directory for `lessons` and `projects`. All files within this site can be written as either markdown or html. To link to each you just need to write the relative path to each file without the file extension. For example `lessons/lesson_on_stuff`.

Additionally each new file will need a header:

```markdown
---
title: Name of lesson
subheading: lesson is about stuff
layout: page
---
```

The `navigation.html` file is where you will find the sidebar for the site.

The `today.html` file is where you will find the basic html page for today, and each file for today will live within the `today` directory.
