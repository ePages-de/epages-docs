---
layout: post
title: "devoxx Belgium 2017 - Day 1"
date: "2017-11-09 00:00:00
image: blog-header/devoxx-be-2017.jpg
categories: events 
authors: ["Dirk"]
---

Being at the devoxx for the first time, but having heard so much praise already, and seeing all those high-profile 
speakers on the schedule, I was really eager to get to Antwerp for this year's devoxx.
And I'm also eager to share my personal impressions :-)

One really cool thing about devoxx is that they stream all of the talks live at their 
[Youtube channel](https://www.youtube.com/channel/UCCBVCTuk6uJrN3iFV_3vurg), and put the recordings online pretty soon 
(should be online the next day).
So if you find a topic interesting, tune in.

So, here's my personal schedule and summary for the first of the conference part.

## Keynote: Moving Java Forward Faster

In this first keynote, [Mark Reinhold](https://twitter.com/mreinhold), Chief Architect of the Java Platform Group, 
presented an outlook to the future release process of Java. 
We're going to get new releases every 6 month, with LTS releases every three years (and being supported that long).
On top of this, he and [Brian Goetz](https://twitter.com/BrianGoetz) also let us peek into future of Java, with
highly appreciated features like pattern matching.

If you have followed the Java news, you might know most of the stuff already, but still I would highly recommend this
talk.

## Keynote: CERN, from an IT Perspective

Being completely off-topic from a developer perspective, Derek Mathieson gave insights to the famous CERN.
Very  informative and entertaining, growing the desire to see it for myself.
Which will be possible in 2019 at the OpenCERN event and VoxxedDays.

## Keynote: Move Slow and Mend Things

My favorite takeaway from the talk of [Kevlin Henney](https://twitter.com/KevlinHenney) is "speed != velocity, because 
velocity has a direction, while speed may be high, but without (or the wrong) direction".
He very successfully made the point that sometimes being fast and breaking things is okay, but there are also lots of
occasions when moving slow and fixing things is the better choice.
Altogether, I had the feeling Kevlin was summarizing a lot of my experiences from two decades as a professional software
developer exactly to the point.

Once again, definitely worth watching!  

## Kotlin for Java Programmers

Want to learn Kotlin and don't have much time?
Then I definitely recommend viewing [Venkat Subramaniam](https://twitter.com/venkat_s)'s talk.
It's force-feeding Kotlin concepts which would fill a two day training somewhere else into 50 minutes.
When watching this on Youtube, you might want to reduce the speed to avoid brain overload ;-)

When the session is over, one could feel like you could (and also want to) start programming in Kotlin immediately.

Personally, I would like to see a conference talk battle between Venkat and [Josh Long](https://twitter.com/starbuxman)
to find out who speaks faster and packs more stuff into the minute :D

## Quickie: Spring Framework 5: Hidden Gems

If you're using Spring Framework for some time and already know all those major improvements that Spring 5 brings, 
having a look at this presentation by [Jürgen Höller](https://twitter.com/springjuergen) is really worth the time.
It turns the spotlight to the less prominent improvements, of which several might make the life of an Spring developer
easier.
My personal highlight is the build-time annotation processor, which might take away the real pain if long startup times
for heavily annotation driven Spring (Boot) applications.

## Quickie: Let’s config your Java Project (for Cloud)

Sorry to say it this harsh, but the time spent in this session was a waste of time.
Would have been a state-of-the-art talk 5+ years ago.
I admit I left after 10 minutes to get a good seat for the next session, which sounded so much more interesting.

## Modular Development with JDK 9

Alex Buckley, specification lead for Java at Oracle, gave a really thorough overview on the new medule system im Java 9.
Presenting the new concepts, the steps to migrate an existing application to Java 9 and what to watch out for, I would
recommend this talk to anyone who hasn't looked deeper into the Java module system and wants to get a condensed 
introduction.

## Plain Functional Programming

In this talk, originally announced as a beginner-level talk, but  changed to intermediate-level, Scala inventor 
[Martin Odersky]() explained Kleisli triples and implicit functions, and why you sometimes shouldn't use them either.
Although I wasn't able to grasp everything, being not too deep into functional programming yet, the main takeaway, 
the concept of least power, is surely relevant way beyond the domain of functional programming. 
One could also apply this easily to Spring.
If you're really into functional programming, this session might be interesting to you.
Otherwise, if you're not too deeply into FP, be wary about this talk, as it definitely not beginner level.   

## API Versioning for Zero Downtime

I was keen to visit this talk since the everlasting question on how to deal with changing APIs is also challenging us
at ePages. From that perspective, and the expectations I had from the abstract, I was really disappointed from what
[Patrice Krakow](https://twitter.com/patricekrakow), lead architect at ING, finally presented.
He talked about service discovery, routing, server-side and client-side loadbalancing and also about how to pin a
service to a specific API version, but not about how to deal with changes in the API itself.
Aside from this, the talk gave a good introduction into into mentioned topics, while sometimes being too focused on
ING's specific requirements, which migth not be relevant for others, which therefore could easily choose different
solutions.

## JUnit 5 — The New Testing Framework for Java and Platform for the JVM

In this last full session of the day, [Sam Brennan](https://twitter.com/sam_brannen) and
[Marc Phillipp](https://twitter.com/marcphilipp) introduced the new architecture of JUnit 5, together with a lot of 
its cool new features.
Really recommended if you want to get a quick introduction, together with live coding examples.

## Summary

Wow.
What an amazing first day, packed with so much good stuff.
With the amount of information being packed into one day, I might even need to watch the recordings of some talks
I visited to get all out of it. This was by far the most interesting, but also the most exhausting conference day
I attended in the last few years. Now I really need to get some sleep to be able to follow tomorrow's sessions,
which I'm eagerly looking forward to!

Stay tuned for the Thursday summary...