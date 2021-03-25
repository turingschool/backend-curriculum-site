---
layout: page
title: Promises with async/await
---

## Promises can get unruly at times
One of the downsides to using Promises is that we can get lost in the chaining many `.then`’s. Luckily there is a way that we can make things a bit more manageable for our own purposes. 


### Enter async/await

#### So what are the differences?

The primary difference between the two is simple: 
- If you’re using standard Promises, only the Promise chain itself is asynchronous. We see this with the use of many `.then`s. 
- If you’re using `async/await`, then the entire wrapper function is asynchronous.
- Another big difference is that Promises with `async/await` will only continue its work once the previous Promise has resolved. 

#### A simple example with async/await

Below is a simple example of how we can use `async` and `await` with the same third party API that we saw in class. We simply want to fetch a list of posts, extract them out of the Promise, and then display them in the console.  

```javascript

// This function allows us to get async/await. Notice a difference?
async function fetchAsync() {
  let response = await fetch('https://jsonplaceholder.typicode.com/posts');
  let posts = await response.json();
  return posts;
}

// This is how we use our async function
fetchAsync()
    .then(data => console.log(data))
    .catch(reason => console.log(reason.message))
```

#### Discussion: How is this bit of code working above? What is different than using standard Promises? 

### Error handling

Let’s take a quick look at how we can handling any errors that may occur while fetching data.

```javascript
async function fetchAsync() {
  try {
    let response = await fetch('https://jsonplaceholder.typicode.com/posts');
  let posts = await response.json();
  return posts;
  } catch(err) {
    console.log(err);
  }
}
```

#### Which one do I pick to use?

The easiest way to know which one to pick standard Promises or go down the async route is the number of `.then`s that you may be using to extract data from a server. If you find yourself chaining on multiple promises together, it may be a better idea to use `async` instead of the standard Promise. 

## Hedgehog Party - Revisited
Let’s use the same [Hedgehog Party Repo](https://github.com/turingschool-examples/fetch-hedgehog-party)  as yesterday. If you need another reminder on how the API works, take a minute to look over the README another time.  

You can also use your Base JS repo that we used yesterday. Once you have that setup and ready to go, let’s try to hit the first endpoint from the Hedgehog Party repo and grab all of the invites using `async/await`.
