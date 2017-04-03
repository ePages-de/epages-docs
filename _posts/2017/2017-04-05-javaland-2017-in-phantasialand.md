---
layout: post
title: "JavaLand 2017 - Welcome to Phantasialand"
date: "2017-04-05 15:16:17"
image: blog-header/microxchg-2017.jpg
categories: events
authors: ["Benjamin, Bastian"]
---

The [JavaLand 2017](https://www.javaland.eu/en/javaland-2017/) conference took for the 4th in the famous [Phantasialand](http://www.phantasialand.de/en/) holiday park in Brühl, near Cologne. The [program](https://programm.javaland.eu/2017) consisted of two conference days and one final [workshop day](https://www.javaland.eu/de/programm/schulungstag).

We visited several talks and three workshops:

# Spring Web reactive

Pokemon Go
Spring Webflux

## Why reactive programming?

Smartphones —> apps
build better software

## Requirements

System has to be responsive
What to do when something fails
System must be elastic
Must be modular
message based

## How to build a reactive program

Extending the observer pattern
Reaktive stream is push-based
unknown when data will be available
It’s about streams
Reactor (Spring)

## Flux

Picture
Similar to Java 8 Streams

## Spring WebFlux

Spring is adopting reactive paradigm
Release about June

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
