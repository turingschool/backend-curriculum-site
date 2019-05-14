## Meeting Schedule

**Important:** Assigned roles should be rotated for each meeting. Everyone should get a chance in each role.

Each meeting/section has a purpose (Brainstorm, Decide, Solve) and everyone should try hard to stick to that purpose.

* Brainstorm - Explore what is possible, what can go wrong, what is not possible, debate, share counterpoints etc.
* Decide - Follows brainstorming and requires the team to put aside their pride and make decisions for the sake of the team.
* Solve - Follows brainstorming and deciding. This is the execution of what was decided.

Conflict and tension tends to arise in groups when there are differing expectations of these meetings. Some want to debate and explore different outcomes while others see that as a waste of time and want to make a decision. The reality is both are important for making sound decisions and the following is a template to do both and get your project off to a strong start.

### (Meeting) Product Vision - Brainstorm

* **Time Limit:** 30 minutes (More ideas will come up throughout the project and that's OK.)
* **Objective:** Discuss and debate the most important features your group is interested in building.

#### Assigned Roles

* Time Cop:
* Notetaker:
* Facilitator:

**Facilitator notes:**

Make sure this session isn't used to make decisions. That comes later. Allow everyone's voice to be heard and make sure no one is dominating the discussion.

Encourage your team to be creative. Encourage people to share bad ideas as well as good. Sometimes bad ideas lead to good ones.

If you need questions guiding the discussion:

* What would an MVP (minimum viable product) look like? If your team needed to ship features every evening to prove value to an investor, what would you work on and in what order?
* What would set you apart during demo night?
* What intimidates you but would be amazing to pull off?
* How should your users experience the app? Desktop, mobile, native app?
* What features or technology choices would spark interesting discussions during job interviews?
* Would you use this product? If not, what is it missing?

**Time Cop notes:**

* If debating a single idea goes longer than 5 minutes point it out. There's no need to make a decision now and allowing one idea to dominate the discussion can hinder creativity and cause frustration.

**Notes Below:**


### (Meeting) Product Vision - Decide

* **Time Limit:** 15-30 minutes
* **Objective:** Decide what your minimum viable product is.

#### Assigned Roles

* Time Cop:
* Notetaker:
* Facilitator:

**Facilitator notes:**

One way to quickly exhaust a group is to allow debates to go on too long. Have the team vote if any decision takes more than 10 minutes. If the team can't decide bring in an instructor and they'll be the deciding vote.

* What are the three most important features?
* How would you prioritize them?

**Notes Below:**

### (Meeting) Wireframes - Solve

* **Time Limit:** 30 minutes
* **Objective:** Build wireframes that capture the user's experience of the three most important features decided above.

#### Assigned Roles

* Time Cop:
* Notetaker (builds the wireframes):
* Facilitator:

**Facilitator notes:**

One way to quickly exhaust a group is to allow debates to go on too long. Have the team vote if any decision takes more than 10 minutes. If the team can't decide bring in an instructor and they'll be the deciding vote.

### (Meeting) Story Writing - Solve

**Objective:** Use the wireframes to guide you while you write user stories. Stories should not focus on implementation details, just the user experience.

#### Assigned Roles

This can be done as a whole group but this tends to lead to some people doing all of the work while others might just be sitting and watching. Probably best done in pairs while the others work on design and branding.

### Design and Branding - Solve

**Objective:** Use the wireframes to guide you while you build out the design. Select color scheme, fonts, and logo. If you are particularly ambitious you might even code out the main pages using plain HTML and CSS (note: this doesn't need to be in Rails). This will really speed up development.

#### Assigned Roles

This can be done as a whole group but this tends to lead to some people doing all of the work while others might just be sitting and watching. Probably best done in pairs while the others work on writing stories.

### (Meeting) Architecture and Schema - Brainstorming

* **Time Limit:** 30-45 minutes
* **Objective:** Explore different possibilities for how you might build your MVP. Note: It's important this happens after you've built your wireframes.

#### Assigned Roles

* Time Cop:
* Notetaker:
* Facilitator:

**Facilitator notes:**

* Are there parts of the app that would benefit from things happening in the background? (tasks that take a long time or need to run on a regular basis; nightly, hourly, etc.)
* Are there parts of the app that would benefit from breaking away from the request/response cycle by updating the page automatically? (websockets, AJAX, etc.)
* Should you cache data to improve page load times?
* Should this be one big Rails app?
* How might the schema look?
* Is there anything different you might need to try in your schema? (self-referential associations, serialized columns, etc.)

**Notes Below:**

### (Meeting) Architecture and Schema - Decide

* **Time Limit:** 30-60 minutes
* **Objective:** Decide on the architecture and schema. Similar to a detour on a road trip, it's OK to deviate from this plan if you realize things are different than you were expecting. You'll never know less about the problem than you do right now. But you should at least have a map/idea of where you are going so the team can move in the same direction.

#### Assigned Roles

* Time Cop:
* Notetaker:
* Facilitator:

**Facilitator notes:**

One way to quickly exhaust a group is to allow debates to go on too long. Have the team vote if any decision takes more than 10 minutes. If the team can't decide bring in an instructor and they'll be the deciding vote.

* What should the schema look like?
* What will your architecture look like? (background workers, caching, websockets, JavaScript)
* What tasks need cards created in your project management tool? Who will add these? Label these tasks as chores. Note: migrations should be run in the context of the user stories that need them and shouldn't have cards associated with them. An example of a chore might be is more for setting things up like Redis on Heroku.

**Notes Below:**

### (Meeting) Prioritization - Solve

* **Time Limit:** 30-60 minutes
* **Objective:** After looking at the same problems from both product and technical perspectives you should now resolve the tension between the two. Stack the stories and cards in order of importance while balancing this tension in a way that would keep stakeholders happy and minimizes idle time for developers.

#### Assigned Roles

* Product Representative (probably someone who was writing the user stories):
* Technical Representative:
* Time Cop: Everyone
* Notetaker:
* Facilitator:

**Facilitator notes:**

One way to quickly exhaust a group is to allow debates to go on too long. Have the team vote if any decision takes more than 10 minutes. If the team can't decide bring in an instructor and they'll be the deciding vote.

* What should the schema look like?
* What will your architecture look like? (background workers, caching, websockets, JavaScript)
* What tasks need cards created in your project management tool? Who will add these? Label these tasks as chores. Note: migrations should be run in the context of the user stories that need them and shouldn't have cards associated with them. An example of a chore might be is more for setting things up like Redis on Heroku.

**Notes Below:**
