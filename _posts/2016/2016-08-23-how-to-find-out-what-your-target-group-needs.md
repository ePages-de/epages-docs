---
layout: post
title: "How to find out what your target group needs"
date: "2016-08-23 08:00:21"
image: blog-header/target.jpg
categories: api
authors: ["Birgit"]
---

Can we assume that technical writers know the target audience they are writing for?
Are they aware of the causes and purposes for their documentation?
And how can they know which information should be provided and in which level of detail?
In this blog post, I'd like to share my experience on how I tried to find out.

## Starting a documentation from scratch

When I started my job at ePages, I had to come up with a complete new structure as well as all relevant content for a brand new [API documentation](https://developer.epages.com/apps).
As a technical writer I found this position very comfortable as I could really start from scratch.
From our developers in-house, I found out pretty quickly, that opinions, views, and also tastes differ on what an API documentation must look like and how it should be structured.
But I had to identify the requirements of my **real** target group.

How to find that out?

* *Google: How should API documentation be structured?
How do "the others do it"?*
* *Dear Product Management, what is the persona, I should write for?*
* *Hey developer colleagues, what type of documentation do you use, and what do you usually dismiss?*

I drafted out a documentation scheme, discussed it internally, nixed it, drafted out again.
You know how that works.

At the end, I had a version I could launch with.
But I was not yet 100% sure it would be the perfect fit for my target group.

## Test on the living object

I was convinced, that I needed to test this "on the living object".
Fortunately, I work closely together with our Usability Expert Anja who offered to support me.
We agreed to conduct an online survey amongst the users of our API documentation.
The survey was published internally, communicated to our partners, announced on the [ePages developer blog](https://developer.epages.com/blog) as well as via [Twitter](https://twitter.com/epagesdevs).

### Categorizing the audience

As we expected differences in the required information with regards to interest in using our API, professional experience, and background knowledge, we asked some general questions to better categorize our audience:

* What is your relationship with ePages?
* Please rate your knowledge.
* In which occupational field do you work?

### Importance of content

Then we got right down to business and tackled questions regarding the content.
Here's an excerpt of what that looked like:

{% image blog/blog-api-survey-1.png %}

{% image blog/blog-api-survey-2.png %}

{% image blog/blog-api-survey-3.png %}

{% image blog/blog-api-survey-4.png %}

## Enlightened

In the last part of the survey we put a link to the current documentation version.
We asked how they would rate the ePages REST API documentation.
The result made me jump for joy as it showed that I was already on a good way:

{% image blog/blog-api-survey-5.png %}

People were also asked to give us a hint of what could be improved.
Amongst others they'd like to see:

* Code examples in the most popular programming languages
* SDKs
* Detailed information on responses

I learned about good API documentation that developers really like to work with, as:

* [PayPal API](https://developer.paypal.com/docs/api/)
* [Twitter API](https://dev.twitter.com/overview/documentation)
* [GitHub API](https://developer.github.com/)
* [Node.js](https://nodejs.org/api/all.html)

## Summary

Although we had just 26 participants, with this survey I was able to identify the informational needs of the readers of our API documentation.
It helped me to rework my first version of the docs, to better assess documentation change requests, as well as prioritize upcoming documentation tasks.
