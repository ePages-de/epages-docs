---
layout: post
title: "Gradle Workshop"
date: "2017-12-07 22:35:13"
image: blog-header/workshop.jpg
image-position: bottom
categories: agile
authors: ["Thomas"]
---

## Introduction

Recently I conducted my fourth Gradle workshop, and for the first time at ePages.<br>
It was very well received, so I decided to share it on this blog.

Before going into details about Gradle and the event itself, I would like to lose
a couple of words about the motivation behind it.

I would also like to give credits to [Peter Niederwieser](https://at.linkedin.com/in/pniederw/de)
(then Gradleware), as the content of the workshop was based on his work initially.

You can find the content of the workshop, including the slides, [on GitHub](https://github.com/thokari/gradle-workshop).


## Structure of the workshop

This was the agenda of the workshop.

- Motivation
- Evolution of build tools
- Language basics
- Gradle concepts
- Building Java projects
- Gradle and IDEs

I started the workshop with a short introduction and explanation of the motivation to
create and use a tool like Gradle, as well as my own personal motivation to work
with, and teach others about it.

Many ideas in Gradle are easier to explain and understand when put in the context
of the history of build tools. This is especially true, if someone migrated from
[Make](https://www.gnu.org/software/make/) directly to Gradle, for example, and was
wondering [why no one was using make for Java](https://stackoverflow.com/questions/2209827/why-is-no-one-using-make-for-java).

Gradle is primarily used to build Java projects.
However, I find it important to cover fundamentals of the tool first, before looking
at the Java-specific things.<br>
Gradle makes extensive use of a [Groovy](http://groovy-lang.org/) DSL (domain specific
language), so it makes sense to cover the basics of that language.<br>
Below that, Gradle offers a rich model for the domain of building software projects.

When Gradle is used in Java projects I find it very helpful to start with simple
examples. I prefer to look at everything as files on the file system, instead of
whatever view your IDE has to offer. These are related of course, but different
(I am looking at you, Eclipse workspace).<br>
A big part of what Gradle tries to achieve is a unified view of the project, that
is independent from any IDE-specific configuration or presentation.

This is why I only touch on IDEs in the end, and create the examples and exercises
in a way they do not require any IDE to work with them.


## Personal motivation

When I was learning about [Gradle](https://gradle.org/) 6 years ago, I found the
tool quite compelling. Having used [Apache Ant](http://ant.apache.org/) before and
getting increasingly annoyed by it, Gradle promised exactly what I was looking for -
a way to refactor and reorganize build logic, by being able to make sense of it.

Back then, many of my colleagues seemed to be reluctant to use Gradle, or did not
buy into the philosophy behind it.
For example, I remember someone being specifically proud of using the same Ant `build.xml`
since ten years.

At the same time I was fortunate to get the opportunity to participate in a workshop
by Gradleware, which I found very inspiring. The combination of these things gave
me the idea to condense and adapt the content of this workshop.

When I joined ePages, Gradle was used quite extensively here already. There are
several Gradle multi-projects in our current system (e.g. REST API, GUI testing
framework) and in our new [product line](https://signup.beyondshop.cloud/).

A recent internal reorganization was a good occasion to revise and update the content
of the workshop, and present it again to interested colleagues.


## Why (not) Gradle?

Here is a [good article by Benjamin Muschko](http://www.drdobbs.com/jvm/why-build-your-java-projects-with-gradle/240168608)
that explains the evolution of Java build tools.<br>
The comments, especially the first one by "phansson", are also worth reading, because
instead of discussing pros and cons one feature or another, they address a more
fundamental question: Is it really worth it?

Gradle is probably not what you would consider a lightweight tool. The user guide
has 700 pages and the API documentation contains about 1100 classes.<br>
It is definitely intimidating, which means that the intention to use it should be
well justified. Especially in today's working environments, where the price of accidental
complexity is already very high, and in the face of [alternatives](https://maven.apache.org/guides/index.html),
which are arguably simpler and easier to get started with.

I have seen quite a few Gradle projects so far, in various companies of different
sizes.<br>
Except for a couple insignificant ones, mostly all of them were [multi-projects](https://docs.gradle.org/current/userguide/multi_project_builds.html).
According to the documentation, "this topic is also the most intellectually challenging".<br>
I find this hint very peculiar, and I consider it a warning.

One project I had worked with consisted of about 60 (Java-)subprojects.<br>
It did have this problem when you imported the project(s) into Eclipse (after running
`./gradlew eclipse`), it would go into an apparently endless loop of opening projects.<br>
There was no problem with the build according to Gradle, but Eclipse somehow
didn't like the structure. The workaround was to cancel the import operation, and
trigger a "Clean" operation in Eclipse.
Considering this needed to happen quite often (basically every time a developer
changed their branch), this was quickly getting annoying.<br>

Another problem was with the database configuration. There existed a configuration
file, but *it was not used during (integration-) testing*. Instead, a subproject
called `datasource-test` was created, which was pulled in by another subproject
specifying a `testRuntime` dependency on it.<br>
(The subprojects did have a tree-structure, but were located on the same directory
level...)<br>
The `datasource-test` project then used dependency injection to bind the database
configuration to a class, that had *hardcoded* values in it.<br>
Basically, there was a bunch of highly convoluted Gradle and Guice code, that
did nothing else besides *reimplementing something that was already configurable*.<br>

When I see problems and workarounds like that it makes me wonder, what is here the
benefit of using Gradle? Doesn't it just give people more rope to hang themselves?<br>
Compared to a Maven `pom.xml`, which contains XML that is either valid or invalid,
in Gradle there are arbitrarily many ways to screw things up.

What I find really interesting in this context, is the [self-description of Maven](https://maven.apache.org/).
> Apache Maven is a software project management and comprehension tool.

It seems to me like a very clever attempt by Maven to turn the tables on its competitor
(which, by the way, in turn changed its own description from "Enterprise Automation Tool"
to "Build Tool").<br>
This leads right to the point: Understanding, i.e. making sense of the structure
of a project, is by far the most important and sensible issue, that these tools address.<br>
But if they are not used *judiciously*, it is very easy to achieve the exact opposite.<br>
And if a project has too many quirks and is unnecessarily complicated, this ultimately
impacts developer satisfaction and scalability of development.<br>


## About learning and teaching

Doing this workshop presented a great learning opportunity for myself, as my [most
favorite blogger](https://blog.codinghorror.com/the-best-code-is-no-code-at-all/),
Jeff Atwood, [points out](http://startupquote.com/post/2163563107).<br>
I needed solid knowledge about the tool, because I wanted to be able to answer questions,
and solve problems in idiomatic ways.<br>
I got new ideas and insights by explaining things multiple times and from different
angles.

I like practical examples. The ones in the workshop repository are not taken
from production code, however. But I do like to relate to production code during the
workshop, like the examples mentioned above.<br>

The title "workshop" implies it is interactive, i.e. there are [exercises](https://github.com/thokari/gradle-workshop/tree/master/sessions)
to be solved individually or in small groups.<br>
It is more fun and engaging, and promotes learning better than a lecture kind of presentation.

Last but not least, I feel it is really important to have these kind of activities,
integrated into the work schedule, i.e. during normal office hours.<br>
In order to create a culture of continuous learning in the enterprise, it is crucial
to foster a blame free environment, where taking one's time to get deeper understanding
is not perceived as a weakness.<br>
Questioning should be encouraged, concerning specific problems, as well as general
[why-are-we-doing-this-at-all type of questions](http://amorebeautifulquestion.com/).


## Conclusions

There were a couple of things that I found especially positive about this event.

The group of participants was heterogeneous, consisting of people using different
languages and technology stacks.<br>
While one or the other might not be using Gradle in their own projects, they gained
insights how it relates to tools from their own ecosystems, e.g. `gem` and `rake`
for Ruby, [npm](https://www.npmjs.com/), [Grunt](https://gruntjs.com/) or [Gulp](https://gulpjs.com/)
for NodeJS, etc.<br>

There hardly are any "true" multi-language projects in companies, in the sense that
the same developers write code in different parts of the system in different languages.
On the other hand, any serious web application typically contains at least a few
different languages.

After explaining about multi-projects in Gradle, one participant correctly concluded,
that "the whole ePages could be built with Gradle".<br>
While this would probably be too good to be true, the way of thinking (i.e. integrating
heterogeneous projects) is more in line with the concept of multi-projects in Gradle,
in my opinion.<br>
Rather than the before mentioned approach of starting a single-language greenfield
project as a multi-project for dubious reasons.<br>
To conclude with a statement from another participant, "with more power comes more
responsibility".
