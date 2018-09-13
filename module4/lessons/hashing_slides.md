footer: Hashing
slidenumbers: true

# Hashing

^ notes
- Collections
- The dream of a hash function is constant time lookup no matter how many elements
- add in a middle level between MD5 and %6 that they can do by hand - my chunk should NOT require any computers.
- no computers during entire 1st third of lesson.
- build in what the MD5 part looks like in 2nd third of lesson.
- TONE - timing, clarity of expectations, start and stop times, how do we set and shape tone, opportunities to change it mid way.

---

# Welcome. Choose a Snack

- Choose ONE snack for yourself
- Resist the temptation & do NOT open it yet

^ Make sure that everyone has a snack, and that all four snacks were selected at least 1x. If someone didn't select a snack, give them the least popular one.

---

# Learning Goals

* Instructors will be able to explain the key features of a hash
* Instructors will be able to explain what hashing is and where it is used in the real world

^ KEY POINTS:
- There is no way to take the hash and go back to original string
- Inputs can be any size
- Outputs will always be the same size
- Any slight change of input results in drastic changes of output

---

# Count the Letters

NOT including spaces, find the number of characters in your snack's string. Spell it correctly.

^ Snacks:
- fruitsnacks
- chips
- twizzlers
- M&Ms

---

# SnackLength % 6

This should result in a number 0-5.

Drop your snack off in the bin with your number on it.

^ We should see a collision with chips & fruit snacks in snack bin 5. People should stay at their bin.

---

# Pitfalls of our Hash Function

DISCUSS:
Why was this a bad hash function?

^ Circulate and looks for answers around the idea of collisions and easy-to-crack.
TWO REASONS: Collision: This shouldn't happen a lot - but what if we had ten snack options? We still only have 6 snack boxes. KP - CAN'T GO BACKWARDS. With something so simple, this would be easy enough to crack.
The main solution is to use a more advanced hash function. (Even then, we may run into collisions, but we aren't going to focus on that today.)

---

# A Better Hash Function

- MD5, SHA-1, SHA-256
- Fewer collisions
- Nearly impossible to go backwards

^ There are some advanced hash functions out there that can be used to hash values. They have varying degrees of security - we won't get into those details today. SHA-1 is the hash function that is used to create the 40-character sha for git commit messages. https://blog.thoughtram.io/git/2014/11/18/the-anatomy-of-a-git-commit.html#introducing-sha-1
Instructors should grab their snack and go back to their seats.

---

# Another Hash for your snack

- Go to `md5hashgenerator.com`
- Provide your snack name
- What's your new hash?

^ Now that we've seen the power of a better hash function, let's use one in hopes that we can find a unique way to store each snack. Go to https://www.md5hashgenerator.com/ and type in your snack name - make sure there are no spaces, spelling errors, and check capitalization.
Now, take your computer or phone and your snack to the appropriate bin.
- Do we have any collisions this time? Why?
- With people at your bin, make a prediction - if you make a small spelling error, maybe pluralize your snack, or capitalize one letter - how different do you expect the hash to be? Why?
- Try out a couple 'close' inputs with the MD5 Hash Generator - is your hash close?

---

# Another Hash for your snack

PREDICT & DICUSS:

If you make a small spelling error, how different do you expect the hash to be? Why?


^ Now that we've seen the power of a better hash function, let's use one in hopes that we can find a unique way to store each snack. Go to https://www.md5hashgenerator.com/ and type in your snack name - make sure there are no spaces, spelling errors, and check capitalization.
Now, take your computer or phone and your snack to the appropriate bin.
- Do we have any collisions this time? Why?
- With people at your bin, make a prediction - if you make a small spelling error, maybe pluralize your snack, or capitalize one letter - how different do you expect the hash to be? Why?
- Try out a couple 'close' inputs with the MD5 Hash Generator - is your hash close?
Once they try it out - DISCUSS as a group and stamp the KP - even the slightest change in input results in a drastic change in output.
Send instructors back to their table.

---

# Similarities and Differences

Find a friend with a different snack. Discuss:
- What is different about your hashes?
- What do your hashes have in common?

^ KP: No matter the size of the input, the output is always the same size. In this case, 32 characters. Think about our snacks - M&Ms are tiny compared to a bag of chips. BUT, the snack bins were all exactly the same size.

---

# The Facts

- Any slight change in input will result in a drastic change of the output
- No matter the input size, the outputs will all be the same size
- There is no way to get back to the original string

^ Connect back to snacks:
- Change to input - misspelling.
- M&Ms is 4 characters and fruitsnacks is 11 - both have a 32 character hash.
- We would have to pass the snack string through the function and check if they are equal to check it, there is no way we can get back to twizzlers from `fa35ee149271702880f71de42101afdb`.

___
