# Living with Microservices - W-JAX 2015 Part II

The concepts to develop a software change regulary. Some changings are nonsense and humbug. They does not help in the developing process and are only a new spacy refreshed concept of a dusted software idea: Give them a buzzword and talk about it, and everyone will use it.

However a few of these new software design concepts are meaningful and solve actual software development problems. One of them is the idea of microservices. The oarticipants of the W-JAX 2015 conference talk about this idea in many sessions.

## When I need microservices

Developing software until now has often the idea of developing a [monolith](https://en.wikipedia.org/wiki/Monolithic_system). In this idea we build a software in one application with one database and (mostly) one programming language. To test the complete software will entail huge tests.

With a few millions of line of codes developing and testing this bug monolith will be a real problem. If the developer will investigate more time in service instead in extending his code he should think about switching to a microservice system. This will also help to avoid using always the same patterns and need a code generator to automatically create static structure.

## The idea of microservices

In basic idea in using microservices is encapsulate every software part in an extra service. Every service can run on their own and use their own de-central database. If one service crashes the whole system can work without failing. It is possible to run more instances of this service to scale it in case of been needed more often.

To structure a monolith in small microservices it is important to find a way to slice the software code in little parts. The following checklist show important remarks to notice slicing it:

- This should be take in a way to avoid big communication. If two components needs to communicate very often both should be in the same microservice.
- Microservices should not influence another microservice.
- Every microservice should can stand alone without knowing other components of the software.
- The complete microservice should be handled by only one team. If the sliced software component can't be serviced by one team alone slice it again.

## Problems and hints

Microservices will put the weight of complexity from algorithm complexity to the communication complexity. The depencies of each part of the software is now moved to way of communication.

A second big problem can be the [Two-Phase Commit](http://www.enterpriseintegrationpatterns.com/ramblings/18_starbucks.html) and data consistency. Lets image we want to transfer money from one to another banking account. The monolith would have a controller layer which sends a request to the model layout. This layer will change the money from one to another account instantly.
In a microservice world every bank account can be in another microservice. Microservice 1 will send the money to microservice 2 and decrease the money in their own database. In this moment the money is not existant: Neither in Microservice 1 nor in microservice 2.

An very important concept is the **Design for Failure**. With different services the input values of every service should be mistrusted. Furthermore should every microservice has a fallback output value if something going wrong.

Another important hint is to monitor the communication over all microservices. That is important to know in which component will be an error why and when. For this an overal identification number of each data element would be helpful. Some tools like [Netflix/eureka](https://github.com/Netflix/eureka) helps to monitor over all microservices.

## Sources and links

- http://www.amazon.de/The-Art-Scalability-Martin-Abbott/dp/0137030428 - The Art of Scalability
- http://www.amazon.de/Building-Microservices-Sam-Newman/dp/1491950358 - Building Microservices
- http://www.amazon.de/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215 - Domain-Driven Design: Tackling Complexity in the Heart of Software
- http://www.amazon.de/Implementing-Domain-Driven-Design-Vaughn-Vernon/dp/0321834577 - Implementing Domain-Driven Design