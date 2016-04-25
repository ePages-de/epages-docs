---
layout: post
title: "Codemotion 2015 - One epagee was there!"
date: "2015-12-04 12:00:00"
categories: events
authors: ["Ángel"]
---
The Codemotion conference took place in Madrid on November 28 and 29. With more than 1900 software enthusiasts, Codemotion is the biggest IT event in Spain.
This conference was sponsored by companies such as IBM, Microsoft, Arsys, Mozilla and Google...

Two days filled with talks from 12 different tracks, where each track focussed on a specific theme such as  Software Quality, Agile Methodologies, Clean Code, Testing, Big Data, Infrastructure, Scala, Java, Cassandra, MongoDB, Apache Drill, Selenium and Spark...
Some of them have been broadcasted, giving you the chance to watch them on [Youtube](http://2015.codemotion.es/streaming.html) (unfortunately only available in Spanish).

It was a good opportunity to get inspiration and I really enjoyed the variety of talks, which allowed me to get to know new technologies and discover different points of view on how to deal with tricky situations in some of the most well-known technology companies.
From my point of view, each talk had different levels of difficulty and quality.
I think that most of the speakers were quite experts in the topic. I would like to highlight here some talks that I consider the most interesting.

## The process for having quality software in 4 steps

This talk was about how to deal with the challenge of designing software with guarantees for a quality result, and the methodology used by IBM to achieve that goal.
That methodology is called "Design Thinking", and it takes care of user experience during the whole development process.
It is based on four core principles: Understand, Explore, Prototype, Evaluate.
The main goal of "Design Thinking" is to create a real and intuitive experience, understanding the users’ needs, weak points, exploring solutions, prototyping the experience and evaluating results.

## Love your tests and Microservices testing

Some companies are migrating their huge monolithic applications towards something called service-oriented.
One of these companies is [Tuenti](http://www.tuenti.com/), which had to face plenty of challenges to migrate its social network code in order to become a high-tech virtual mobile network operator integrating different third party services.
It is said that code tests take place before delivering the product to production environments, but unfortunately most of technology companies have several issues in real environments.
Some given recommendations in this talk were:

* Make different tests: unit, integration (services and API) and UI.
It is recommended to create a 70% of Unit tests, a 20% of Integration test and 10% of Acceptance test.
* Avoid Ice-cream cone anti-pattern.
* Refactoring old code, and more refactoring after refactoring...
* Clean code: describes a lot of principles and "best practices".
* Mocks, mocks everywhere.
* Use Name conventions.
* Given-When-Then is a style of representing tests, specifying a system's behaviour.
* Software development needs professional people, making tests is professional!

Finally, none of this is written in stone, but we want to do something. Some small steps towards professionalism.

## DevOps Mashup. Microservices, ELK, Cloud and continuous delivery

Nowadays, the software engineering approach called "Continuos Delivery" is becoming more and more popular, where software is produced in short cycles and launched faster.
This approach improves the market time and reduces cost and risks while delivering updates of the real system.
In this talk, people from [AtSistemas](http://atsistemas.com/en/) presented their own tool based on Cloud deployment methodologies with microservices.
Everything was automatically deployed in a cluster of containers managed by Docker Swarm.
Data was shown in a dynamic way by Logstash, indexed in ElasticSearch, and all orchestrated with different tools such as Jenkins, Rundeck, Chef and Consul.
