---
title: Accessibility Best Practices
---

Context
----------

Accessibility is often overlooked when designing applications. It is an extremely important part of inclusion. A developer must think about accessibility from inception.  

In order for us to really understand how to build a rich web experience, we need to know how the web looks like and feels like for those with accessibility needs.

Goals
-------

-   Build empathy for people with accessibility needs
-   Identify the 4 main accessibility issues
-   Build familiarity with accessibility tools

The Need
-------

There are 3 billion (and counting) people using the internet.

In America alone, there are 57 million Americans with a disability (2012).

Consider the following statistics from the [Census Bureau's survey taken on July 25, 2012](http://www.interactiveaccessibility.com/accessibility-statistics).

-   19.9 Million (8.2%) have difficulty lifting or grasping. This could, for example impact their use of a mouse or keyboard.
-   15.2 Million (6.3%) have a cognitive, mental, or emotional impairment.
-   8.1 Million (3.3%) have a vision impairment. These people might rely on a screen magnifier or a screen reader, or might have a form of color blindness.
-   7.6 Million (3.1%) have a hearing impairment.  They might rely on transcripts and / or captions for audio and video media.

According to the [Pew Internet Project Survey conducted by Princeton Survey Research Associates International](http://www.practicalecommerce.com/articles/1417-Accessibility-How-Many-Disabled-Web-Users-Are-There-), 54% of adults living with a disability go online.

So it's about time we start creating web applications that will accommodate all people. As people who are soon going to be moving into the development field, you have the ability to be the change needed in our community.

The internet is a free service that should be accessible to everyone regardless of skin color, socio-economic background, and on top of that physical ability.

We all have become developers for the greater good of those around us. We entered this field because we will have the skill set to solve problems most people can't even begin to understand. One of the easiest and best places to start is to make sure the internet accessible to those who need it.

We need to not view these as edge cases but instead, begin to advocate for their experience. If the internet was meant for everyone then we should make it for everyone.

Tim Berners-Lee, the creator of HTTP/HTML, tweeted in front of 90 million people during the London Olympics 'this is for everyone'

The computer will always do exactly what you tell it to. Maybe its time we start telling them to do the right thing.

Identifying the 4 main accessibility issues.
------------

Here are the top 4 accessibility things to look out for on the web:

-   Visual
-   Mobility
-   Cognition
-   Hearing

Making sure we help accommodate these users allows us to really gear and tune our UI for everyone.

Today, we will talk about the first three on the above list.

Visual
----------

### Tools Needed

-   [`chrome vox`](https://chrome.google.com/webstore/detail/chromevox/kgejglhpjiefppelpmljglcjbhoiplfn?hl=en), a screen reader
-   [`I want to see like the colour blind`](https://chrome.google.com/webstore/detail/i-want-to-see-like-the-co/jebeedfnielkcjlcokhiobodkjjpbjia?hl=en-GB), a chrome extension that emulates color blindness

### Experiment 1

First, read through [this article](http://bleacherreport.com/articles/2662974-nfl-players-pay-tribute-with-usa-themed-cleats-on-911-anniversary?utm_source=cnn.com&utm_medium=referral&utm_campaign=editorial) from CNN.com.

Once you've done that try going through the article with your eyes closed using the `chrome vox` extension installed.

Navigation Tip: hold `command + control` and then press the `down` or `up` key to navigate up and down the page.

#### Go Further

If you're interested on how some people with mainly visual needs interact with the web check out this [video](https://www.youtube.com/watch?v=LdVlbO7_hz8&feature=youtu.be).

### Experiment 2

If you're wondering what color blindness is here is a definition found online.

`` Color blindness, also known as color vision deficiency, is the decreased ability to see color or differences in color. The most common cause of color blindness is due to a fault in the development of one or more of the three sets of color sensing cones in the eye.``

Utilize the color blind extension and visit your favorite websites like Facebook or Instagram and experience how the color change effects your user experience.

Navigation Tip: Some websites do not allow `I want to see like the colour blind`, left-click page and click `Experience Colour Blindness`. If `I want to see like the colour blind` is enabled, you will see a list of options on how to experience the site.

### Discussion

1.  What was the biggest difference between both experiences?
2.  What was the most frustrating thing for you?
3.  Could you get the screen reader to read the whole article for you?

#### Code tip!

One big thing that can effect users is that sometimes forms utilize radio buttons. The issue with the visually impaired is that many times those radio buttons are difficult to click. What we can do to help improve the experience for our friends is to allow the parent object to be clickable too. Often times it's just a matter of wrapping your radio button in a `label` tag. check out the following [Codepen](https://codepen.io/paul66/pen/jKBzu) don't mind the ``JS`` look at the css and the ``html``

These are some easy changes we can implement for application to be more accommodating.

Mobility
--------

Mobility is an issue where the user typically has difficulty using a mouse or a trackpad. The first and easiest thing we can do as developers is making sure we are making our application completely usable with just a keyboard.

#### Video

Watch this video from Dinosaur.js [here](https://www.youtube.com/watch?v=hKIQkgPVXH4&feature=youtu.be) go up to the 10 minute mark

### Experiment

Go to [Auto Traders](http://www.autotrader.com/) website and tab around.

1.  What was your experience like tabbing around?
2.  How was the focus?
3.  Did you tab into the dropdown field?

#### Go Further

Check out [this article](http://archive.tlt.psu.edu/accessibility/tabindex0.html#whyzero) (make sure to inspect the ``html``)

If you're tired of reading, watch this [video](https://youtu.be/rvG7L-gsSuo) instead.

### Discussion

1.  Do you see a benefit to using `tabindex`?

2.  What did you notice about the Auto Trader website while only using tab interaction?

#### Code Tip

Never adjust the focus on your application. Without the focus there is literally no way for a user to know where they are in your application.

One thing you want to consider is utilizing the ``tabindex`` attribute. What's great about this is if you set the ``tabindex`` of something to zero it acts like a ``stop sign`` that makes the screen reader and or tab focus move to a specific part of the page.

Cognition
------

Cognitive issues is defined by `webaim` as this:

> The concept of cognitive disabilities is extremely broad, and not always well-defined. In loose terms, a person with a cognitive disability has greater difficulty with one or more types of mental tasks than the average person. There are too many types of cognitive disabilities to list here, but we will cover some of the major categories. Most cognitive disabilities have some sort of basis in the biology or physiology of the individual. The connection between a person's biology and mental processes is most obvious in the case of traumatic brain injury and genetic disorders, but even the more subtle cognitive disabilities often have a basis in the structure or chemistry of the brain.
>
> A person with profound cognitive disabilities will need assistance with nearly every aspect of daily living. Someone with a minor learning disability may be able to function adequately despite the disability, perhaps even to the extent that the disability is never discovered or diagnosed. Admittedly, the wide variance among the mental capabilities of those with cognitive disabilities complicates matters somewhat. In fact, one may reasonably argue that a great deal of web content cannot be made accessible to individuals with profound cognitive disabilities, no matter how hard the developer tries. Some content will always be too complex for certain audiences. This is unavoidable. Nevertheless, there are still some things that designers can do to increase the accessibility of web content to people with less severe cognitive disabilities.

With that being said this topic is a little more abstract.

#### Article

Read this article regarding cognition accessibility [here](http://ncdae.org/resources/articles/cognitive/).

### Experiment

Dyslexia is a reading disorder characterized by trouble reading despite intelligence.

Checkout this [document](http://geon.github.io/programming/2016/03/03/dsxyliea) that replicates what it looks like to have dyslexia.

### Discussion

1.  What steps can we take to consider people with cognitive issues?

2.  Can you think of any website you know that would be difficult to use for someone with cognitive issues?

#### Code Tip

Organizing your data in a way that is decreeable and engaging for the user will help combat this. Some things we can do to help draw attention to our document:

-   Using proper headings, and lists
-   Using more white space in your design
-   “Chunking” content into more manageable pieces
-   Making forms manageable by breaking them into multiple, sequential steps
-   Providing a logical reading order
-   Being consistent with fonts, colors, and locations of page elements
-   Offering keyboard access
-   Consider offering content in multiple formats

Finding Violations
------------

-   Add the [`axe` extension](https://chrome.google.com/webstore/detail/axe/lhdoppojpmngadmnindnejefpokejbdd?hl=en-US).
-   In the developer tools of any website, click on the "aXe" tab and "analyze violations" which will display any violations for a given site.

Wrap up
--------

Now that we are more aware of what is going on in the world of accessibility, what are we going to do to make sure we are committing ourselves to making the web a better place for everyone?

Write down 3 actionable commitments you can do in your next coming projects to accommodate for accessibility issues and submit them [here](https://goo.gl/forms/0raVEfJPK3ktexDr1).
