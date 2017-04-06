---
layout: post
title: "JavaLand 2017 - Welcome to Phantasialand"
date: "2017-04-06 15:16:17"
image: blog-header/microxchg-2017.jpg
categories: events
authors: ["Benjamin, Bastian"]
---

The [JavaLand 2017](https://www.javaland.eu/en/javaland-2017/) conference took place for the 4th time in the famous [Phantasialand](http://www.phantasialand.de/en/) holiday park in Brühl, near Cologne.
The program consisted of [talks](https://programm.javaland.eu/2017/schedule.html) on the frist two days and [in-depth workshops](https://www.javaland.eu/de/programm/schulungstag) at the last and third day.

Here are some random facts so that you can imagine the dimension of the largest community conference for Java in Europe:

- 1600 visitors, 14 different locations in the holiday park
- 11 parallel talk tracks, 8 session slots each day
- 8 in-depth workshops which over 8 hours each

<blockquote class="twitter-tweet" data-lang="en"><p lang="und" dir="ltr"><a href="https://twitter.com/hashtag/welcome?src=hash">#welcome</a> to <a href="https://twitter.com/hashtag/JavaLand?src=hash">#JavaLand</a> 💙 <a href="https://t.co/wX37hzFVXM">pic.twitter.com/wX37hzFVXM</a></p>&mdash; JavaLandConf (@JavaLandConf) <a href="https://twitter.com/JavaLandConf/status/846628341209878528">March 28, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

# Talks

We visited several talks and three workshops:

## Reactive Programming

[A Reactive Take on Pokémon GO](https://programm.javaland.eu/2017/talk.html#talk?talkId=529316) by [Riccardo Lippolis](https://www.linkedin.com/in/rlippolis) and [Bas Knopper](https://twitter.com/BWknopper) was all about [Spring Reactive](http://docs.spring.io/spring-framework/docs/5.0.0.M1/spring-framework-reference/html/web-reactive.html). After a quick introduction he showed how to build a reactive program for smartphones.
He extended the observer pattern and added push-based streams, which can be used when it is unknown when data is available.
At its core the [Spring Reactor](fully non-blocking foundation with efficient demand management), a fully non-blocking foundation with efficient demand management, is used.
Another important role plays [Flux](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html) which is similar to the [Java 8 Stream API](https://docs.oracle.com/javase/8/docs/api/java/util/stream/package-summary.html).
A new paradigm in Spring Land will be released in June and is called [Spring Web Flux](https://spring.io/blog/2017/03/15/spring-tips-the-spring-web-flux-reactive-client).
See [this video](https://www.youtube.com/watch?v=leZdgr-O4LE) by [Josh Long](https://twitter.com/starbuxman) for more details.

## Migrating to Java 9

In [this talk](https://programm.javaland.eu/2017/talk.html#talk?talkId=529430) by [Sander Mak](https://twitter.com/sander_mak), who is currently writing a book with [Paul Bakker](https://twitter.com/pbakker) about [Java 9 Modularity](https://twitter.com/javamodularity), explained in this talk the essential steps to prepare for the next Java major release.
Use [jdeps](https://docs.oracle.com/javase/8/docs/technotes/tools/unix/jdeps.html) to get information about missing platform modules.
This tool has some interesting option to inspect JDK internals like and some you should not use like `—add-exports` and `—permit-illegal-access `.
Better change your could instead of using these flags.
If you want to migrate to use modules you can put a plain jair on the module path (automatic modules).
The name is derived from the jar name and export everthing needed as well as reads other downstream modules.
It can access the class path. You should create a module which requires `commons.lang` and a `module-info.jar`.
Dependencies have to be module themselves for easier handling (transitive dependencies).
At runtime services (components) are accessible via reflection.
Don’t open module to everyone.
Export only certain api packages including services!
Revisit open modules when you are done.
Create several modules that are logically seperated, e.g. `API`, `Impl` and `Main`.

# Workshop Day

At the [workshop day](https://www.javaland.eu/de/programm/schulungstag) we visited the Java Web Security session by [Dominik Shadow](https://twitter.com/dschadow) ([Website](https://blog.dominikschadow.de/)) – material can be found [here](https://github.com/dschadow/JavaSecurity) – and the Hibernate 4 session by [Thorben Jansen](https://twitter.com/thjanssen123), who just released a new [Hibernate Tips book](http://www.thoughts-on-java.org/hibernate-tips-book-release-special-launch-price/) about it and run a very popular web portal about Java and Hibernate - [www.thoughts-on-java.org](http://www.thoughts-on-java.org/).
Both sessions were an absolute blast and highlights of the conference itself as both trainers had many years of coding and lecturing experience.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">AWESOME workshop + FULL room  <a href="https://twitter.com/JavaLandConf">@JavaLandConf</a> <a href="https://twitter.com/hashtag/Javaland?src=hash">#Javaland</a>: <a href="https://twitter.com/thjanssen123">@thjanssen123</a> teaches <a href="https://twitter.com/Hibernate">@Hibernate</a> 4 <a href="https://twitter.com/hashtag/JPA?src=hash">#JPA</a> <a href="https://twitter.com/hashtag/ORM?src=hash">#ORM</a> <a href="https://twitter.com/hashtag/lucene?src=hash">#lucene</a> <a href="https://twitter.com/hashtag/bridges?src=hash">#bridges</a> <a href="https://t.co/RrG0LWycGb">pic.twitter.com/RrG0LWycGb</a></p>&mdash; Benjamin Nothdurft (@dataduke) <a href="https://twitter.com/dataduke/status/847394050986594307">March 30, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

# People, Fun and Food

The conference is all about meeting great Java software engineers from other countries as well, including real [Java Champions](https://community.oracle.com/community/java/java-champions) and [JavaOne Rockstars](https://www.oracle.com/javaone/rock-star-wall-of-fame.html), and meeting Java User Groups from Germany (see [iJUG](ijug.eu), the umbrella organisation of many [JUG_DE](https://twitter.com/JUG_DE)) from all around the world.
The team from [NightHacking](http://nighthacking.com) even had a very long live streams from the exhibition room, where famous companies offered support – like the [Eclipse Foundation](https://eclipse.org/org/foundation/) or [JetBrains](https://www.jetbrains.com/), which even came with core developers of the well-known [IDEA](https://www.jetbrains.com/idea/) programming environment for all JVM languages.
It was also great to meet the founder and organizer of the biggest Java User Group on our planet, the [Virtual Java User Group](https://virtualjug.com/) by [Simon Maple](https://twitter.com/sjmaple) and [Oleg Shelajev](https://twitter.com/shelajev) from [ZeroTurnaround](https://zeroturnaround.com/) aka the really helpful [JRebel](https://zeroturnaround.com/software/jrebel) tool company.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/hashtag/JAVA?src=hash">#JAVA</a> champions + <a href="https://twitter.com/hashtag/JCP?src=hash">#JCP</a> leaders <a href="https://twitter.com/JavaLandConf">@JavaLandConf</a> with <a href="https://twitter.com/shelajev">@shelajev</a> <a href="https://twitter.com/dataduke">@dataduke</a><a href="https://twitter.com/miragemiko">@miragemiko</a> <a href="https://twitter.com/sjmaple">@sjmaple</a> <a href="https://twitter.com/nighthacking">@nighthacking</a> <a href="https://twitter.com/hashtag/JavaLand?src=hash">#JavaLand</a> <a href="https://t.co/ISjvJrvYwU">pic.twitter.com/ISjvJrvYwU</a></p>&mdash; Benjamin Nothdurft (@dataduke) <a href="https://twitter.com/dataduke/status/846685232346615813">March 28, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

# Summary

Everything was awesome – from start to finish.
I hope we see you next year there as well.
And don't forget about all the free roller coaster rides without waiting time, the great late night music concert with a terrific live band and the free food at every Restaurant at the marvelous and epic [Phantasialand](http://www.phantasialand.de/en/) near Cologne, Germany.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/hashtag/JavaLand?src=hash">#JavaLand</a> is waiting for you. See you tomorrow! <a href="https://t.co/LwAuO2O4Ir">pic.twitter.com/LwAuO2O4Ir</a></p>&mdash; JavaLandConf (@JavaLandConf) <a href="https://twitter.com/JavaLandConf/status/846271953442877440">March 27, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
