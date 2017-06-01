---
layout: post
title: "API writing - just copy and paste?"
date: "2017-06-01 06:34:02"
image: blog-header/api-journey.jpg
categories: api
authors: ["Birgit"]
---

For many, API documentation is a very abstract topic.
Is it just copying and pasting text?
Or about making things nice and shiny?
Do API writers just polish some wording here and there?

Come with me on a little API docs journey and you'll see, what it is really about.

## Speaking up for API writers

If you're not born and raised as a developer, but still have to deal with APIs, you have to learn a lot, I mean A LOT.
API writers need a thorough understanding of the API, its functionality, authentication, parameters, return types, what it supports and what not.

They have to be flexible, proactive, sensitive, always present, well-organized...
Maybe just read [this post](https://developer.epages.com/blog/2016/11/30/what-its-like-to-be-an-agile-technical-writer.html), and you'll know about that part.

In a nutshell, it requires detailed expertise to write API documentation.

## Playing around with the software

At [ePages](https://www.epages.com/en/), we develop online shop software, and we'd like to give partners and external app developers the best possible support to integrate with us.
They need great docs.
But before I can start writing straight away, there's some groundwork to do.

As the shop administration reflects what's implemented in our API and I need to understand the functions and features, it's a good idea to play around with the shop administration first.

And this is how I get started with it:

* Take care of a test shop.
* Think about a storyline for my test shop business.
It should reflect a real business and the data should be presentable in the public API docs later.
* Set up the shop with products, categories, payment methods, and shipping zones.
* Do some shopping, and place and process some orders.

While doing all this, I'm already right in the middle of shop usability testing.
Which function or feature is where?
Is it supposed to be like that?
Does it work at all?
Is it intuitive to use?

We really want our merchants to be successful with our software, so any of these findings are useful feedback for our UX experts.

## Setting up the working environment

On the side I can set up the environment to interact with the API:

* Get credentials to access the API.
* Set up my [REST client](https://paw.cloud/).
* Consult the internal developer documentation.

## Understanding the API mystery

Now it's all about TRYING IT OUT.
This is definitely the most demanding and time-consuming, but also the most interesting part of the job.

Step by step I make my way through the API and basically try out every existing REST call myself.

{% imagebasic blog/blog-try-rest-api.png Example_REST_call %} image {% endimagebasic %}

This is what I deal with:

* Receiving and refreshing a token.
* Request and response headers.
* Error codes and when they do appear.
* Understanding why a call did not go through and how to solve it.
* Learning about every single implemented attribute and the meaning behind it.
* Checking *where* in the shop administration *which* function or feature is reflected and *what* happens, when it's changed.

I'll note down all my findings, discuss it with the developers and with it improve my API knowledge and skills.

## QA inclusive

Oh, talking about findings...
While intensively trying out the REST calls and working with the user interface, it may happen that I stumble upon things that don't work as expected - sometimes also referred to as bugs {% emoji wink %}.

## Text work(s)

Once I've gathered all information together, took notes, and received satisfying answers to all of my questions from the API developers {% emoji wink %}, I write down what I've learned to provide our readers with the best possible documentation experience.
This is a lot easier when you've had the time to go through the above mentioned steps.

## This and that

* Competitor analysis: how do others do things?
(You don't have to reinvent the wheel.)
* Structure of API docs: what, how, and where?
* Language issues: how to address the user?
Which tone of voice?
* Think outside of the box: what else does the target group want to know?
* Design: user-friendly look and feel of the website.
* Public docs: deployment to the platform.

## When all is said and done

There's still work to do.
As soon as everything is online and public, the docs need regular updates.
I have to keep track of the API changes, follow up with the teams, update the docs, and inform the users.

## Far from copy and paste

API writing is an extensive, multifaceted field of work.
It's challenging, but a lot of fun as well.
And for sure, I wouldn't do this job, if it was just copy and paste - because then I would be bored to death {% emoji wink %}.
