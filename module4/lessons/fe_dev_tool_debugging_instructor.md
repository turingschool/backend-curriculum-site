## Learning Goals

By the end of this lesson, you will:

* Understand how and when to use specific debugging tools
* Be able to debug errors in HTML, CSS and JavaScript
* Know where to look for and how to isolate JavaScript errors

## Vocabulary

- dev tools
- debugger
- elements
- console
- network
- sources

## Warm Up

Write your answers to the following in your notebook:
- What debugging tools do you use in Rails? To what extent do you think they are helpful? What is your favorite, and why?
- What debugging tools have you used in JavaScript so far? To what extent do you think they are helpful? What is your favorite, and why?

## Debugging the Front-End with DevTools - INTRO

SAY:
Debugging your front-end code can be an intimidating part of the development process, but it's also one of the most powerful skills you can acquire. Developers of all levels spend a significant amount of time troubleshooting code, but the more comfortable you are with debugging tools, the easier it will be to isolate, identify and fix broken code.

The front-end languages (HTML, CSS and JavaScript) are run entirely in the browser, so the technique for troubleshooting broken code can happen in many places. Luckily, modern browsers are aware of this and give us a collection of advanced tools to help us debug.

### Developer Tools
One of the first tools you should familiarize yourself with when doing front-end development are the built-in browser DevTools, which can be used to explore any webpage.

