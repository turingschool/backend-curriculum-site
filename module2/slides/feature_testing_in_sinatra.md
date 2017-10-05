# Feature Testing

## Capybara & Sinatra

---

# Warmup

* What are we testing so far in our FilmFile app?
* What aren't we testing?
* Assuming that our tests will have some setup, executation, assertions, and teardown, what might be included in each phase?

---

# Feature Tests

* Mimic the behavior of the user
* Shouldn't have to know about underlying code
* Based on user stories

---

# User Stories

* As a user
* When I visit the home page
* And I fill in title
* And I fill in description
* And I click submit
* Then my task is saved

---

# User Stories

* As a **user**
* When I **visit the home page**
* And I **fill in title**
* And I **fill in description**
* And I **click submit**
* Then **I see a page with my task on it**

---

# User Stories

* As a **[user/user-type]**
* When I **[action]**
* And I **[action]**
* And I **[action]**
* And I **[action]**
* Then I **[action]**

---

# Create User Stories

* Adding a Film to FilmFile
* Viewing only the Films associated with a specific Genre
* Signing up for a new account
* Logging into an account

---

# Capybara

* Test Framework
* Allows you to test any rack-based app
* Used for feature tests
* Helps you query and interact with the DOM

---

# Capybara Methods

* visit(**'path'**)
* expect(page).to have_content("**Content**")
* expect(page).to have_css("**CSS**")
* within("**CSS**") {**Expectations or Actions**}

Highlighted item are intended to change based on the actual example.

---

# In Code

```ruby
describe "When a user visits a film show page" do
  it "they should see information about the film" do
    film = Film.create(title: "Fargo", year: 2017, box_office_sales: 4)

    visit "/films/#{film.id}"

    within "#description" do
      expect(page).to have_content("Fargo")
    end
  end
end

```

---

# Setup & First Test

On your own or with a partner:

* Follow the instructions in the lesson plan to set up your first feature test
* Try to see if you can create a test and make it pass

---

# Share

---

# Launchy

* Gem that allows us to open a page in the middle of a test
* In your Gemfile: `gem 'launchy'`
* When you want to use in your test: `save_and_open_page`

---

# Forms & Buttons

* fill_in("**identifier**", with: "**content**")
* click_link("**identifier**")
* click_button("**identifier**")
* click_link_or_button("**identifier**")
* click_on("**identifier**")
* expect(current_path).to eq("**identifier**")

---

# Workshop

## Write Feature Tests For:

* The process of creating a Film
* That all films are displayed on the Film index
* That a Genre's total winnings are displayed on their page

---

# When do I write a feature test?

* Opinions vary
* To help drive development
* To ensure user stories are functioning
* To ensure user stories continue to function
* If it's important and you don't want it to break, test it

---

# Takeaways

* Feature tests mimic user behavior
* User stories help us figure out what to put in a feature test
* Capybara allows us to
    * interact with a page
    * interpret results in our tests
* Launchy helps us debug
