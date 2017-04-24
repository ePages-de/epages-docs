---
layout: post
title: "microXchg 2017 - The Microservices Conference"
date: "2017-03-28 12:02:22"
image: blog-header/microxchg-2017.jpg
categories: events
authors: ["Benjamin"]
---

In mid February the [microXchg conference](http://microxchg.io) ([Twitter](https://twitter.com/microXchg)) took place in Berlin.
It is the biggest two-day event in Europe that focuses on [Microservices](https://martinfowler.com/articles/microservices.html)
– an architectural design of software systems that has generated a lot of traction within the last years.
Microservices are not only capable of transforming old architectures but also aligning teams properly to the distribution of software artifacts by establishing distinct bounded contexts.

## Pre-Event Panel one evening before

One day before the main conference a [conference panel](https://www.meetup.com/Microservices-Meetup-Berlin/events/237309001) event was held with plenum discussions, organized by the [Microservices Meetup Berlin](https://www.meetup.com/Microservices-Meetup-Berlin).
Some of the greatest influencers in Microservices were invited: [Uwe Friedrichsen](http://twitter.com/ufried), [Oliver Gierke](http://twitter.com/olivergierke), [Eberhard Wolff](http://twitter.com/ewolff) and [Fred George](http://twitter.com/fgeorge52).
Although I did not really learn something totally new, I picked up quite a lot of interesting details.
Especially Fred's stories about his life and about his really big software projects were worth every second I could spend sitting in the first row.
I also had the opportunity to ask questions and chat with participants.

## Workshop day

I visited the workshop "Building microservices with Scala and Akka" by [Yaroslav Tkachenko](http://sap1ens.com).
Yaroslav is a highly-skilled professional with a very long background in Scala.
His great workshop could have easily covered two more days.
The presentation material lasted until the very last second of the workshop.
Perfectly on time.
After the workshop I had an interesting discussion about the tech communities in Canada.
Yaroslav also wrote [a blog post](http://sap1ens.com/blog/2017/02/26/microxchg-2017) about his observations of the conference.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Last talk for the day:<a href="https://twitter.com/fgeorge52">@fgeorge52</a> about IoT and <a href="https://twitter.com/hashtag/Microservices?src=hash">#Microservices</a> in the Home <a href="https://t.co/JpZYuXrFnf">pic.twitter.com/JpZYuXrFnf</a></p>&mdash; microXchg (@microXchg) <a href="https://twitter.com/microXchg/status/832281234520809472">February 16, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## Visited talks

I visited a lot of interesting sessions with a wide variety of topics.
All talks were recorded with cameras and microphones.
30 minutes after a talk, the movie crew uploaded the recordings to the familiar services:

* [microXchg YouTube Channel](https://www.youtube.com/channel/UCGCbB8TPtYMQmJwYVogcPjg)
* [InfoQ](https://www.infoq.com/microxchg)(one of the best platforms for tech talks on the internet as slides and speaker recordings are presented in two windows)

## Talks on Thursday

**Morning:**

* Resilient functional software design (Uwe Friedrichsen)
* Shrinking Microservices to functions (Adrian Cockcroft) - [Summary of the talk](https://www.infoq.com/news/2017/02/microxchg-microservice-functions)
* DDD & REST - Domain-Driven APIs for the web (Oliver Gierke)
* Serverless - Power to the Black Box! (Michael Bruns)

**Afternoon:**

* AaaS – Anything as a Service. Anything left to do, then? (Dustin Huptas)
* Architecture Pattern for Microservices in Kubernetes (Dr. Thomas Fricke)
* Microservices: The Organizational and People Impact (Daniel Bryant)
* IoT and MicroServices in the Home (Fred George)

[Here](https://www.infoq.com/news/2017/02/microxchg-day-one) you can find a summary of day one.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">FULL ROOM at Secure Microservices Adoption by <a href="https://twitter.com/ggonchar">@ggonchar</a> <a href="https://twitter.com/Kreditech">@Kreditech</a> <a href="https://twitter.com/microXchg">@microXchg</a> <a href="https://twitter.com/hashtag/microXchg?src=hash">#microXchg</a> <a href="https://twitter.com/hashtag/eCommerce?src=hash">#eCommerce</a> <a href="https://t.co/eFQOAYd2AP">pic.twitter.com/eFQOAYd2AP</a></p>&mdash; Benjamin Nothdurft (@dataduke) <a href="https://twitter.com/dataduke/status/832520703979159552">February 17, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## Talks on Friday

**Morning:**

* Authorization and Authentication on Microservice Environments (Bernd Schönbach was ill, so his colleague Dr. Niklas Henrich took over)
* Secure Microservices Adoption (Grygoriy Gonchar)
* Beyond OAuth2: End to End Microservice Security (Will Tran)

**Afternoon:**

* How to properly blame things for causing latency: An intodurction to distributed tracing and Zipkin (Adrian Cole)
* Microservices, Conway's Law and the Innovator's Dilemma (Andrea Stubbe)
* How to monitor Microservices with dtrace and sysdig (Jorge Salamero)

## Insights into "Beyond OAuth2: End to End Microservice Security"

As you can watch all recordings online I will only give a summary of one single talk that impressed me the most.

The [talk](https://www.youtube.com/watch?v=G7A6ftCbVQY) of [Will Tran](http://twitter.com/fivetenwill) from Pivotal was all about getting Microservices secure.
His idea is to use nested, single use JWT tokens instead of having "one token rule them all".
The project uses [JOSE](http://connect2id.com/products/nimbus-jose-jwt) and trusted service registries.

If you are interested in this new endeavor explore the [source code](https://github.com/william-tran/microxchg2017) and [slides](https://docs.google.com/presentation/d/1gmMlvBW8JNGGo0rY_CnMt6qRYGCGVfQCvevkxVYhXWs/edit#slide=id.g20cc451819_0_3322).

Will has in the meantime left Pivotal to work at [autonomic.ai](http://autonomic.ai/) with other former Pivotal employees.
Still he plans to gather more feedback and interest at [IIW24 - Internet Identity Workshop](http://www.internetidentityworkshop.com/) in the hope that others can contribute to the implementation.
This would allow further development so that maybe in the future the project might get more support by Pivotal.

## Wrap-up

* Incredible speaker lineup and absolutely stunning talks.
* Amazing atmosphere and throughout every single moment it was filled with so much energy.
* Absolutely the best conference I've ever visited.
* The orga team was a blast and I was honored to being part of the extended crew.

I'm really happy that I could help making this conference a great experience and to also interview some of the top speakers.
Thanks for such terrific days in Berlin, the delicious catering and the vitalizing discussions.

## Credits

Special thanks goes to [Oliver Gierke](http://twitter.com/olivergierke), who took nearly an hour of his time and invested it into talking with me in the lounge area about [Pivotal](https://pivotal.io) internals and [Spring Data Rest](http://projects.spring.io/spring-data-rest) and [Spring Data Elasticsearch](https://projects.spring.io/spring-data-elasticsearch).
This was very helpful and improved my knowledge besides all talks I have already seen from him at several conferences.