#### Accessing DevTools
First, open up your favorite website - preferably something that you imagine has a lot of traffic and/or is making a lot of requests (NYTimes and CNN are great for this exercise if you don't have a favorite).

SLIDE:
To open developer tools in Chrome:
  - Mac: `Cmd` + `Opt` + `i`
  - (or) Right click on the browser window and select `inspect`
  - (or) Select `View` in the navbar, then `Developer`, then `Developer Tools`

SAY:
Personally I find that pinning the dev tools to the upper right is the most convenient. (You can also expand them into their own window.)

#### The Panels - SLIDE
Once you have your DevTools window open, you'll notice a toolbar across the top with several different tabs. Clicking on these tabs will bring you to different debugging panels, each built to help troubleshoot specific areas of your front-end code.

As mentioned earlier, there are a lot of places on the front-end where code can go wrong. This means the first and most important step in solving a bug is **isolating the problem**. DevTools has already done some of this step for us by categorizing the most commmon areas where developers run into problems, and providing us with specific debugging panels for each.

For now, we're only going to focus on the first four panels: Elements, Console, Sources and Network. These are the primary panels you'll be working with most often.

---------------------------------------

### The Elements Panel: Debugging HTML, CSS & DOM Events

SLIDE:
##### HELPFUL FOR:
* debugging layout and styling issues
* checking DOM events

SAY:
The elements panel lets you view the entire HTML source of the current page you are viewing. From here, you can edit, add or remove content and elements directly on the page. Though your changes won't be saved (any changes made here will be lost upon refreshing the page), sometimes it's helpful to make tweaks directly in this panel so you can see what effect the changes will have on your application before you implement them.

#### Selecting Elements to work with
You'll notice hovering over an HTML element in the devtools panel will also highlight that element on the page. This makes it easier to find and select the content you'd like to work with.

SLIDE:
You can also select elements directly on the page by clicking the Square Arrow icon in the toolbar, then hovering over the element on the page. This will automatically bring you to the corresponding code for that element in the devtools panel.

If you're having trouble finding the element you'd like to work with, you can search through the entire HTML with `Cmd + F`. You'll notice a searchbar appear at the bottom of the panel where you can enter any string to find a match. This is useful if you'd like to search for an element by a known ID or class.

#### Editing Elements and Content
SLIDE/SAY:
Directly from the elements panel, we can edit the HTML and see the changes reflected immediately. (Again, these changes won't be saved to your codebase, but sometimes it helps to see the tweaks as you make them before committing to them.)

Let's say we want to edit the title of a headline from some garbage about Trump to some good news. We can find that heading in the elements panel, double-click on it, and edit the text:

Now let's say we want to make just one word in the title bold. If we wrap a `<b>` tag around that word, and hit the `enter` key to save the change, look what happens:

The browser didn't recognize that we wanted the `<b>` tag to be considered HTML, and it rendered it as plain text. In order to edit in HTML-mode, we must right-click on the element and select 'Edit as HTML'. Now we can wrap the word in `<b>` tags and it will render it bold:

There are a lot of other options in the menu that appears when you right-click on an element.

#### Editing CSS
To the right of the HTML pane, there's a small sidebar (Styles is selected by default) that gives us styling information for the currently selected element. Similar to the HTML pane, we can add or remove styles and adjust CSS property values from this pane. You can click on any style property associated with the selected element and change its value. You can also use the blue checkbox to toggle the style on or off.

#### Inspecting DOM Events
SLIDE: Event Listeners!

SAY:
In this sidebar, you will also find a tab labeled 'Event Listeners'. This is an important one for debugging user interactions on your application. In the gif below, this arrow/send button provides a dropdown with a menu of options to like or retweet the article. When one is clicked on, another window will open to the respective social media website.

We can verify that this event listener has been attached to its corresponding DOM node by selecting the `button` in the elements panel, and navigating to the 'Event Listeners' tab in the sidebar:

## TRY IT
SLIDE:
Take 6 minutes to explore and try to accomplish the following:
- Click on an element on your favorite website, then look at the HTML in the DevTools.
- Play around with each of the editHTML options on your favorite website to see what else can be done!
- Select an element that you would expect to have an event listener and try to locate it in the tools. Warning: if this is a site with a lot going on, you'll see A LOT of listeners! Dig into some of those and try to figure out what they may be doing.

SAY:
On your own, play around with using these tools on your favorite website. When the timer goes off we will come back together and move on.

---------------------------------------

### The Console: Examining JavaScript Errors & Logging Information

SLIDE:
##### HELPFUL FOR:
* finding additional context about a JavaScript error
* tracing a JavaScript error to the exact line that caused it
* logging information about your code as it runs

SAY:
Many of the front-end bugs you encounter will be caused by the JavaScript in your application rather than your HTML or CSS. Tracking down these kinds of bugs can be tricky, but we can get a lot of information about the nature of a JavaScript error by using the console panel.

#### Exploring JavaScript Errors in the console
By default, the console panel will log any errors or warnings that it detects in your application. Warnings will be highlighted in yellow, and errors will be red. If you're following along with the expense tracker application, you'll notice we already have some errors in our console:

Each error in the console will provide you with the following information:

**A description of the error**  
We seem to have a Reference Error to an undefined variable called `loadExpenses`

**The file name and line number where the error occurred**  
On the right-hand side of the panel, it tells us the error is coming from a file called 'jquery-3.1.0.min.js' on line 2. But that doesn't seem right, because we didn't write that code and jQuery never has bugs! This is where the **stack trace** comes in.

**The stack trace allows you to follow the bug directly to where it originated**  
If you click the little triangle arrow next to the error in the console, you'll see some additional information expand. This is the line-by-line path of the bug that caused the code to throw an error. It's now much easier to see that the bug originated in our `script.js` file, on line 39.


#### Logging values with `console.log()`
Occassionally, you may want want to log custom information about the state of your code to the console. The console panel comes with a built-in `log` method that allows you to print any values you might be interested in seeing. You can think of the `console.log()` method as the equivalent of `puts` in Ruby.

Now that we've fixed the first JavaScript error we encountered, we can actually see one of our custom logging messages in in the console. Logging this success message was just a single line of code in our `getExpenses` function:

```javascript
const getExpenses = () => {
  return fetch('/expenses')
    .then((data) => console.log('Expenses returned successfully!'))
    .catch((error) => console.error('There was some kind of error.'))
};
```

It's nice to know that we have made a successful fetch call, but what if we want to log the data from our fetch response? Let's include the `data` argument from our success callback into our `console.log()`:

```javascript
console.log('Expenses returned successfully: ', data);
```

You should now see the success message along with the array of expenses that were returned from that fetch request. This is a common way for developers to confirm the value of a variable or clarify what is being returned from a function.

However, there are a couple of downsides to this method:

* **it encourages debugging by 'trial-and-error'** - you have to guess where in your code you should put the logging, and what values you need to log
* **logged data is stale** - your code continues to run even after the values have been logged, so you can't actually *do* anything with them
* **we tend to forget about them** - they'll sit around in our codebase and eventually get pushed to production

Luckily, there are alternative debugging strategies we can use that are a bit more powerful and efficient. We'll explore these further in the next section.

---------------------------------------

## Partner Jigsaw

Each student will have 8 minutes to research their assigned topic. Recommended that they pull the repo down so they are able to interact with the same examples in lesson resource.

Birthday closer to today - network
Birthday not closer to today - sources

After exploring, each partner takes 4 minutes to show the other what they learned.

Whole Class Debrief on Network and Sources:
Sources - highlight debugger and watching variables
Network - highlight status codes, info on requests/responses

---------------------------------------

### Practice

Let's put this information into practice by trying to solve a couple of bugs in our expense application.

You can clone the application [here](https://github.com/turingschool-examples/debugging-with-devtools), and follow the installation instructions in the README to get set up. The application has some pre-made bugs for us to solve as we go through the lesson. Read through the first buggy scenario [here](https://github.com/turingschool-examples/debugging-with-devtools/tree/category-highlighting) and checkout the `category-highlighting` branch to get started fixing
that code.

---------------------------------------

### Wrap Up

- What new tool did you learn about today that you are going to commit to using as you write JavaScript?
- Has your favorite JavaScript debugging tool changed from the beginning of this class?
