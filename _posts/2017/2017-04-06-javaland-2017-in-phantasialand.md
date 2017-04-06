---
layout: post
title: "JavaLand 2017 - Welcome to Phantasialand"
date: "2017-04-06 15:16:17"
image: blog-header/microxchg-2017.jpg
categories: events
authors: ["Benjamin, Bastian"]
---

The [JavaLand 2017](https://www.javaland.eu/en/javaland-2017/) conference took place for the 4th time in the famous [Phantasialand](http://www.phantasialand.de/en/) holiday park in Brühl, near Cologne. The program consisted of [talks](https://programm.javaland.eu/2017/schedule.html) on the frist two days and [in-depth workshops](https://www.javaland.eu/de/programm/schulungstag) at the last and third day.

Here are some random facts so that you can imagine the dimension of the largest community conference for Java in Europe:

- 1600 visitors, 14 different locations in the holiday park
- 11 parallel talk tracks, 8 session slots each day
- 8 in-depth workshops which over 8 hours each

# Talks

We visited several talks and three workshops:

### Reactive Programming

[A Reactive Take on Pokémon GO](https://programm.javaland.eu/2017/talk.html#talk?talkId=529316) by [Riccardo Lippolis](https://www.linkedin.com/in/rlippolis)
was all about [Spring Reactive](http://docs.spring.io/spring-framework/docs/5.0.0.M1/spring-framework-reference/html/web-reactive.html). After a quick introduction he showed how to build a reactive program for smartphones. He extended the observer pattern and added push-based streams, which can be used when it is unknown when data is availible. At its core the [Spring Reactor](fully non-blocking foundation with efficient demand management), a fully non-blocking foundation with efficient demand management, is used. Another important role plays [Flux](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html) which is similar to the [Java 8 Stream API](https://docs.oracle.com/javase/8/docs/api/java/util/stream/package-summary.html). A new paradigm in Spring Land will be released in June and is called [Spring Web Flux](https://spring.io/blog/2017/03/15/spring-tips-the-spring-web-flux-reactive-client). See [this video](https://www.youtube.com/watch?v=leZdgr-O4LE) by [Josh Long](https://twitter.com/starbuxman) for more details.

----

# Migrating to Java 9

Cannot expose same Module Names as in JDK
Spring Application example
Exception with Java 9


## Missing Platform Modules

Use jdeps to get this information
Add —add-modules … to javac

## Using encapsulated APIs

Use jdeps to get this information (-jdkinternals)
Cannot compile with java 8 and run with java 9
—add-exports … (Would not do that, not intended to do that)
—permit-illegal-access (even worse)
Try to change your code rather than add flags to javac

## Migrating to Modules

plain jar can be put on the module path (automatic modules)
name is derived from jar name
exports everything
reads all other modules
can access class path
create module which requires commons.lang
module-info.jar
dependencies have to be module themselves for easier handling (transitive dependencies)
turn module to open module
at runtime Services (Components) are accessible via reflection
don’t open module to everyone
Spring can access
open module book app {..}
or: export only certain api packages including services

## Tips

requires only for direct dependencies
Revisit open modules

## Create several modules

Logically seperated
Api, Impls, Main, ...

----

# GraphQL als alternative zu REST

Lösung für ein paar Nachteile von REST
Rethink Best-Practices
Netzwerk Performance
Fehlende Typisierung
Problem der Versionierung

## Was ist GraphQL

Abfragesprache für Web-APIs
OpenSource
Ein Endpunkt
POST oder GET
Trennung Query und Mutation —> CQRS
Query Optimierung und Caching
Caching

## Wie sieht der Server aus?

Für jedes Feld existieren Resolver Funktionen
graphql-jpa (nicht production-ready)
generiert GraphQL-Schema

## Aktueller Stand

GraphQL-Spec
Mehrere PAAS-Anbieter
Ein paar Firmen migrieren (Github)
Kein Riesen Hype —> Nische
Für Java noch mit kaum Aufmerksamkeit
Wrapper für REST


----

# RxJava



---

Workshops:

# Hibernate





---


# Summary
