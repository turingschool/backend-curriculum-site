---
layout: page
title: Terrificus - Inception
type: project
---

## Background

An Inception is a process used by many companies in the Software Industry to design a solution to a problem. It is tempting to take a problem an immediately start coding, however this will often result in an incoherent solution, or even worse, a solution to the **wrong** problem.

Usually this process takes several days involving many stakeholders such as the client(s), team leads, CEOs, operations, etc. We will be doing a simplified version of this process in a few hours between your team and your project manager.

## Meetings

Each meeting has a purpose (Brainstorm, Decide, Solve) and everyone should try hard to stick to that purpose.

* Brainstorm - Explore what is possible, what can go wrong, what is not possible, debate, share counterpoints etc.
* Decide - Follows brainstorming and requires the team to put aside their pride and make decisions for the sake of the team.
* Solve - Follows deciding. This is the execution of what was decided.

Conflict and tension tends to arise in groups when there are differing expectations of these meetings. Some want to debate and explore different outcomes while others see that as a waste of time and want to make a decision. The reality is both are important for making sound decisions and the following is a template to do both and get your project off to a strong start.


### (Meeting) Product Vision - Problem Definition and Idea Sharing (Brainstorm)

* **Time Limit:** 30 - 45 minutes (More ideas will come up throughout the project and that's OK.)
* **Objectives:**
    - Define the problem you are solving in 2-3 sentences. The solution you come up with later should solve the problem directly.
    - Discuss and debate the technical solution to the problem, thinking through the most important features this application would need in order to solve the problem. Do not eliminate any ideas during this meeting.

#### Assigned Roles

* Time Enforcer:
* Notetaker:
* Facilitator:

**Facilitator Notes**

Allow everyone's voice to be heard and make sure no one is dominating the discussion.

Encourage your team to be creative. Encourage people to share bad ideas as well as good. Sometimes bad ideas lead to good ones.

If you need questions guiding the discussion:

* What would set you apart during demo night?
* What intimidates you but would be amazing to pull off?
* How should your users experience the app? Desktop, mobile?
* What features or technology choices would spark interesting discussions during job interviews?
* Would you use this product? If not, what is it missing?

**Time Enforcer notes:**

* If debating a single idea goes longer than 5 minutes point it out. There's no need to make a decision now and allowing one idea to dominate the discussion can hinder creativity and cause frustration.

### (Meeting) Product Vision - Feature Dump (Brainstorm)

* **Time Limit:** 30 - 45 minutes
* **Objective:** Write out as many features as possible that were discussed during the brainstorming session.

**Instructions**

Feature Writing (10 min)
* This is an individual or paired activity
* Each person/pair should write out features on Sticky Notes
* Only 1 feature per sticky note
* Features should describe user interaction in 3-5 words max.
* Features should be written using a sharpie to help ensure the above word Limit
* Examples include:
- User profile creation
- User sees stats over time
- Email notifications
**If you cannot fit a feature on a single sticky note you are doing it wrong. You are probably providing implementation details. These feature descriptions should describe user interaction and should not be tied to implementing the feature in a specific way**
* All potential features of the app should be included (we will define the MVP later in the process)

Feature Sharing/Elimination of Duplicates (20 min)
* Utilize a large blank wall or sheet of chart paper
* Once each person/pair is finished writing out features the whole group will come back together to share what they have come up with.
* Each person/pair should present their features one at a time, giving a *brief* description of what that feature is, so it is clear for the whole group.
* After you have described the feature stick it on the wall or chart paper.
* Repeat the process one sticky note at a time, grouping like features together into categories. For example the following user stories may be grouped with each other because they both pertain to user authentication.
- User can log in
- User can log out

* As each person takes a turn you will notice that some of the features will be duplicates of previously shared features. If this is the case, simple crush the sticky note and throw it on the ground. Don't spend time describing a feature if it is a duplicate.
* Once all the features have been shared, group them into categories.
* Come up with a name for each of the categories. These will be referred to as [EPICs](https://www.yodiz.com/blog/what-is-epic-in-agile-methodology-definition-and-template-of-epic/) and will be a way to organize your features in your project management tool.

### (Meeting) Product Vision - Feature Prioritization and MVP Definition (Decide)

* **Time Limit** 30 minutes
* **Objective:** Define the features that will make up your [**Minimum Viable Product**](https://www.agilealliance.org/glossary/mvp/#q=~(infinite~false~filters~(tags~(~'mvp))~searchTerm~'~sort~false~sortDirection~'asc~page~1))

#### Assigned Roles

* Facilitator: This will be your instructor

**Instructions**

* Using masking or painter's tape, place a large line above the sticky notes. The line should start on the far left side and extend across the entire width of sticky notes to the far right side.
* All sticky notes start out **below the line**
* The instructor will go through each sticky note one at a time and the team will discuss whether or not this feature should be included in the Minimum Viable Product (MVP) or if the feature should be considered for an extension once the base functionality is built.
* If the feature should be included in the MVP, move the sticky note above the line. If not, keep the sticky note below the line.
* If you are unsure about a feature, table the feature and come back to it at the end.
* Repeat this process until you have gone through all of the sticky notes.
* Once you are finished, you have your MVP definition.

### (Meeting) Technical Solution - Wireframing (Solve)

* **Time Limit** 30 minutes
* **Objective:** Think through and decide how users will interact with your application

**Instructions**
* Create a high level [user flow diagram](https://bashooka.com/inspiration/33-excellent-user-flow-examples-for-inspiration/) that lists the steps a user will take when interacting with your application.
* Make a list of all of the pages required for your application along with what features will exist on each page.
* For each page, create a [wireframe](https://www.usability.gov/how-to-and-tools/methods/wireframing.html) by sketching out what that user will see when they navigate to that page include details such as header text, buttons, drop downs, forms with the specific fields, graphs etc.
* Do a few pages together as a group, then divide and conquer the remaining pages.

### (Activity) Technical Solution - Story Writing (Solve)

* **Time Limit** 30 minutes
* **Objective:** Document technical requirements for the development team

**Instructions**
* Translate each of the features that were written on sticky notes during the feature dump exercise into a [user story](https://www.atlassian.com/agile/project-management/user-stories) in your project management tool.
* Every user story should be written from the perspective of the end user and should follow this format:  
`As a ___, when I visit ___, I want to ____ so that I can ____.`
* For every user story include a list of subtasks required to complete the user story. This includes developer chores such as database migrations to add tables and columns, exposing API endpoints, creating mock data and fixtures to stub out an API call etc.
* For every user story, include the wire frame(s) from the associate page(s)
* An example user story is:
- Feature: User can log in
- User story: "As a user, when I visit the login page, I want to click the `login with Google` button so that I can login to the application using my google account."
- Subtasks:
1. Create user table with name, email, and token columns
2. Implement google Omniauth strategy
3. Route for login page is /login
4. User should be redirected to /dashboard after successful login
5. If user is not able to authenticate with google, user should see flash message that reads `Oops something went wrong!`
