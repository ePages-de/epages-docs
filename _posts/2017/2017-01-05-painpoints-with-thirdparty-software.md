---
layout: post
title: "4 pain points in third-party software development"
date: "2017-01-05 10:00:00"
image: blog-header/challenge-cube.jpg
categories: tech-stories
authors: ["Mats"]
---

Anyone will probably know the challenge of making a decision as a member of a group.
Deciding something on your own is generally simpler than finding a conclusion together with others.
As soon as different interests, ideas, concepts, or mindsets meet, finding a satisfying compromise for everyone will be a challenge.
The same translates to communication between different software systems.
Once you need to interact with external software services you have to adapt your implementation and sometimes make compromises.

In this article I will talk about the different challenges we faced as a software development team in e-commerce, working with plenty of different third-party services in the past years.

### 1. Missing knowledge about the service

Many third-party services require a lot of in-depth knowledge before you can actually connect it to your application.
For instance, it requires some understanding of the US tax system if you want to connect your software with a US accounting solution.

Basically, a one-way communication where you just need to fetch information from a remote source won't require as much knowledge about the target service as a bi-directional communication.
There you would also need to publish information to the service your are connecting with.
This, of course, can vary heavily depending on the type and purpose of integration you are aspiring to achieve.

### 2. Increased bug potential

As soon as a software solution reaches a certain level of complexity, something like a bug-free application does not exist anymore.
An achievable goal is to keep the level of bugs as low as possible.
You should make yourself aware that as soon as you connect your software with another external application you will duplicate the chance of bugs within your own software.
The reason is that you duplicate the potential sources that can cause failures or changes that affect your application.
This relation of course scales with the number of different services you connect to your software.

### 3. Difficult debugging

Speaking of bugs, having distributed potential error sources also makes it harder to track down unexpected behavior of the software, since the root cause of the issue can stem from any of the involved sources inside or outside of you own source code.

Most of the time you won't have access to the debugging tools or logs of a third-party service and even the best API documentation will lack information about uncommon edge-cases.
This often leads to a lot of trial-and-error debugging strategies while working with external services.

Having a direct technical communication partner for the service can be very helpful.
Unfortunately, this isn't always the case.
And even if you have a technical contact the asynchronous communication will at least slow down your developing process because of all the interruptions and waiting times.

### 4. Difficult testing conditions

As software testing is especially important to cover very specific edge cases, it can be challenging to test your application properly once you connect with an external service.
Usually, integration partners will provide sandbox environments, test credentials, and well-written documentation of the services they offer.
But as mentioned before, even the best documentation might miss information of very specific corner cases or compromises that you, as the integrator, had to commit in order to couple the different systems with each other.

Furthermore, even the slightest difference in behavior between a sandbox and a live environment can make a big difference.
Providing a test environment that works exactly the same as the live environment is of course the responsibility of the service owner.
Although this usually works quite well, in rare cases you can run into differences that the service provider might not even be aware of.
My point is not to say you shouldn't trust sandbox environments, but it's always worth to keep that fact in mind.
Especially in case you experience a behavior that you are unable to reproduce with a sandbox environment.

### Stay tuned

In a follow-up post, I will talk about the best practices and workflows we defined to deal with those challenges.
You might find those helpful once your are in the situation of working with a third-party service.

### Related posts

* [How we connected Sage One with ePages](https://developer.epages.com/blog/2016/08/12/how-we-connected-sageone-with-epages.html)
* [How to easily connect payment and shipping with online shops](https://developer.epages.com/blog/2016/08/02/how-to-easily-connect-payment-and-shipping-with-online-shops.html)
* [Payment integrations](https://developer.epages.com/blog/2015/11/03/payment-integrations.html)
* [Challenges of integrating third-parties](https://developer.epages.com/blog/2015/07/20/challenges-of-integrating-third-parties.html)
