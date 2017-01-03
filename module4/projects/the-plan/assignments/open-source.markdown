---
layout: page
title: Getting Started with Open Source
---

During our last sprint we'd like to solidify your place as contributors to the world of open source.

## Big Picture

* Goals of Open Source
* What Open Source won't do for you
* Protocols
* Your Goals
* Picking the Right Project

## Expectations

* Work solo or in pairs (not with a person in your primary project)
* Reproduce and confirm or contradict one bug report
* Submit one sizable/difficult or two smaller/moderate code-centric pull requests that are worth merging
* Submit one documentation patch (README, CONTRIBUTING, code documentation, etc)
* Write a single blog post that explains the whole process
* Have the blog post in your M4 portfolio (Individual Work)

## Getting Started

### Your Goal Setting

What's your goal in the work? Some ideas:

* I want to practice high-performance Ruby
* I want to help a non-profit that I believe in
* I want a potential employer/fancy person to notice me
* I would like to experiment with a new language/framework

### Pair or Solo?

Make a decision / find a pair.

### Pitch Projects -- WITH AN "S"

Your first idea will probably be a bad one. This afternoon, put together three pitches and we'll help you pick the best one.

Each pitch should be like this:

```
## Contributing to VCR

* Why: I use VCR regularly in projects, am interested in HTTP details, and would like to dig in deeper.
* What: I found a feature request at http://github.com/vcr/vcr/issues/1 that sounds approachable. It asks for VCR requests to add support for the X-AUTH header.
* I Need: to dig into VCR and get the dev setup running locally. I need to read about X-AUTH to understand more about how it's used and the format.
* When I'm Done: In the original GitHub issue it sounds like the developers are in favor of the feature, so I think I can get this accepted for the next version of the library.
```

**Post your three pitches in a Gist and put the link in your cohort channel by 8AM tomorrow.**

You're encouraged to look at each other's for ideas, inspiration, and collaboration opportunities.

### Finding Projects

How do you find a good project to work on?

* Small (fewer than 50 contributors)
* Active Development (last merge to master within 30 days)
* Responsive/Maintained (issues/PRs aren't piling up "stale", show conversation)
* Approachable (small libraries are better than big frameworks)

You can brainstorm your own list, but here are places to find ideas:

* [CodeTriage](https://www.codetriage.com/)
* [Issue Hub](http://issuehub.io/?label%5B%5D=help+wanted&language=ruby)

And here are a few concrete ideas:

* [Faker Gem](https://github.com/stympy/faker)
* [VCR Gem](https://github.com/vcr/vcr)
* [Figaro](https://github.com/laserlemon/figaro)
* [Slack-Ruby-Client](https://github.com/slack-ruby/slack-ruby-client)
* [Faraday](https://github.com/lostisland/faraday)
* [Launchy](https://github.com/copiousfreetime/launchy)
* [MrSpec](https://github.com/JoshCheek/mrspec)
* [Adding to / Improving Ruby's Documentation](http://documenting-ruby.org/) (harder than you think)

### Finding an Issue/Idea

* You're *not* expected to be dreaming up new features
* Fixing and refactoring are generally better than adding new functionality when you first start contributing to a repo
* Read through the posted Issues and you'll likely find feature requests/ideas. Take note of any tags used by the repo maintainers
* Non-Code contributions are always appreciated - documentation is hard. Update the README with any set up instructions that you went through that weren't in it already, make spelling and grammar fixes.

### Protocol Notes

* Consider reaching out to individual contributors via email or twitter
* Read the `README.md` and the `CONTRIBUTING.md` if there is one
* Keep track of your steps (anything need updating in the README?)
* Read at least five issue threads
* *Start by trying to reproduce a reported bug*
* Join the conversation first -- you don't want your first post to be "here's a pile of code!"
* Avoid introducing new dependencies to a project (i.e. gems, node modules, etc)
* Work on a branch that is well named, off of a fork of the repo
* Be conscious and clean with your git commits and squash any commit that says 'WIP'
* Look for tools they use (CI, code style review with Code Climate, etc) and use them yourself to highlight any issues

### Submitting the PR

* Once work is done, make sure to get the latest master from the repo and merge it into your branch and rerun tests and manual QA
* Ask a peer or mentor to review your work
* Submit a pull request with your changes.
  * Reference the issue if there is one related.
  * Make sure your pull request comment includes what the change is, why you made it. Give the repo owner any information they need to merge the pull request up front.
  * Consider @-tagging the mentor you had review your work in the PR so they can leave feedback
* Brace yourself to receive PR comments and suggestions
* Make changes as they are requested
  * make sure newest master is merged into your local branch, rerun tests, manual QA
  * push the changes to your remote branch
  * tag the person who requested the changes to review them.

## Reminders

* Don’t be afraid
* No one should make fun of your code. If they do, they are jerks
* You will likely get feedback and suggestions - or polite rejections if the code doesn’t fit with the repo owner’s style or goals
* Be ready to try several issues/ideas and maybe even more than one project before you find one you can fix and feel confident in PRing
