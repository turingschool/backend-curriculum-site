---
layout: page
title: Testing Best Practices
---

## Learning Goals

* Develop Strategies for file structure within the `spec` directory
* Use capybara DSL to target specific elements on a page


## Vocab

* `within`
* CSS class and id


## Warm Up

* In your notebook, list all the methods you have used in your spec files - see if you can categorize them by capybara, shoulda-matchers, and what just comes with rails.

## Organizing Files and Running Your Test Suite.

### File Structure

There is a strong convention to  group model tests in a directory called `spec/models` and to group feature tests in a directory called `spec/features`.  Using this convention will allow you to take advantage of RSpec's built in assumptions that all tests in `/features` are feature tests, and all tests in `/models` are model tests.  Without this assumption, you would need to declare a type for each test, like this:

```ruby
RSpec.describe 'this is a feature test', type: :feature do
  # If you do not use the 'features' and 'models' file structure, you will need to declare a type.
end
```

```ruby
RSpec.describe Model, type: :model do
  # If you do not use the 'features' and 'models' file structure, you will need to declare a type.
end
```

Keeping with the convention of `spec/features` and `spec/models`, you can start your tests without the type declaration:

```ruby
# spec/features/some_feature_spec.rb
RSpec.describe 'this is a feature test' do
  # If you use the 'features' and 'models' file structure, you will not need to declare a type.
end
```

```ruby
# spec/models/some_model_spec.rb
RSpec.describe Model do
  # If you use the 'features' and 'models' file structure, you will not need to declare a type.
end
```

### Spec File Names

When it comes to creating your test files in RSpec, there is really only one hard and fast rule: your test files must end with `_spec.rb`. If they do not end this way, when you run `rspec`, they will not be recognized as tests.  Since there are no rules for naming your spec files, you will see a lot of variety as you review other people's code.

From a Model perspective, the convention is to name your spec files in your model folder after the model it is testing.  For example: `models/song_spec.rb`.

Unlike Model tests, there is no strong convention for naming your Feature test files. The ideal would be for the names of your tests to help build documentation for your application - when someone steps in to your application, they should be able to review the tests to understand what your application is capable of.  If you want some guidance, or a starting place, there are two strategies that you will see used frequently at Turing.

One option would be to name your spec files to match with the headline of a user story; that could look like this: `featuers/visitor_visits_song_index_spec.rb`.  This test file would then include any tests that revolve around a visitor visiting the songs index - what they see, what they can click on, etc.

A second option is to structure your feature tests in the same way we structure our view folders.  In this option, your features directory might look like this:

```
-- features
    -- songs
        index_spec.rb
        show_spec.rb
    -- artists
        new_spec.rb
```

## Before :each

Up to this point, you have likely been creating the 'setup' portion of your tests over and over, using similar or identical setup for each test.  RSpec gives you a little help with this repetition with `before :each`.  `before :each` is a block that will run before every test (every `it` block).  You can use it to create setup for many tests and DRY up your test files.  It works in much the same way as the `setup` method in Minitest:

```ruby
RSpec.describe "songs index page", type: :feature do
  before :each do
    @artist = Artist.create!(name: '1903')
    @song_1 = artist.songs.create!(title: "Don't stop belivin'", length: 303, play_count: 12345)
    @song_2 = artist.songs.create!(title: "Bohemian Rhapsody", length: 540, play_count: 67829348)
  end

  it "shows all songs" do
    visit '/songs'

    expect(page).to have_content(@song_1.title)
    expect(page).to have_content("Play Count: #{@song_1.play_count}")
    expect(page).to have_content(@song_2.title)
    expect(page).to have_content("Play Count: #{@song_2.play_count}")
  end

  it 'has links to song show pages' do
    visit '/songs'

    expect(page).to have_link(@song_1.title)

    click_link @song_1.title

    expect(current_path).to eq("/songs/#{@song_1.id}")
    expect(page).to have_content(@song_1.title)
  end
end
```

## Specific Expectations

A lot of our expectations will make use of the `have_content` method:

```ruby
expect(page).to have_content('some content')
```

On its own, this is not a very specific expectation since this is checking that some content appears **anywhere** on a page. We always want our expectations to be as specific as possible so that our tests catch any possible errors that may arise in our code.

### have_content

One way to make your tests more specific is by using something other than `have_content`.  The following methods could be interchanged to indicate a more specific content type:

* `have_button` - is there a button with a particular label
* `have_link` - is there a link with a particular label
* `have_css` - is there a particular css selector (often used to verify images)

### click_on

Similar to `have_content`, we often will want to click on something and expect some result.  When we use `click_on('label')`, capybara will look for a link **or** button with a matching label. To be more specific, you can use `click_button` and `click_link`.

### Targeting Elements with CSS Selectors

Capybara gives us the ability to use [CSS Selectors](https://www.w3schools.com/cssref/css_selectors.asp) in our tests. This gives us the ability to target specific elements just like we do when styling. We can use this in several capybara methods to make our test expectations more specific.

#### within

Let's say we are looking at an index page that includes information about dozens of songs.  We want to expect that a song's information is showing on the page but not just anywhere on the page - we want it grouped together with the other information about that song.  In effect, we want all information for each song to be grouped together on the page.  To test for this, we use the Capybara method `within`.

`within` allows us to use CSS Selectors to select elements and then write expectations just for that area of the page. For example,

```ruby
within('#artist-13') do
  expect(page).to have_content('content about this artist')
end
```

In this example, the `within` method will look for the HTML element with an id `artist-13` and run any expectation only for the elements nested under that element.  We can also use `within` to target css classes or regular elements (like a `<p>`tag) just like we do when styling. Most often, we see `within` used with css ids and classes.

#### `find` and `all`

Capybara also gives us the `find` and `all` methods. `find` will return a single element that matches a css selector, and `all` with return an array of all elements that match a css selector:

```ruby
page.find('#song-14')
# => Capybara::Node::Element object. Represents HTML element with id of "song-14"
page.all('.song')
# => Array of Capybara::Node::Element objects. Represents all HTML elements with a class of "song"
```

Notice that HTML elements are represented in Ruby as `Capybara::Node::Element` objects. Now that we have access to these elements, we can check for content within those elements with:

```ruby
song_14 = page.find('#song-14')
expect(song_14).to have_content('Raspberry Beret')

all_songs = page.all('.song')
expect(all_songs[2]).to have_content('Purple Rain')
```

## Testing for sorted elements

One of the more challenging things for beginning web developers to test is the order that things are appearing on a page. If you need to have options for a user to sort an index page, you will also need to test for that!

There are several ways to test this, but the one we will show you here makes use of the Capybara `all` method and css selectors. `page.all` will return an array of the elements on the page that match that css selector, and we can use array methods to verify a specific order of those elements like this:

```ruby
within '#best-users' do
  expect(page.all('.user')[0]).to have_content("megan")
  expect(page.all('.user')[1]).to have_content("brian")
  expect(page.all('.user')[2]).to have_content("sal")
end
```

In this example, we are verifying that within a tag with a css id of `best-users`, the first element with a class of `user` has the content `'megan'`, the second element with a class of `user` has the content `'brian'`, etc.

## Practice

In SetList:

1. Update your songs index test to use within blocks to test that the song information appears in a specific place on the page. Then, make the test pass. You will most likely need to update your view for your tests to work.
1. Write a new test for the songs index that tests that songs are shown in reverse alphabetical order. Then, make the test pass.
1. Create a `before :each` block to share setup between those two tests

## Checks for Understanding

* How do you tell `within` to look for either a class or id?
* What capybara method will help you test for sorted items on a page?
