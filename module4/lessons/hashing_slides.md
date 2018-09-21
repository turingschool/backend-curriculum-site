footer: Hashing
slidenumbers: true

# Hashing

^ notes
- Collections
- The dream of a hash function is constant time lookup no matter how many elements
- TONE - timing, clarity of expectations, start and stop times, how do we set and shape tone, opportunities to change it mid way.

---

# Welcome. Choose a Snack

- Choose ONE snack for yourself
- Resist the temptation & do NOT open it yet

^ Make sure that everyone has a snack, and that all five snacks were selected at least 1x. If someone didn't select a snack, give them the least popular one.

---

# Warm Up

- I don't quite know what I want to have them do here.

^ comments

---

# Learning Goals

* Instructors will be able to explain how hashes are created
* Instructors will be able to explain what hashing is and where it is used in the real world

^ KEY POINTS:
- There is no way to take the hash and go back to original string
- Inputs can be any size/Outputs will always be the same size
- Any slight change of input results in drastic changes of output
Intro notes:

---

# What is this all about?

**Hash Tables:**
- data structure that maps keys to values
- each key gets assigned to a unique bucket
- time lookup, insertion, and deletion should be constant

^ Let's build a little high-level context before we dig into hashing.
Hash Tables are a data structure - the dream is that no matter how many elements we have, we can have a constant time lookup

---

# What is this all about?

**Hash Function/Algorithms:**
- Functions that map data to a 'bucket' in a hash table
- The values returned are referred to as hash values, hash codes, digests, or hashes

^ Today we are going to focus on the fundamentals of what this hash function needs to do, in order to do a good job storing our data for us.

---

![inline](https://study.cs50.net/slideshows/1WyRdHGA7wYMYg078wXpv9qAjrELJBokRFRKGnVbnI7Q/img/0.png)

---

# Count the Letters

NOT including spaces, find the number of characters in your snack's string. Spell it correctly.

^ Snacks:
- fruitsnacks (11)
- cheezit (7)
- granolabar (10)
- starburst (9)
- M&Ms (4)

---

# SnackLength % 6

This should result in a number 0-5.

Drop your snack off in the bin with your number on it.

^ We should see a collision with M&Ms & granolabar in snack bin 4. People should stay at their bin.

---

# Pitfalls of our Hash Function

DISCUSS:

- Why was this a bad hash function?

^ Circulate and looks for answers around the idea of collisions and easy-to-crack.
TWO REASONS:
Collision: This shouldn't happen a lot - but what if we had ten snack options? We still only have 6 snack boxes.
KP - CAN'T GO BACKWARDS. With something so simple, this would be easy enough to crack.
The main solution is to use a more advanced hash function. (Even then, we may run into collisions, but we aren't going to focus on that today.)

---

# A Better Hash Function

Using that same `snackLength` as an input, use this hash function to calculate a digest:

```js
function hashMe(input) {
  var hash1 = input % 7;
  var hash2 = (input * 2) % 6;

  var finalHash = ((hash1 + hash2) % 7) + hash1.toString() + hash2.toString();

  return finalHash;
}
```

^ Provide print-outs of this so instructors can write each step by the code if that's helpful.

---

# A Better Hash Function

Find the snack bin with your new-and-improved snack hash on it. Discuss with your snack friends:
- What was better about this algorithm? What is the evidence?
- What does our hash digest have in common with other groups'?
- What are the weaknesses of this algorithm? Explain.

^ Instructors should walk to snack bin and be talking right away.
Questions to prompt:
- Do we have any collisions this time?
- Would this be easy to 'undo' and figure out the algorithm?
- What if you made a typo - spelled the snack wrong but had same number of characters?
- What if we have M&Ms and Twix? (collision)
Instructors should grab their snack and go back to their seats.

---

# Whole Group Share Out

- What do all of these hash digests have in common?
- What are the weaknesses?

^ What do all of these hashes have in common? (Same size output - connect to same size of jars.)
What are the weaknesses? (Just checks length, easy to crack. We should be able to see a significant difference between the hashes cookies and cooikes and Cookies.)

---

# Think Pair Share

Considering all we've talked about so far today, what would you list as the top 2-3 key points about hashing?

^ Write about this for 1 minute, talk with partner for 1 minute, then group share out.

---

# A Better Hash Function

- MD5, SHA-1, SHA-256
- Fewer collisions
- Nearly impossible to go backwards

^ There are some advanced hash algorithms out there that can be used to hash values. They have varying degrees of security - we won't get into those details today. SHA-1 is the hash function that is used to create the 40-character sha for git commit messages. https://blog.thoughtram.io/git/2014/11/18/the-anatomy-of-a-git-commit.html#introducing-sha-1
We are now going to get some practice with MD5 and SHA-256, which should really highlight some of these ideas for you!

---

# The Facts

- Any slight change in input will result in a drastic change of the output
- No matter the input size, the outputs will all be the same size
- There should be no way to get back to the original string

^ Connect back to snacks:
- Change to input - misspelling.
- M&Ms is 4 characters and fruitsnacks is 11 - both have a 32 character hash.
- We would have to pass the snack string through the function and check if they are equal to check it, there is no way we can get back to twizzlers from `fa35ee149271702880f71de42101afdb`.

___
