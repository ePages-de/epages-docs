---
layout: post
title: "Karlsruher Entwicklertag 2016"
date: "2016-06-23 08:16:17"
image: blog-header/karlsruhe.jpg
categories: events
authors: ["Benjamin and Birgit"]
---

From the 15th to 17th of June, the [Karlsruher Entwicklertag](https://entwicklertag.de/karlsruhe/2016/) took place at the [IHK Karlsruhe](https://www.karlsruhe.ihk.de/).
Despite its name, it is a 3-day event with two conference days, and a tutorial day.

The frame of each day was formed by a morning keynote, 36 session slots in 6 parallel tracks, and an evening keynote.
The first day, the Conference Day, was dedicated to development issues, and the talks had been assigned to topics such as Invited Talks, Microservices & Tools, Java User Group, Softwerkskammer, DevOps & Security, and JavaScript.
The Agile Day then focused on agile topics such as Beyond Agile, Agile Scaling, Architecture, Enterprise Agile & Innovation, Testing, and Agile Teams.
The Tutorial Day covered topics such as Scrum Patterns, Architecture Katas, or Advanced testing strategies with AngularJS.

In this post, I will mainly talk about the Conference Day, and the various sessions I was particularly interested in.

## Conference Day

For my colleague Bastian and me, the conference day kicked off with the presentation of our talk on ["Continuous Delivery Pipeline: Test Aggregation and Evaluation for DevOps"](https://entwicklertag.de/karlsruhe/2016/einblick-die-maschinerie).
In 45 minutes we explained our journey with a solution approach that also outlined some best practices and learnings from working with [Docker](https://www.docker.com/), [CircleCI](https://circleci.com/), and [Elasticsearch](https://www.elastic.co/de/products/elasticsearch).

<script async class="speakerdeck-embed" data-id="8b6da8e8a6984137a11e7d91e0c7a967" data-ratio="1.37081659973226" src="//speakerdeck.com/assets/embed.js"></script>

### "Behaviour-Driven Development in Java with JGiven", by Dr. Jan Schäfer

[JGiven](http://jgiven.org/) is a new BDD framework, which tries to solve the different issues that Cucumber, JBehave, Concordion, or Fitness could create in large-scale projects with lots of team members.
Most of these tools try to start with a textual description of the test scenarios in the "Given-When-Then-Format” (as a plain file or table), and then try to generate the source code skeleton, that serves as implementation aid for the developer.
Over time, lots of manual synchronisation errors between annotated refactored test classes in the source code and the test scenarios may occur, especially in larger projects.
Here is where JGiven shows its strength.
JGiven starts with the code, just runs the tests, and outputs a report, and a pending (TODO) test list.
By using a defined business-readable test case syntax a great readability in the source code itself could be achieved, and even a product owner is still able to write tests.
Furthermore, it features Spring Auto-Wiring, stage abstraction, quantity parameters, and test object abstraction allocation.
Other competitive frameworks are Spock (in Groovy) and Serenity (in Java).

### "JUnit5", by Johannes Link and Matthias Merdes

{% image blog/blog-karlsruhe-junit.jpg %}

Interestingly, the next major iteration of [JUnit 5](http://junit.org/junit5/) raised over 53,000 euros on [IndieGogo](https://www.indiegogo.com/projects/junit-lambda#), which could finance several arrangements like a workshop in Karlsruhe with the folks from the big IDE companies, eclipse and IntelliJ, as well as Pivotal for an optimised tooling support.
The runner concept from the previous version is abolished so that you can use multiple extensions in parallel.

Another interesting feature is `@assertAll`, which does multiple asserts without stopping when in the meantime a failure occurs, so that the test result is more significant (e.g. a comparison of all personal data including addresses).

What else?

* Annotations can now be used for tags or descriptions.
* You may also create your own test annotations with retention policy hooks.
* Nested tests allow BDD-style test case structures.
* All test are executed dynamically without a runner, which show the results progressively.

### "Better Java-Code with Type Annotations)", by Dragan Zuvic

{% image blog/blog-karlsruhe-jsr.jpg %}

A talk that presented many conceptions on how to write your own types and format checkers.
Quite interesting!

### Keynote: "Microservices", by Eberhard Wolff

{% image blog/blog-karlsruhe-microservices.jpg %}

Key topics of this talk: how to deal with maintainability, redundant data, and redundant code for software systems.

Eberhard showed in several iterations how legacy code was tried to be rewritten, and later ended in another legacy code project even so new methods and ideas were applied.
Albert Einstein defines such continuous repetitions with ending up in the same negative state "Insanity".

Unfortunately, doing the same thing over and over again and expecting different results is a dilemma that the software industry has not been able to solve yet.
On the on hand, Eric Evans' approach for domain driven design with an ubiquitous language, value objects etc. does often not work for solving this architectural erosion problem but on the other hand introduced the helpful concept of bounded contexts.
The talk elaborated on a central data model vs redundancy issues for data models and data bases.
One conclusion was that different views justify duplication but each bounded context needs to be self-contained with as little as possible dependencies to be autonomous.
We can achieve maintainability with clear architecture, firewalls, and recyclable modules but we cannot achieve clear architecture code systems in general.

### Evening event: World Cafè

The topic of the world cafe discussions was how to ensure secure application development in the age of mobile, cloud infrastructure, and the Internet of Things (IoT)
Several IT Security Experts helped to create some meaningful mindmaps.

## Summary

It had been three great conference days with lots of interesting talks and an awesome atmosphere.
And of course, it was a special highlight that two ePagees had the chance to present a talk.

We look forward to the next conference next year.

## Related links

* [Conference Day](https://entwicklertag.de/karlsruhe/2016/conference-day)
* [Agile Day](https://entwicklertag.de/karlsruhe/2016/agile-day)
* [Tutorial Day](https://entwicklertag.de/karlsruhe/2016/tutorial-day)
* [Speaker Deck](https://speakerdeck.com/dataduke/continuous-delivery-pipeline-automated-test-evaluation)
