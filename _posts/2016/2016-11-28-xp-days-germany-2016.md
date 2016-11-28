---
layout: post
title: "XP Days Germany 2016"
date: "2016-11-28 12:11:00"
image: blog-header/hamburg-docks.jpg
categories: events
authors: ["Benjamin", "Bastian"]
---
<style>
.twitter-tweet {
  margin: auto;
}
</style>

The [13th XP Days Germany](http://www.xpdays.de/2016/) took again place at the [Handwerkskammer Hamburg](https://www.hwk-hamburg.de) – within a stone's throw of [ePages HQ](http://www.epages.com).
XP Day(s) are a global conference series for developers and by developers with events in France, England, Scotland, Benelux Union, Ukraine and even Vietnam.
The integral part is the strong focus on agile software development as well as the values, principles and techniques of [eXtreme Programming](https://en.wikipedia.org/wiki/Extreme_programming).
In this context, several product owners, scrum masters and innovation evangelists had the courage to participate and contribute, too.

# The schedule

This time, the three-day-conference with around 170 participants was even accompanied by a [Devoxx4Kids](http://www.devoxx4kids-hamburg.de) event, so that theoretically the whole geek family could join.
[Sunday](http://www.xpdays.de/2016/downloads/community-day/OpenSpaceSonntag.pdf) was assembled in an open space format with a session marketplace in the morning and after the lunch break.
The sessions varied from solving coding katas to sharing knowledge and exchanging experiences.
In contrast, Monday and Tuesday provided a regular [conference schedule](http://www.xpdays.de/2016/programm/) with over 32 talks, 8 workshops, 11 lightning talks, 2 keynotes and some flexible slots – [Lean Coffee](http://german.leancoffee.org/) and an additional smaller open space.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Keynote-Feeling bei den XP Days <a href="https://twitter.com/hashtag/developer?src=hash">#developer</a> <a href="https://twitter.com/hashtag/agile?src=hash">#agile</a> <a href="https://twitter.com/hashtag/programming?src=hash">#programming</a> <a href="https://twitter.com/hashtag/conference?src=hash">#conference</a> <a href="https://twitter.com/hashtag/xdde16?src=hash">#xdde16</a> <a href="https://twitter.com/xd_de">@xd_de</a> <a href="https://t.co/wt0L6pnJyC">pic.twitter.com/wt0L6pnJyC</a></p>&mdash; Benjamin Nothdurft (@dataduke) <a href="https://twitter.com/dataduke/status/800710674884141056">November 21, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

# Our Docker talk and workshop

After a short pitch in the opening talk, we could gather more than 30 interested conference visitors to join our session: "[Welcome to Dockerland: Best Practises for Kickstarters and Tools by Example](http://www.xpdays.de/2016/sessions/116-welcome-to-dockerland-best-practices-for-kickstarters-tools-by-example.html)".
Here, we explained the various parts of the Docker platform and showed best practices for writing Dockerfiles.
Also, we could briefly introduce some examples with [Spring Boot](https://spring.io/guides/gs/spring-boot-docker/) and Gradle, Node.js and MongoDB, Logstash and Elasticsearch, Docker image tag strategies with build servers as well as multi-container apps with Docker Compose.
At the end, we got some very positive feedback for our [pictographic slides](https://speakerdeck.com/dataduke/welcome-to-dockerland-xdde16).

<script async class="speakerdeck-embed" data-id="7aacbd41660c4f86b2e1b5fff3b5afac" data-ratio="1.37081659973226" src="//speakerdeck.com/assets/embed.js"></script>

For a more practical approach, we invited all participants to join our hands-on workshop in the afternoon, which offered [5 different tutorials](http://training.docker.com/category/docker-mentor-week) for all skill levels.
Here, we reused the materials of the [Docker Mentor Week](https://blog.docker.com/2016/10/docker-global-mentor-week-2016/) - a global event series that also took place in [Hamburg at Xing](https://www.meetup.com/Docker-Hamburg/events/234772983/) a week before, where we also tutored to help others to [#learndocker](https://twitter.com/search?vertical=default&q=%23learndocker).

# Other talks

**[10 golden rules for bad tests](http://www.xpdays.de/2016/sessions/102-die-10-goldenen-regeln-fuer-schlechte-tests.html)**

This talk took an inverted approach on the criteria for well-written tests.
During their session, Tilman Glaser presented [10 common anti-patterns](http://www.xpdays.de/2016/downloads/102-die-10-goldenen-regeln-fuer-schlechte-tests/10_goldene_Regeln_mit_codelinks_xpdays2016.pdf) and in return [Peter Fichtner](https://twitter.com/petfic) implemented the according changes into an artificial postage charge [code base](https://github.com/fiduciagad/die10goldenenRegelnFuerSchlechteTests) for each hypothesis.
As the connection between real-life experiences of the spectators and the outlined sarcasm aligned quite perfectly the fun-factor and laughter of this session rose dramatically.

**[How can a sustainable software architecture in agile projects be established?](http://www.xpdays.de/2016/sessions/113-auf-agilen-pfaden-wie-entsteht-eine-nachhaltige-architektur-in-agilen-projekten.html)**

In this session by [Uwe Kranz](https://twitter.com/uwe_kranz) and Christian Bader we learned from empirical examples how an architecture could be grown without having the big blueprint planning of a system upfront.
One basic idea was to imagine and examine a software system as a tree with leaves, branches and a trunk, which is in iterative interaction with external influences like the wind, the sun, it's own weight and the ingrained ground.
It exists during night and day, the yearly seasons, rain and dry periods with the possibilities to get damaged or the ability to heal.

In this setting your system will live as long as it can survive the interfering forces besides delivering incremental customer value.
Therefore, the architecture parts that get used more often should be carried out to a higher degree of code quality, stability and scaleability.
The development team as a whole is responsible for developing such a system architecture over time – although the degree of involvement of each member may differ due to unequal skill sets (collective code ownership).
Agile architecture is defined by its living code components, which are confirmed when they work out or need to be killed/trashed when they break.
For further assistance metrics should be established so that an external business view (KPIs, user feedback) and an internal technical view (class/method sizes, test coverage, dependencies, cycles ...) can be made rationally tangible and objectively assessable.

**[When should I use mocks?](http://www.xpdays.de/2016/sessions/055-wann-soll-ich-mocken.html)**

[David Völkel](https://twitter.com/davidvoelkel) explained in his session when he thinks mocking is useful and at which point you should avoid mocks.
First of all, he shortly mentioned the two extreme forms of testers: Mockists and Classicists.
Mockists try to mock as much as possible, while Classicists try to avoid mocks as often as possible.
The truth lies somewhere in the middle.
But where?
First of all, you should never mock any values.
Instead, make use of TestDataBuilders to create this information.
In general, there are two possible scenarios for your code.
In the first one you are able to separate the logic from the integration parts (e.g. database interaction).
In this case you can create a method containing the logic, which then can be unit tested without any mocks.
The interplay then can be tested with an integration test.
The second scenario is called conditional interaction.
This means that you are not able to separate the logic from the integration parts.
Here, the developer has to balance pros and cons whether mocking is not taking away any important implementation that should be tested.
At the borders of your system mocking is indispensable, which means external services that are used have to be mocked.

# Other workshops

**[Impact Mapping](http://www.xpdays.de/2016/sessions/061-impact-mapping-workshop.html)**

[Patrick Baumgartner](https://twitter.com/patbaumgartner) and [Peter Gfader](https://twitter.com/peitor) showed how important it is to take a step backward from your project to gain a deeper view.
In general, an [impact mapping](https://www.impactmapping.org/index.html) workshop is done with all project stakeholders.
It should deliver a common understanding of the problem that needs to be solved as well as clarify the impact that one (team/company) tries to achieve.
By iterative answering of the most crucial business questions (why? who? how? what?) a non-technical perspective with a wide-spread solution horizon can be established.
In this workshop small groups tried to answer these questions for an artificial business scenario, e.g. an advertisement company for sports events.
With the given method and helpful hints by the instructors our team could figure out a vast palette of solutions to our problem space of which some could also avoid developing expensive software at all.
In the end every participant was amazed about how many solution facets could be illuminated by this flexible and effective technique.

**[Hacking Night](https://github.com/jlink/maexchen)**

On monday night, a two-hour coding contest took place.
Small teams needed to write a [Mia game bot](https://github.com/jlink/maexchen), which interacted with the table server.
Within four rounds the bots needed to compete against each other. It was a lot of fun and in the end our team bot could achieve the highest overall performance.

# One more thing

These days graphic recording of sessions is a major trend.
Hence, there were not only 2 sessions for learning this skill yourself but also live sketching was done for of all sessions within the big hall by a professional artist – [Benjamin Felis](https://twitter.com/benjaminfelis).

<blockquote class="twitter-tweet" data-lang="en"><p lang="de" dir="ltr">Das graphic recording war eine tolle Idee! Sehr wertschätzend für die Moderatoren! Danke <a href="https://twitter.com/hashtag/xdde16?src=hash">#xdde16</a> <a href="https://t.co/WZOZzO5AFh">pic.twitter.com/WZOZzO5AFh</a></p>&mdash; Andy Fischer (@Fischermaen) <a href="https://twitter.com/Fischermaen/status/801088541094715393">November 22, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

# Our feedback

This year, the keynote with Holger Stanislawski was really impressive and delivered an unconventional perception on managing highly valuable teams.
To top it all off, [Nat Pryce](https://twitter.com/natpryce) – an academic researcher at the [Imperial College London](http://www.doc.ic.ac.uk/~np2/) and co-founder of the XP Day in London – outlined vividly the [historical journey of TDD](http://www.xpdays.de/2016/downloads/keynote-di/Wisdom_of_the_Ancients__2_.pdf) from Lehman's laws in the 1980s until the three fundamental aspects for software systems in TDD:

1. Consider the system type.
2. Nurture your feedback cycles.
3. Accept uncertainty.

To learn more we can highly recommend his book ["Growing Object-Oriented software guided by tests"](https://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627), co-authored with [Steve Freeman](https://twitter.com/sf105).
Overall, this was a worthwhile event with intriguing moments that can be very beneficial not only for the average programmer but for all IT stakeholders.
In 2017 the conference will take place in Stuttgart from 5th to 7th October.
