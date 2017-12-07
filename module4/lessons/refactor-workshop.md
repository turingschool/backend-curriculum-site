---
layout: page
title: Refactor Tractor Workshop
subheading: presentations and workshop
length: 120
tags: js, javascript, refactoring
---

# Refactor Tractor Workshop

## Structure

|-|-|
| 10 | Warmup |
| 15 | Presentations |
| 5 | Pomodoro |
| 5 | Smell Review |
| 25 | Code-along / Workshop |
| 5 | Pomodoro |
| 40 | Paired practice |
| 15 | Review |


## Learning Goals

* Revisit and reinforce the general points and goals of refactoring.
* Communicate a technical problem.
* Recognize common mistakes and bad practices in JS.
* Develop strategies to refactor those mistakes.

## Warmup

With your Quantified Self partner, take 10 minutes to identify a chunk of code (<= 10 lines) that you *know* is smelly, but haven't had time or don't know how to refactor it.

Develop talking points for a three minute presentation that address the following:

* Why/how the code "smells"
  * What rules or conventions it violates (e.g., DRY)
* The headaches (if any) this code has introduced to your project
* How you might refactor or deal with it
* Why refactoring would be worth the time and effort

**Split speaking time evenly between you and your partner**

## Presentations

<!---

Presentation Break up

To break up the groups (ex.):

1.     | 2.   | 3.    | 4.      | 5.      | 6.
Jordan | Sam  | Casey | Blake   | Taylor  | Peyton
Alex   | Jess | Lee   | Charlie | Phoenix | Dakota

Split them in 2 groups
Group A : 1, 2, 3
Group B : 4, 5, 6

Paired Practice Break up

To set the pairs needed later have each member of a team meet with a member of a different team who saw their presentation. I tend to match diagonal here them loop around. i.e

Jordan & Jess
Sam & Lee
Casey & Alex

Blake & Phoenix
Taylor & Dakota
Peyton & Charlie

This ensures that when they refactor the other person code they have seen it before in the presentation and that members from 2 different team are helping review the originally teams code giving the original team different perspectives.

-->

Each group present their "smellyscript" to the other groups to practice technical communication (3 minutes).

## Review presented topics

### Low Hanging fruits
 * Leftover `debugger` statements
 * Commented out code
 * Wonky whitespace
 * Mismatched or too many semicolons
 * Inconsistent use of function syntax
 * Inconsistent use of `var` vs `const` & `let`
 * Dead, unused code

### Other Code smells
 * Comments - fine line between comments that illuminate and comments that obscure. why vs what
 * Long Methods - short methods are easier to read, understand and trouble shoot
 * Long Parameter List - the more parameters the more complex
 * Duplicated Code - DRY, DRY, DRY
 * Conditional Complexity - large conditional logic blocks
 * Uncommunicative Name - does the method name succinctly describe what it does

## Code-along 1-2 topics

<!---
  Pick 1 or 2 examples from the presentations to refactor in front of the class
-->

## Paired Practice

In your assigned pair (given by instructor):

1. Checkout a refactoring branch for Person A's project
2. Work on refactoring Person A's code snippet from their presentation for 20 minutes.
3. Repeat steps 1 and 2 for Person B

## Review

With your Quantified Self partner, discuss the following (15 minutes):

  * How your workshop pair approached refactoring
  * Your main takeaway from today's workshop

## Resources

Check out [this](./js_refactor_tractor) compilation of refactoring techniques in JS.
