---
layout: post
title: "Scrum Basics: Estimating"
date: "2016-01-26 07:23:00"
image: blog-header/estimation.jpg
categories: agile
authors: ["Anja B."]
---

Welcome to part four of our Scrum Basics Series.
Today we will have a look at estimation principles and techniques used in Scrum.

There are some basics that are completely different to estimations in waterfall projects.
For example, in Scrum we don’t estimate time, but effort.
Also tickets are estimated relative to each other or to example tickets the team created.
In Scrum we estimate in story points.
But in order to know what that means you need to be clear about what a story is.

## Epics, Stories, Story Points and Velocity

An *Epic* is the ticket type used for features.
Developers would not work on it directly, but through stories.
That means a *User Story* is a small part of a feature.
It must be small enough to fit into a sprint and should work and be potentially shippable by itself.
A user story usually answers three questions: **Who** wants **what** and **why**?
Therefore it is structured in the following way: “As … I want … to be able to…”.
It’s called user story because it’s normally told from an end-user's perspective.
Each story also has acceptance criteria that have to be fulfilled to consider it done.
Ideally, it should also cover all expert areas within a team (e.g. for a piece of software it should contain backend and frontend development as well as design).

Within the Backlog Refinement the team members estimate the stories.
As already said, they don’t estimate time, but effort.
To symbolise the effort, Scrum Teams use *Story Points*.
Those are typically [Fibonacci numbers](https://en.wikipedia.org/wiki/Fibonacci_number): 1, 2, 3, 5, 8, 13, 21.
An alternative are T-shirt sizes.
Those are usually more roughly because they only represent 4 stages: S, M, L or XL.
To being able have a more precise measurement, most often some of the Fibonacci numbers are assigned to the T-shirt sizes (e.g. S=2, M=5, L=13, XL=21).
The idea behind using Fibonacci is that the bigger a ticket is, the harder it gets to estimate it precisely.
Therefore, the steps between the numbers will increase.

{% image blog/blog-scrum4-burndown-chart.jpg %}

During the sprint the story points of all closed tickets are counted.
In the end you get a number that represents how much a team is capable of solving within a sprint.
Measure this number across several sprints and build an average and you get the so called *Velocity* of a team.
Velocities between different teams are not comparable, since every team has its own understanding of the effort behind a story point.
The Product Owner can use the velocity for long-term planning.
To help the team see how good they are on track within a sprint, Scrum uses so called *Burndown Charts*.
They show the number of closed story points on a time scale representing the sprint.

## Planning Poker

{% image blog/blog-scrum4-planning-poker.jpg 45% left %}

Planning Poker is probably the most used estimation technique in Scrum.
For this technique every team member gets a set of Planning Poker cards, which show the Fibonacci row.
At the beginning the Product Owner presents a ticket that needs an estimation.
The team then clarifies all questions regarding the ticket.
Then each member chooses the effort they thinks fits best to this card.
All cards are then turned around at the same time for everyone to see.
The team discusses especially the highest and lowest number to understand the reasons why the team members chose those numbers.
In the end the team has to agree on one number.

This technique is good for teams that are new to each other.
With Planning Poker they get a better understanding of how their Team partners estimate.
It’s also good for complex tickets that need a lot of discussion by the whole team.
On the counter side it’s a really time intensive estimation technique, since every ticket is discussed individually.
Also in the discussion part people tend to just go with the suggested number of the expert on the team for the particular field of interest.

## Magic Estimation

With Magic Estimation the team estimates the tickets by sorting them into buckets and shift them if necessary.
In detail it works as follows:

All tickets that need an estimation are spread equally amongst all team members.
The team members decide on their own or with the help of colleagues – discussion is very welcome – how many story points their tickets should receive and sort them into the according bucket (usually a piece of paper with the Fibonacci number or T-shirt size on it).
After all tickets have been sorted, the team walks past the buckets and everyone takes a look at every ticket.
If a team member thinks a ticket is placed incorrectly, they can move the ticket to another bucket.
But they have to mark it so everyone knows the ticket has been moved.
Then everyone walks past the tickets a second time and they can be moved again.
If tickets have been moved twice or more, these need to be discussed separately (e.g. with Planning Poker).
All other tickets are now estimated.
This technique is good for teams that know each other really well and for long lists of easier tickets (e.g. bug-lists).
It is much faster than Planning Poker but can lead to wrong estimations on complex tickets.

## Related posts

* [Scrum Basics: What is Scrum?](https://developer.epages.com/blog/2015/10/13/scrum-basics-1.html)
* [Scrum Basics: Scrum Roles](https://developer.epages.com/blog/2015/11/19/scrum-basics-2.html)
* [Scrum Basics: Scrum Meetings](https://developer.epages.com/blog/2015/12/15/scrum-basics-3.html)
* [Scrum Basics: Principles and Values](https://developer.epages.com/blog/2016/02/25/scrum-basics-5.html)
* [Scrum Basics: Practicing it](https://developer.epages.com/blog/2016/03/22/scrum-basics-6.html)
