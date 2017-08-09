---
layout: post
title: "Tracing the suspect - a microservices murder mystery"
date: "2017-08-17 09:30:00"
image: blog-header/tracing-the-suspect.jpg
categories: tech-stories
authors: ["Jens"]
---

The [first post][haystack] in this series of blog posts about debugging microservices covered how we can produce structured log events to ease log aggregation.
We also introduced the concept of log correlation using a `correlation-id` that spans multiple microservices to connect related log events.
In this second post we will enhance the JSON log structure and dive deeper into the topic of **distributed tracing**.



[haystack]:                   /blog/2017/07/13/where-is-the-bug-in-my-microservices-haystack.html         "Where's the bug in my microservices haystack?"
