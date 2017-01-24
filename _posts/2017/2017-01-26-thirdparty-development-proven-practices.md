---
layout: post
title: "6 proven practices that make third-party development fun"
date: "2017-01-24 07:00:00"
image: blog-header/thirdparty-weapons.jpg
categories: tech-stories
authors: ["Mats"]
---

In my [previous post](https://developer.epages.com/blog/2017/01/05/painpoints-with-thirdparty-software.html) I talked about the pain points in third-party software development and the different challenges we're facing when connecting our e-commerce software to a third-party service.

Today, I will follow up on this and give an insight into our "weapons of choice" that simplify our work.
These workflows and best practices have been developed over a longer period of time and are continuously updated.
What I describe here is by no means meant as an ultimate guideline.
It's a collection of processes that turned out to work out well for us as a team dealing with third-party services on a day to day basis.

### Invest time on research

Once we know about a new integration, we experienced that it's very helpful to spent some time to research about that specific third-party upfront.
Most of the time we even go one step further and try to create a very rough prototype that spikes all the desired functionalities.
Investing this effort does not only help us to create more detailed tasks.
It also helps to identify potential mismatches of flows and concepts between the external service and our software, to gather open questions that need to be answered beforehand, or even to discover tremendous "dealbreakers" early on.

All this information helps our product owner with his estimations as well as our team during technical planning.
We consider potential problems right away and minimize the necessity to postpone decisions because of misunderstanding a specific service functionality.
A tool we use quite frequently exactly for this purpose is [Postman](https://www.getpostman.com/).
Postman allows you to play around with HTTP based APIs without having to deal with all the HTTP communication details.
That way, we can focus on testing the functionality of an API instead of wasting time on trivial communication details.

### Deal with it

Another major point is to prevent the increase of potential failures and changes.
Unfortunately, there is no recipe for a magic-potion or a special trick that I can tell you.
A higher chance of bugs and changes is just a fact you need to accept and learn to deal with while working with third-party services.
In our experience the best you can do to face this fact is strictly following specific software quality guidelines.
We spend quite some extra effort in order to produce readable and maintainable code since we know that it's very likely that we need to change things in the future.

### Apply a common coding style and run automated tests

We also agreed on complying with a common coding style and common concepts which you will be thankful for when debugging or changing parts of the software that was written by some co-workers.
The potentially strongest weapon we software developers have when dealing with constant software changes are automated tests.

We follow a strict line to always provide a high automated test coverage of our code.
That way we ensure to not break existing software functionalities with the changes we introduce.
In order to minimize the chance of bugs while also sharing knowledge within the team it is very important to frequently do code reviews.
Ideally every member of our team should know each module of the implementation we created.

When it comes to automated testing there is another concept that can help identifying changes in external services.
Create automated tests which runs against the their API and verify all functionalities you are using in your application.
Of course you then also need to run these tests on a regular basis.
Your own test pipeline will then instantly notify you about changes your integration partner introduced to their API.
This of course is especially helpful in case the communication with your integration partner is not ideal.
But it is also worth the effort even if you have a good communication with your partner.
Notifications regarding changes might become lost during communication in your partners company already.
Relying on hard facts will always be more direct and trustworthy then relying on manual notifications.
In our blog post [How we test our API](https://developer.epages.com/blog/2016/09/29/rest-api-test-framework.html) you can find some ideas on how we write tests against our own API at ePages.

### Involve the QA engineer

Another strategy that at least works very well in our team is working very closely with our QA engineer.
Including him in concept discussions, technical planning, and code reviews will help him understand potential issues that might arise. Working closely together also minimizes the chance of mistakes due to unclear communication or lack of background knowledge.

Sometimes a QA engineer might even bring in more user-oriented feedback which helps developers identifying specific users requirements.
A point that is worth considering not only for third-party development but in general.

### Track down the nasty bugs

If all the effort you invested was still not enough and you end up discovering that one of those beloved bugs still made it to your integration you have to face the challenge of tracking down the root cause of it.
The only good practice I experienced is to emphasize on very understandable and comprehensive logging in your part of the integration.
This will help  identifying where the nasty bug is hiding.
Comprehensive information is also important once you need to go into communication with your integration partner.
It will help them understand the situation and find the problem once they know the data used to communicate with their service.
As in any human conversation it is the same for software services that are communicating with each other.
Finding the root cause of a misunderstanding requires both parties to participate.
Hence, good communication with your integration partner is very important.

### Test against live environment

Talking about application testing...
Well, after testing your solution with sandbox environments it's always beneficial to test your application against the live environment.
This is not always possible but if you have the chance I'd recommend to do so.
Something you should also always do is take the feedback of your live users very seriously.
Especially if you weren't able to test your solution with the live environment.
Furthermore, working closely with customer service, QA, and the partner whose service you are integrating with are the best practices we discovered to face the challenge of testing your application.

There's more to it than that?
We are happy to learn about YOUR experiences.
