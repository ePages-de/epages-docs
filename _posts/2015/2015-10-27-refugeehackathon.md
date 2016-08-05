---
layout: post
title: "#refugeehackathon"
date: "2015-10-27 12:00:00"
categories: events
authors: ["Jan"]
---

Lots of refugees arrived in Germany.
Tasks like organising accommodation, food and clothing and supporting them with their onwards journey raises many challenges.
Though I am not able to work day and night for the solution like some people in the crisis management group, I wanted to fly the flag to show that a significant amount of people are willing to help.
This blog post is a report about participating in the #refugeehackathon in Berlin, Germany.

## Overview of the event

The [#refugeehackathon](https://twitter.com/search?src=typd&q=%23refugeehackathon) started on Friday, 24th October 2015 with a requirements workshop.
A small group of people visited the refugees and talked about project ideas which could be helpful for them.
The official start was on Saturday morning.
After some welcoming words, a short video about the challenging situation of refugees travelling through Europe was shown.
Next there was a motivational speech from a Somalian lady.
She invited us not to label people as refugees but to regard them as newcomers.
Afterwards there was a presentation of project ideas from the workshop as well as outlining existing ideas.

## The Volunteer Planner project

The project which I selected was the [Volunteer Planner](https://volunteer-planner.org/).
It is an online platform which enables volunteers to sign up for tasks identified
by different aid organisations and is created by a handful of programmers, designers and project managers.
Though the project is only three month old and thus not yet feature complete they already have 19,354 registered users and 51,286 completed volunteer work hours.

{% image blog/blog-refugeehackathon-volunteer-planner.jpg %}

## What we achieved

At the beginning we collected and discussed feature ideas for the Volunteer Planner.
We prioritised the ideas (which was shown in
[the news](http://www.heute.de/refugee-hackathon-in-berlin-digitale-fluechtlingshilfe-in-48-stunden-von-it-leuten-40700228.html)) and then started to work in pairs on the things we were most interested in.
We implemented an overview page for individual aid organisations, a language switch and fixed a couple of interesting bugs.

My main focus was on the implementation of a feature which will enable staff of aid organisations to maintain their volunteer shifts by themselves instead of mailing them to the admin team.
We created a [wireframe model](https://gomockingbird.com/projects/fnzc6qu) for the shift creation workflow and a shift template mechanism similar to online banking transactions.
Later on, it should be extended with some kind of batch templates for the support of power users.
For some reasons we did not manage to finish the implementation in time so there is still some pending work after the hackathon.

## Conclusion

This #refugeehackathon was a very enriching experience for me.
I got to know interesting people and we had a lot of fun together.
On top of that, I learned a number of lessons about web development in general and Python/Django in particular.

Hopefully my journey will also result in a little bit of practical help for the newcomers.

So many thanks at [@ePages](https://twitter.com/ePages) for sponsoring me with some work hours, the train tickets and hotel costs.
