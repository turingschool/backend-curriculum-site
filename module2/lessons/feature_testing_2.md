---
title: Feature Testing with RSpec
layout: page
---

## Warm Up

- In SetList, what does a User do to visit the Songs index?
    - What actions do they take?
    - What do they click on?
    - What do they type?
- What does a user expect when visiting the Songs index?

## Setup

You can start this lesson by checking out the `feature_testing_practice`
 branch of this repo [here](https://github.com/turingschool-examples/set-list-7/tree/feature-testing-practice).

## Feature Testing

## What are Feature Tests?

- Feature tests mimic the behavior of the user: In the case of web apps, this behavior will be clicking, filling in forms, visiting new pages, etc.
- Just like a user, the feature test should not need to know about underlying code
- Based on user stories

## What are User Stories?

- A tool used to communicate user needs to software developers.
- They are used in Agile Development, and it was first introduced in 1998 by proponents of Extreme Programming.
- They describe what a user needs to do in order to fulfill a function.
- They are part of our "top-down" design.

```markdown
As a user
When I visit the home page
And I click on the link New Task
Then I see a form to create a task

And I fill in title
And I fill in description
And I click submit
Then my task is saved
```

We can generalize this pattern as follows:

```markdown
As a [user/user-type]
When I [action]
And I [action]
And I [action]
...
Then [expected result]
```

Depending on how encompassing a user story is, you may want to break a single user story into multiple, smaller user stories.

## Feature Testing Tools: Capybara

[Capybara](https://github.com/teamcapybara/capybara#using-capybara-with-rspec) is a Ruby test framework that allows you to feature test any RACK-based app.

It provides a DSL (domain specific language) to help you query and interact with the DOM.

For example, the following methods are included in the Capybara DSL:

- `visit '/path'`
- `expect(current_path).to eq('/')`
- `expect(page).to have_content("Content")`
- `within ".css-class" { Assertions here }`
- `within "#css-id" { Assertions here }`
- `fill_in "identifier", with: "Content"`
- `expect(page).to have_link("Click here")`
- `click_link "Click Here"`
- `expect(page).to have_button("Submit")`
- `click_button "Submit"`
- `click_on "identifier"`

## Always, Always, Always, Write Tests First

As usual, we are going to TDD our applications. There are two approaches we could take here:

1. Bottom Up: Start with the smallest thing you can build and work your way up. In the context of a web app, this means you start at the database level (model tests).
2. Top Down: Start at the end goal and work your way down. In the context of a web app, this means you start by thinking about how a user interacts with the application (feature tests).

Both are valid approaches. We are going to work Top Down.

## Testing the Songs Index

Thinking back to the warmup, let's write a user story for our Songs index:

```markdown
As a user,
when I visit '/songs'
I see each song's title and play count
```

First, let’s make a directory for our feature tests:

```bash
$ mkdir spec/features
```

And a directory for all features related to `songs`: 

```bash
$ mkdir spec/features/songs
```

Finally, create your test file: 

```bash
$ touch spec/features/songs/index_spec.rb
```

The names of the files you create for feature testing MUST end in `_spec.rb`. Without that 'spec' part of the filename, RSpec will completely ignore the file. Feature tests also MUST go in the features folder else Capybara will NOT work.

How many tests should go in one file? It's totally up to you, but having multiple tests in a file is marginally faster than putting a single test in a single file. Also, grouping lots of tests into one file allows you to share the setup across your tests.

You can group your test files into subfolders to organize them in a similar format to your `/app/views` folder, and can help with strong organization. Every team you work on, every job you have, could have a completely different organizational method for test files, so keep that 'growth mindset' and be flexible!

```markdown
/spec
/spec/features
/spec/features/songs
/spec/features/songs/index_spec.rb
/spec/features/songs/user_can_see_all_songs_spec.rb
/spec/features/songs/user_can_see_one_song_spec.rb
etc
```

**spec/features/songs/index_spec.rb**

```ruby
require 'rails_helper'

RSpec.describe "songs index page", type: :feature do
  it "can see all songs titles and play count" do
    song_1 = Song.create(title:       "I Really Like You",
                         length:      208,
                         play_count:  243810867)
    song_2 = Song.create(title:       "Call Me Maybe",
                         length:      199,
                         play_count:  1214722172)

    visit "/songs"

    expect(page).to have_content(song_1.title)
    expect(page).to have_content("Play Count: #{song_1.play_count}")
    expect(page).to have_content(song_2.title)
    expect(page).to have_content("Play Count: #{song_2.play_count}")
  end
end
```

## Routing Exceptions: Failing Loudly

As of Rails 7.1, testing configuration has changed a bit in a default Rails application. In the above example, we visit the `/songs` path. If we don't have that route created yet, we would expect that test to fail at that line to indicate to us that we need to create that route. However, with the new default Rails settings, that test wouldn't fail until it gets to the expectation below it to assert that the `song_1` title appears on the page. 

Especially as you're learning about Rails, this configuration can cause a bit of confusion. How can we successfully visit a path that doesn't yet exist?! If you, like us, would rather see your test fail when Capybara tries to visit a route that doesn't exist, you can make a quick fix in your configuration!

In your `config/environments/test.rb` file, you should see this line at about line 32: 
```
config.action_dispatch.show_exceptions = :rescuable
```

In order to see your route issue fail loudly and more clearly, change that line to:
```
config.action_dispatch.show_exceptions = :none
```

Now, if you run the above test and have not yet made that route, you should see this failure:
```
Failures:

  1) songs index page can see all songs titles and play count
     Failure/Error: visit "/songs"
     
     ActionController::RoutingError:
       No route matches [GET] "/songs"
```

You are not required to make this change, but we think this setting allows for better understanding of the error, and a clearer indication of the next step in the TDD flow. 

## Practice

Write a test for the following user stories. Then, use TDD to implement the feature.

```markdown
Practice User Story 1

As a user
When I visit the songs index ("/songs")
Then I see a header "All Songs"
```

```markdown
Practice User Story 2

As a user
When I visit a Song show page
Then I see the song's title, length, and play count
```

```markdown
Practice User Story 3

As a user
When I visit a Song show page
I see a link back to the songs index page
When I click this link
Then I am taken to the songs index
```

## Checks for Understanding

- What is a Feature Test?
- What is Capybara?
- What are User Stories?

Completed code can be found on this branch [here](https://github.com/turingschool-examples/set-list-7/tree/feature-testing-complete).
