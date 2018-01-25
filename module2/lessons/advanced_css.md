---
layout: page
title: Advanced CSS Selectors
---

## Learning Goals

  - Apply CSS pseudo-classes to an existing layout

  
## Vocab 
* Pseudo-class
* Pseudo-element
* Element

## WarmUp 
* What strategies have you used to style specific elements?
* What tools do we have to change a style relative to user interaction?

### Pseudo-classes - What are they?

  - Specific characteristics of an element that can be targeted with CSS.
  - Creates a special state for that element.

### Common Pseudo-classes

  - `hover`
  - `disabled`
  - `focus`
  - `nth-of-type`
  
  Pseudo-class [documentaion](https://www.w3schools.com/css/css_pseudo_classes.asp)
  Pseudo-element [documentaion](https://www.w3schools.com/css/css_pseudo_elements.asp)

### Let's jump back into our playground to explore

  - Create and switch to a branch `your_name_advanced_css`
  - In our [HTML CSS Playground](https://github.com/turingschool-examples/html_css_playground) that we were working on yesterday, open the file "advanced_css.html" and the css associated with it.
  - We have 3 blue boxes:

#### Task 1 - Hover

  - The goal is that when we hover over any of our boxes, they will turn from blue to silver.

  ```css
  .box:hover {
    background-color: silver;
  }
  ```

  - On your own, see if you can get the box to rotate 45 degrees on hover as well.

#### Task 2 - Disabled

  - `disabled` is a common pseudo-class that might be used to indicate that a text input field (or checkbox/radio buttons/etc) cannot be selected.
  - In our playground example, we can give each of our boxes a name. (This is just an example so it's not so real world ::winking::).
  - Let's disable the last boxes input and make sure our users know it is disabled by making it red.

  ```html
  <input type="text" value="Name This Box!" disabled>
  ```

  - In our CSS, let's tell our disabled input what to do.

  ```css
  input:disabled {
    background-color: red;
  }
  ```

#### Task 3 - Focus

  - Differences of hover and focus (From StackOverflow): Hover is 'true' when the mouse pointer is over an element. Focus is true if the cursor is in that element. It's possible for hover to be false and focus true (e.g click in a text field then move the mouse away)
  - Let's experiment.

  ```css
  input:focus {
    background-color: pink;
    color: teal;
  }
  ```

  - If we change our `focus` to `hover`, our `hover` does not behave as expected. `focus` provides a way to focus our cursor on something specific.


#### Task 4 - Nth of Type

  - So we have silver rotating boxes, GREAT! But now we just want the middle box to have special rules. We want it to be 150 x 150 and teal.

  ```css
  .box:nth-of-type(2) {
    width: 150px;
    height: 150px;
    background-color: teal;
  }
  ```

  - The nth-of-type allows us to select which number element (starting at 1) of that class we would want to modify!

#### Other Challenges

  - Create a checkbox that has a label "I am a box!", when you click on the checkbox, the label gets a purple 3px solid border.
  - Create another section of boxes. The middle box in any section of boxes should have a height and width of 150 and the color teal.


## WrapUp
* What are 4 pseudo-classes, what does each do? 
* Why do we want to make our layout and design reactive to a user? 
