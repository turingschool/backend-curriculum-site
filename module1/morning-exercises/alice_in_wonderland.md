Use the following text from the first few pages of Alice in Wonderland to do the following:

- Save snippet to `alice.txt` file
- Create a `TextScanner` class.
- Solve for the following interaction pattern (solutions should be case insensitive):

```ruby
t =  TextScanner.new("alice.txt")
t.word_count
=> #  returns a hash with keys containing unique words, values are the number of times the word appeared
t.most_popular_words
=> # returns an array of the top 3 most used words in the text
t.longest_word
=> # returns the longest word in the text
```

```txt
Alice was beginning to get very tired of sitting by her sister on
the bank, and of having nothing to do. Once or twice she had
peeped into the book her sister was reading, but it had no pictures
or conversations in it, "and what is the use of a book," thought
Alice, "without pictures or conversations?"
So she was considering in her own mind (as well as she could, for
the day made her feel very sleepy and stupid), whether the pleasure
of making a daisy-chain would be worth the trouble of getting up
and picking the daisies, when suddenly a White Rabbit with pink
eyes ran close by her.
There was nothing so very remarkable in that, nor did Alice think
it so very much out of the way to hear the Rabbit say to itself,
"Oh dear! Oh dear! I shall be too late!" But when the Rabbit
actually took a watch out of its waistcoat-pocket and looked at it
and then hurried on, Alice started to her feet, for it flashed across
her mind that she had never before seen a rabbit with either a
waistcoat-pocket, or a watch to take out of it, and, burning with
curiosity, she ran across the field after it and was just in time to see
it pop down a large rabbit-hole, under the hedge. In another
moment, down went Alice after it!
The rabbit-hole went straight on like a tunnel for some way and
then dipped suddenly down, so suddenly that Alice had not a
moment to think about stopping herself before she found herself
falling down what seemed to be a very deep well.
Either the well was very deep, or she fell very slowly, for she had
plenty of time, as she went down, to look about her. First, she tried
to make out what she was coming to, but it was too dark to see
anything; then she looked at the sides of the well and noticed that
they were filled with cupboards and book-shelves; here and there
she saw maps and pictures hung upon pegs. She took down a
jar from one of the shelves as she passed. It was labeled
"ORANGE MARMALADE," but, to her great disappointment, it
was empty; she did not like to drop the jar, so managed to put it
into one of the cupboards as she fell past it.
Down, down, down! Would the fall never come to an end? There
was nothing else to do, so Alice soon began talking to herself.
"Dinah'll miss me very much to-night, I should think!" (Dinah was
the cat.) "I hope they'll remember her saucer of milk at tea-time.
Dinah, my dear, I wish you were down here with me!" Alice felt
that she was dozing off, when suddenly, thump! thump! down she
came upon a heap of sticks and dry leaves, and the fall was over.
Alice was not a bit hurt, and she jumped up in a moment. She
looked up, but it was all dark overhead; before her was another
long passage and the White Rabbit was still in sight, hurrying
down it. There was not a moment to be lost. Away went Alice like
the wind and was just in time to hear it say, as it turned a corner,
"Oh, my ears and whiskers, how late it's getting!" She was close
behind it when she turned the corner, but the Rabbit was no longer
to be seen.
She found herself in a long, low hall, which was lit up by a row of
lamps hanging from the roof. There were doors all 'round the hall,
but they were all locked; and when Alice had been all the way
down one side and up the other, trying every door, she walked
sadly down the middle, wondering how she was ever to get
out again.
```
