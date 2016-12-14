---
layout: page
title: IdeaBox
---

Every developer has more ideas than time. As David Allen likes to say "the
human brain is for creating ideas, not remembering them." In this project,
we'll be building a simple application for recording and archiving our ideas
(good and bad alike).

Throughout the project, one of our focuses will be on providing a fluid and responsive
client-side interface. To this end, we'll rely on JavaScript and jQuery
to implement snappy filtering in the browser, and AJAX to enable
inconspicuous communication between client and server.

### Architecture

For this project, we'll be increasingly thinking about the "server" and "client"
as separate entities. We'll be using:

* A Rails application is set up to manage data related to our ideas. [Here is the API App](git@github.com:turingschool-examples/idea_box_2.0.git)
* JavaScript (with jQuery) and basic HTML to manage client-side interactions and communicate asynchronously with the server

In order to get more experience doing DOM manipulations and AJAX event handling on our own,
we will _not_ be using client-side frameworks (Ember, Angular, React, etc.).

Your entire application will consist of one HTML page or template. You will not have separate pages for each CRUD action.

All of your AJAX functionality will be triggered by jQuery.

### Data Model - Set up in [the Rails API](git@github.com:turingschool-examples/idea_box_2.0.git)

We'll be primarily working with _Idea_ objects.

* An Idea has a _title_, a _body_, and a _quality_.
  * _title_ and _body_ are free-form strings.
* _quality_ can be represented however you feel best in the database,
  but in the user interface it should manifest as the options "genius", "plausible", and "swill"
* By default, the idea's "quality" should default to the lowest setting (i.e. "swill").

### User Flows

#### Viewing ideas - Together

On the application's root, the user should:

* See a list of all existing ideas, including the title, body, and quality for each idea.
* Idea Body.
* Ideas should appear in descending chronological order (with the most recently created
  idea at the top).

#### Adding a new idea - Together

On the application's main page, a user should:

* See two text boxes for entering the "Title" and "Body" for a new idea,
  and a "Save" button for committing that idea.

When a user clicks "Save":

* A new idea with the provided title and body should appear in the idea list.
* The text fields should be cleared and ready to accept a new idea.
* The page _should not_ reload.
* The idea should be committed to the database. It should still be present upon reloading the page.

#### Deleting an existing idea - On Your Own / Pairs

When viewing the idea list:

* Each idea in the list should have a link or button to "Delete" (or 𝗫, etc).
* Upon clicking "Delete", the appropriate idea should be removed from the list
* The page _should not_ reload when an idea is deleted.
* The idea should be removed from the database. It should not re-appear on next page load.

#### Editing an existing idea - On Your Own / Pairs

* When a user clicks the title or body of an idea in the list, that text should become an editable text field, pre-populated with the existing idea title or body.
* Clicking this link should _not_ take the user to a separate "edit" page for the given idea.
*  The user should be able to "commit" their changes by pressing "Enter/Return" or by clicking outside of the text field.
* If the user reloads the page, their edits will be reflected.

#### Changing the quality of an idea - Together

As we said above, ideas should start out as "swill." This is implemented in the API with a default value if it is not entered. (Spicy challenge: see if you can do this in JavaScript without the default in the API). In order to change the recorded quality of an idea, the user will interact with it from the idea list.

* Each idea in the list should include a "thumbs up" and "thumbs down" button.
* Clicking thumbs up on the idea should increase its quality one notch ("swill" → "plausible",
  "plausible" → "genius").
* Clicking thumbs down on the idea should decrease its quality one notch ("genius" → "plausible",
  "plausible" → "swill").
* Incrementing a "genius" idea or decrementing a "swill" idea should have no effect.

#### Idea Filtering and Searching - Together

We'd like our users to be able to easily find specific ideas they already created, so let's provide them with a filtering interface on the idea list.

* At the top of the idea list, include a text field labeled "Search".
* As a user types in the search box, the list of ideas should filter in real time to only display ideas whose title or body include the user's text. The page _should not_ reload.
* Clearing the search box should restore all the ideas to the list.

### Optional Extensions - On your Own.

#### Tagging

Add an optional third text field upon idea creation for "Tags". Tags should be a comma-separated list of short text tags, and should be processed on the server such that any existing tags are re-used, and any new ones are created. Once there are tags to display, a list of existing tags should appear at the top of the idea list. Clicking one of these tags should show only ideas that include it. When viewing ideas filtered by tag, be sure to include a link to take the user back to "All Ideas". This filtering could be implemented either as a separate page or via javascript within the same interface.

You will need to write code in the API app.

#### Sorting

When viewing the ideas list, the user should have the option to sort ideas by Quality. The default sort should be descending ("genius" → "plausible" → "swill"), and clicking the sort a second time should reverse it. The Idea list should be sorted client-side without reloading the page.    
