---
title: Viewing Party Requirements
length: 2 weeks
type: project
---


## Viewing Party Requirements

### Requirement Overview
- Consume [The Movie DB API](https://developers.themoviedb.org/3/getting-started/introduction)
- Implement Basic Auth
- Choose one exploration option to complete

**OPTIONAL**
- Use [co-authored commits](https://gist.github.com/iandouglas/6ff9428ca9e349118095ce7ed4a655bf) when doing driver/navigator pairing.


### Requirements
Project specification requirements can be found [here](https://github.com/turingschool-examples/viewing_party/projects/1)

__One__ member of your team will fill out the conveyor-belt link for the project setup. The conveyor-belt will clone and setup the project board for you.

Wireframes found [here](./wireframes) can be used as an additional reference

### A note about friendships

The user story about adding friends states that if User A and User B are in the database and User A adds User B as a friend, then that friendship is confirmed, and User A can now invite User B to a Viewing Party. It does not explicitly state that User B must also add User A as a friend. Think of this like a Twitter "follow" relationship: if I follow you, I can invite you to a Viewing Party, but you can't invite me to a party unless you follow me first.

As an EXTENSION (once ALL other MVP work is complete):

- User A invites User B to be friends, but User B must CONFIRM that friendship request, and now both users can immediately invite one another to Viewing Parties; until User B confirms that friendship, the UI should show User A that User B's friendship request is still pending, and User B cannot be invited to Viewing Parties yet; User B's UI should show that there is a friendship request to confirm
- perhaps User B does not want to be friends with User A but does not want User A to know; they should be able to "deny" a friendship request, and User A will forever see that the friendship request is pending but unanswered; User A should have a way to remove the pending request whether User B has denied the friendship or not

### Exploration Topic Ideas

- Use RuboCop in project to enforce style guide
- Additional API consumption
- ActionCable
- ActionMailer
- Front-end JavaScript
- Deployment with a service
