---
layout: post
title: "JUG Saxony Day 2016"
date: "2016-11-28 12:11:00"
image: blog-header/hamburg-harbor-city.jpg
categories: events
authors: ["Benjamin", "Bastian"]
---
The [13th XP Days Germany](http://www.xpdays.de/2016/) took place again at the Handwerkskammer Hamburg – within a stone's throw of our HQ.
XP Days is a global conference series for developers and by developers with events in France, Great Britain, Scotland, Benelux, Ukraine and even Vietnam.
The integral part is the strong focus on agile software development as well as the values, principles and techniques of [extreme programming](https://en.wikipedia.org/wiki/Extreme_programming).
In this context also several product owners, scrum masters and innovation evangelists had the courage to participate and contribute.

# The schedule

This time the three-day-conference with around 170 participants was even accompanied by a [Devvox4Kids](http://www.devoxx4kids-hamburg.de) event, so that theoretically the whole geek family could join.
[Sunday](http://www.xpdays.de/2016/downloads/community-day/OpenSpaceSonntag.pdf) was assembled in an Open Space format with a session marketplace in the morning and after the lunch break.
The sessions varied from solving coding katas to sharing knowledge and exchanging experiences.
Monday and Tuesday in contrast provided a regular [conference schedule](www.xpdays.de/2016/programm/) with over 32 talks, 8 workshops, 11 lightning talks, 2 keynotes and some flexible slots – [Lean Coffee](http://german.leancoffee.org/) and an additional smaller open space.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Keynote-Feeling bei den XP Days <a href="https://twitter.com/hashtag/developer?src=hash">#developer</a> <a href="https://twitter.com/hashtag/agile?src=hash">#agile</a> <a href="https://twitter.com/hashtag/programming?src=hash">#programming</a> <a href="https://twitter.com/hashtag/conference?src=hash">#conference</a> <a href="https://twitter.com/hashtag/xdde16?src=hash">#xdde16</a> <a href="https://twitter.com/xd_de">@xd_de</a> <a href="https://t.co/wt0L6pnJyC">pic.twitter.com/wt0L6pnJyC</a></p>&mdash; Benjamin Nothdurft (@dataduke) <a href="https://twitter.com/dataduke/status/800710674884141056">November 21, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


# Our talk and workshop

After a short pitch in the opening talk we could gather around 30 interested conference visitor to join our session: "Welcome to Dockerland: Best Practises for Kickstarters and Tools by Example" (http://www.xpdays.de/2016/sessions/116-welcome-to-dockerland-best-practices-for-kickstarters-tools-by-example).
Here we explained the various parts of the Docker platform and showed best practices for writing Dockerfiles.
Briefly we could also introduce some examples with Spring Boot, Logstash, CircleCI, branching strategies and multi-container apps with Docker Compose and node.js.
For a more practical approach we invited all participants to join our hands-on workshop in the afternoon which offered 5 different tutorials for all skill levels(http://training.docker.com/category/self-paced-online).
Here we reused the materials of the Global Docker Mentor Week(https://blog.docker.com/2016/10/docker-global-mentor-week-2016/) where we also served as tutor at an event at Xing(https://www.meetup.com/Docker-Hamburg/events/234772983/) a week before.
We got some very positive feedback for our beautiful [slides](https://speakerdeck.com/dataduke/welcome-to-dockerland-xdde16).

<script async class="speakerdeck-embed" data-id="7aacbd41660c4f86b2e1b5fff3b5afac" data-ratio="1.37081659973226" src="//speakerdeck.com/assets/embed.js"></script>

# Other sessions

The talk "[10 golden rules for bad tests](http://www.xpdays.de/2016/sessions/102-die-10-goldenen-regeln-fuer-schlechte-tests.html)" took an inverted approach on the criteria for well-written tests.
During their session Tilman Glaser presented the anti-pattern [hypothesis](http://www.xpdays.de/2016/downloads/102-die-10-goldenen-regeln-fuer-schlechte-tests/10_goldene_Regeln_mit_codelinks_xpdays2016.pdf) and Peter Fichtner implemented in alternation the according changes into an artificial postage charge [code base](https://github.com/fiduciagad/die10goldenenRegelnFuerSchlechteTests).
As the connection between real-life experiences of the spectators and the outlined sarcasm aligned quite perfectly the fun-factor and laughter of this session rose dramatically.

In the session ["How can a sustainable software architecture in agile projects be established?"](http://www.xpdays.de/2016/sessions/113-auf-agilen-pfaden-wie-entsteht-eine-nachhaltige-architektur-in-agilen-projekten.html) we learned from empirical examples how an architecture could be grown without having the big blueprint planning of a system upfront.
One basic idea was to see a system as a tree with leaves, branches and a trunk, which is in iteration with external influences like the wind, the sun, it's own weight and the terra and exists during night and night, the seasons, rain and dry periods with the possibilities to get damaged or the ability to heal.
In this setting your system will live as long as it delivers incrementally customer value.
The architecture parts that get used more often should be carried out to a higher degree of code quality, stability and scaleability.
The development team as total is responsible for developing the system architecture according to these standards also the degree of involvement of each member is different (collective code ownership).
Agile architecture is defined by it's code which is confirmed when it works or could get trashed when it breaks along the lifetime of the system.
Metrics should be established for an external business view (KPIs, user feedback) as well as internal technical view (class/method sizes, test coverage, dependencies, cycles ...).

[David Völkel](https://twitter.com/davidvoelkel) explained in his session "[Wann soll ich mocken?](http://www.xpdays.de/2016/sessions/055-wann-soll-ich-mocken.html)"" when he thinks mocking is useful and at which point you should avoid mocks.
First of all he shortly mentioned the two extreme forms of testers: 1. Mockist 2. Classicists.
Mockists try to mock as much as possible, while Classicists try to avoid mocks as often as possible.
The truth lies somewhere in the middle.
But where?
First of all you should never mock any values.
Instead make use of TestDataBuilders to create this information.
In general there are two possible scenarios for your code.
In the first one you are able to separate the logic from the integration parts (e.g. database interaction).
In this case your can create a method containing the logic, which then can be unit tested without any mocks.
The integration part then can be tested with an integration test.
The second scenario is called conditional interaction.
This means that you are not able to separate the logic from the integration parts.
Here the developer has to balance pros and cons whether mocking is not taking away any important implementation that should be tested.
At the borders of your system mocking is indispensable, which means external services that are used have to be mocked.

# Feedback

Overall this was a worthwhile event that is beneficial for every programmer. In 2017 the conference will take place in Stuttgart from 5th to 7th October.
