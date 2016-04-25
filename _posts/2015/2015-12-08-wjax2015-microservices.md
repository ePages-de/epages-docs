---
layout: post
title: "W-JAX 2015 Retrospect Part 2: Microservices"
date: "2015-12-08 12:00:00"
categories: events
authors: ["David"]
---

With this follow-up article of the W-JAX retrospect, I'd like to concentrate on the microservices part of the conference.

## Living with microservices

The concepts to develop a software change regularly.
Some of these changes do not make sense.
They do not helps us in the development process and are only a refreshed concept of a dusted software idea: Give them a buzzword, talk about it, and everyone will use it.

However, a few of these new software design concepts are meaningful and solve current software development problems.
One of them is the idea of microservices.
The speakers of the W-JAX 2015 conference talked about this idea in many sessions.

### When do we need microservices

Developing software until now often had the idea of developing a [monolith](https://en.wikipedia.org/wiki/Monolithic_system).
With a monolith we build a software in one application with one database and (mostly) one programming language.
To test the complete software will entail huge tests.

With a few millions of lines of code developing and testing this big monolith will be a huge problem.
If the developer wants to invest more time in service instead of in extending his code they should think about switching to a microservice system.
This will also help to avoid using always the same patterns and requires a code generator to automatically create static structure.

### The idea of microservices

Basically, the idea of using microservices is to encapsulate every part of the software into a separate service.
Every service can run on its own and use its own de-central database.
If one service crashes the whole system can work without failing.
It is possible to run more instances of this service to scale it in case of being required more often.

To structure a monolith into small microservices, it is important to find a way to slice the software code into small parts.
The following checklist shows some important remarks:

- To be used in a way to avoid big communication.
If two components have to communicate very often both should be in the same microservice.
- Should not influence another microservice.
- Every microservice can stand alone without knowing other components of the software.
- Complete microservice should be handled by only one team.
If the sliced software component cannot be serviced by one team alone, slice it again.

### Challenges and hints

Microservices will put the weight of complexity from algorithm complexity to communication complexity.
The dependencies of each software part are now moved to the way of communication.

A second big challenge can be the [Two-Phase Commit](http://www.enterpriseintegrationpatterns.com/ramblings/18_starbucks.html) and data consistency.
Let's imagine we want to transfer money from one to another bank account.
The monolith would have a controller layer which sends a request to the model layout.
This layer will transfer the money from one bank account to another instantly.
In a microservice world every bank account can be in another microservice.
Microservice 1 will send the money to microservice 2 and decrease the money in its own database.
In this moment the money is not existent: neither in microservice 1 nor in microservice 2.

A very important concept is the **Design for Failure**.
With different services the input values of every service should be mistrusted.
Furthermore, every microservice has a fallback output value if something is wrong.

Another important hint is to monitor the communication over all microservices.
That is important to know in which component will be an error, why and when.
For this an overall identification number of each data element would be helpful.
Some tools like [Netflix/eureka](https://github.com/Netflix/eureka) help to monitor all microservices.

### Linked sources

- [The Art of Scalability](http://www.amazon.de/The-Art-Scalability-Martin-Abbott/dp/0137030428)
- [Building Microservices](http://www.amazon.de/Building-Microservices-Sam-Newman/dp/1491950358)
- [Domain-Driven Design: Tackling Complexity in the Heart of Software](http://www.amazon.de/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215)
- [Implementing Domain-Driven Design](http://www.amazon.de/Implementing-Domain-Driven-Design-Vaughn-Vernon/dp/0321834577)

## Related post

[W-JAX 2015 Retrospect Part 1: Agile Day](https://developer.epages.com/blog/2015/11/30/wjax2015-agile-day.html)
