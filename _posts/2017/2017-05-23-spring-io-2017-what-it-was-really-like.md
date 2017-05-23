---
layout: post
title: "Spring I/O 2017 - What it was really like"
date: "2017-05-23 06:34:02"
image: blog-header/spring-io-header.jpg
categories: events
authors: ["Mathias", "Manel"]
---

<style>

.twitter-tweet {
  margin: auto;
}
</style>

We just came back from beautiful Barcelona where the [Spring I/O](http://2017.springio.net/) took place for the 6th time.
Spring I/O is the leading European conference focused on the [Spring Framework](https://projects.spring.io/spring-framework/) ecosystem.
This year it was all about the upcoming Spring 5 and its support for reactive programming.
This is a huge leap forward for Spring - so we were pretty excited to learn more about it.

Here are some of our highlights from this year's edition in Spring  I/O:

## Database centric applications with Spring Boot and jOOQ

For a long time I had [jOOQ](http://www.jooq.org/) on the list of frameworks I wanted to take a look at.
So it came in handy that [Michael Simons](https://twitter.com/rotnroll666) gave a talk about using it together with Spring Boot.

> jOOQ is short for "Java object oriented querying" and describes a query builder framework that takes a look at your database schema, and provides you with a domain specific language (DSL) for generating statements.

<blockquote class="twitter-tweet" data-lang="de"><p lang="en" dir="ltr">Standing room only for <a href="https://twitter.com/rotnroll666">@rotnroll666</a> talking about <a href="https://twitter.com/springboot">@springboot</a> and <a href="https://twitter.com/JavaOOQ">@JavaOOQ</a> <a href="https://twitter.com/hashtag/springio17?src=hash">#springio17</a> <a href="https://t.co/BFwz0plefW">pic.twitter.com/BFwz0plefW</a></p>&mdash; Andy Wilkinson (@ankinson) <a href="https://twitter.com/ankinson/status/865147016673976320">18. Mai 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Michael nicely showed where he sees room for jOOQ, even when already using Spring Data.
Especially when writing complex queries jOOQ shines through its fluent DSL that allows to build type-safe queries.

The main use cases to apply jOOQ mentioned by Micheal are:

- analytic functions (use the full power of your relational database)
- UPSERT statements
- partial selects (fetching parts of your entity for efficiency)

So next time you put a 10 line native SQL query into a String in your JPA repository, think twice and give jOOQ a try!

<blockquote class="twitter-tweet" data-lang="de"><p lang="en" dir="ltr">Thanks for visiting my database talk. Slides and code are <br>here <a href="https://t.co/Sp4r4QicrR">https://t.co/Sp4r4QicrR</a> and <a href="https://t.co/zToClBYAZR">https://t.co/zToClBYAZR</a> <a href="https://twitter.com/hashtag/springio17?src=hash">#springio17</a></p>&mdash; Michael Simons (@rotnroll666) <a href="https://twitter.com/rotnroll666/status/865162707720429568">18. Mai 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## Reactive Spring

This talk was held on the second day of the conference.
[Josh Long](https://twitter.com/starbuxman) and [Mark Heckler](http://twitter.com/mkheck) gave an introduction to the reactive features in Spring 5 in a live-coding session.
And everybody who ever attended a talk by (in)famous Josh Long knew what was coming.

<blockquote class="twitter-tweet" data-lang="de"><p lang="en" dir="ltr"><a href="https://twitter.com/netzfisch">@netzfisch</a> <a href="https://twitter.com/starbuxman">@starbuxman</a> <a href="https://twitter.com/spring_io">@spring_io</a> Not sure if my brain is already fast enough for <a href="https://twitter.com/starbuxman">@starbuxman</a> so early in the morning. I give it a try. 💯🚀🌅 <a href="https://twitter.com/hashtag/springio17?src=hash">#springio17</a> <a href="https://t.co/Ewdsqq8hdN">pic.twitter.com/Ewdsqq8hdN</a></p>&mdash; Mathias Dpunkt (@zaddo) <a href="https://twitter.com/zaddo/status/865462587168743425">19. Mai 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Their talk gave a very good introduction about how Spring 5 is supporting reactive programming.
It builds on [Project Reactor](https://projectreactor.io/) to support message-driven, elastic, resilient, and responsive services.
They showed how to expose reactive endpoints using the traditional annotated controller approach, but also the new functional way using `RouterFunction` and `HandlerFunction`.
And as expected the talk was highly entertaining.
I was not surprised that it ended up being the top-rated talk of Spring I/O 2017.

<blockquote class="twitter-tweet" data-lang="de"><p lang="en" dir="ltr">Awesome reactive live coding session with <a href="https://twitter.com/starbuxman">@starbuxman</a> and <a href="https://twitter.com/MkHeck">@MkHeck</a> <a href="https://twitter.com/hashtag/springio17?src=hash">#springio17</a> <a href="https://t.co/d7Gh7PBret">pic.twitter.com/d7Gh7PBret</a></p>&mdash; Ingo Griebsch (@d0gb0t666) <a href="https://twitter.com/d0gb0t666/status/865474980624056321">19. Mai 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## Functional web applications with Spring and Kotlin

One of the talks I most enjoyed was "Functional web applications with Spring and Kotlin" by [Sébastien Deleuze](https://twitter.com/sdeleuze).

<blockquote class="twitter-tweet" data-lang="de"><p lang="en" dir="ltr">The slides of my new Functional web applications with <a href="https://twitter.com/hashtag/Spring?src=hash">#Spring</a> and <a href="https://twitter.com/hashtag/Kotlin?src=hash">#Kotlin</a> talk at <a href="https://twitter.com/hashtag/springio17?src=hash">#springio17</a> are available <a href="https://t.co/rJ4narYt4a">https://t.co/rJ4narYt4a</a></p>&mdash; Sébastien Deleuze (@sdeleuze) <a href="https://twitter.com/sdeleuze/status/865526947425640448">19. Mai 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

In the first part of his talk Sébastien gave a short introduction to [Kotlin](https://kotlinlang.org/).
For me many language features looked familiar because of their similarity to [Scala](https://www.scala-lang.org/):

- type inference
- named parameters
- default parameters
- val vs. var
- data classes

Sébastian made a convincing point that Kotlin is worth a try.
It seems to add a lot of useful features in areas where Java is a little weak while keeping the good parts.

<script async class="speakerdeck-embed" data-slide="7" data-id="0f1b6be0670a4ee8a32ab73ec1c9dc8c" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>

Kotlin is especially interesting for me (and maybe for my team in the future) because it seems to become a first class citizen in the Spring ecosystem - at least with Spring 5.
So it is supposed to be quite easy to adopt while still using the full power of [Spring Boot](https://projects.spring.io/spring-boot/) and [Spring Cloud](http://projects.spring.io/spring-cloud/).

<script async class="speakerdeck-embed" data-slide="31" data-id="0f1b6be0670a4ee8a32ab73ec1c9dc8c" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>

Starting to play around with Kotlin as a Spring developer is very easy - just head over to  [start.spring.io](https://start.spring.io/#!language=kotlin) and select Kotlin from the language dropdown.
I exactly did that after the talk and tried to explore Kotlin and the Spring 5 reactive features a bit.
With the knowledge taken from the talk the start was really easy and I got first results running really quickly.

## DDD Strategic Design with Spring Boot

In this talk, [Michael Plöd](https://twitter.com/bitboss) exposed ideas and patterns around _Strategic Design_ (one of the most important concepts behind _Domain Driven Design_) by using a _Spring Boot Application_ as example.

Strategic Design identifies _Bounded Contexts_ and _Context Maps_.
Each bounded context contains models and maybe other (embedded) contexts.
Context maps describe the contact or relationship between models/contexts.

There are context map patterns that can be identified:

- Shared Kernel -two teams share a subset of the domain model-
- Customer / Supplier -customer / supplier relationship between two teams. Downstream team is considered to be the customer-
- Conformist -downstream team conforms to the model of the upstream team-
- Anticorruption Layer -it isolates a client's model from another system's model by translation-
- Separate Ways -no connection between the bounded contexts of a system-
- Open/Host Service -each bounded context expose a set of services to other systems-
- Published language -single agreed language to express models-

Here you can get the [DDD Strategic Design with Spring Boot](https://github.com/mploed/ddd-strategic-design-spring-boot) example shown by the presenter.

## Bootiful Development with Spring Boot and Angular

That was a workshop presented by [Matt Raible](https://www.linkedin.com/in/mraible/), developer advocate at Okta, a company that provides mobility, security and identity IT solutions.

This fast speaker showed us a _beer recommender web service_ mounted as an Angular standalone client app making cross-origin requests to access a Spring Boot backend API (with Spring MVC and Spring Data REST technologies).
Does this frontend/backend split sound familiar to you?

Get the [Bootiful Development with Spring Boot and Angular](http://developer.okta.com/blog/2017/04/26/bootiful-development-with-spring-boot-and-angular) workshop info and start coding.

## It's a wrap

Wrapping up, we can say that we very much enjoyed especially the second day of the conference.
Spring I/O is a good place to go if you are relatively new in the Spring world and look for some orientation in this area.
People experienced with Spring, Spring Boot and also Spring Cloud might come across a lot of already known topics.

And not to forget: Barcelona is a beautiful city that has a lot to offer beyond the content of the conference.
