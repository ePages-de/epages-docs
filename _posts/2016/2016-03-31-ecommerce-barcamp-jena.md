---
layout: post
title: "A report from the eCommerceCamp in Jena"
date: "2016-03-31 09:03:24"
image: blog-header/barcamp-jena.jpg
categories: events
authors: ["Benjamin"]
---

This march the [eCommerceCamp](http://www.ecommerce-camp.de), an annual [BarCamp](http://barcamp.org) took place for the 4th time in Jena, Germany.
At this site, a lot of the magical creation of online shopping started and still happens today.
As always, the highly affordable tickets for the unconference were sold out upfront and around two hundred participants from near and far were expected.
The orga team from [TRITUM](http://www.tritum.de) and [marmalade](http://www.marmalade.de) did a terrific job by creating an inspiring environment, which let everyone look forward to up-to-date topics about shop systems, productivity habits, email marketing, new technologies, customer satisfaction and team collaboration or even juggling with circus balls.

## The participants

The clientele consists mainly of UI and UX designers, frontend and backend developers, project managers, some marketing people and also a few dedicated testers from web agencies with 1 to 20 people. These agencies usually work with self-contained content management systems like [Magento](https://magento.com), [OXID](http://www.oxid-esales.com), [Shopware](https://en.shopware.com), [TYPO3](https://typo3.org) or even [WordPress](https://wordpress.com).
Attendees from the global eCommerce players are typically represented to a lesser extend, but this doesn't mean that local matadors like ePages or [Intershop](http://www.intershop.com) do not attend.

## The setting

The event started with a dinner in a famous local restaurant.
This was a nice ice breaker to kick off the communication and get out of our comfort zones.

The next morning, all participants met at the main BarCamp location, the auditorium at the [Ernst-Abbe-Hochschule Jena](http://www.eah-jena.de/), University of Applied Sciences.
After a collective breakfast, the session planning for both days started.
Anyone who wants may initiate an OpenSpace talk.
The other attendees express interest in a suggestion by raising their hands.
This immediate reaction allows a proper planning of the time slot and room allocation for the session.

## The sessions

In order to give a better impression of the actual contents of the unconference, I'd like to outline some of the sessions.
As a backend developer, I will focus on the technical talks and neglect the sessions about marketing or law.

{% image blog/blog-ecommerce-barcamp-jena-2.jpg %}

The first session was held by Christoph Rüger from [Synesty](http://synesty.com).
He is part of a small team that has built a new cloud service that reads data from files (uploaded CSV, XML, Google Drive etc.).
This service lets the user create workflows via drag and drop (e.g. cronjobs with conditions and scheduling) that can interact with other service providers.
Christoph revealed, which tools his team used for internal project management, customer communication and issue tracking.
He also explained the process of finding the fitting frameworks for developing their service, which was a quite interesting to follow.

The following presentation dealt with the topic "Infrastructure as Code".
Jan Peschke and Manuel Dieckmann prepared a talk about how they automated the rollout and development of Shopware environments with [Ansible](https://www.ansible.com) and [OpenStack](https://www.openstack.org), a solution similar to [Amazon AWS](https://aws.amazon.com). Currently, this cloud technology is well on the way to, but not yet fully production ready.
However, a lot of minor service providers already emphasise OpenStack in the marketing ads as a blazing part of their customer portfolio.
In practice, hosters support that to a varying extent so that developers should check that carefully themselves.
Nevertheless, the framework in general is very interesting and already provides a lot of functionality. It will be valuable to follow in the future.

{% imagecaption blog/blog-ecommerce-barcamp-jena-4.jpg 45% right %}The orga team{% endimagecaption %}

Another interesting session was a guided discussion about [Magento 2](https://magento.com/developers/magento2).
Björn Jacob and Tobias Vogt explained in an entertaining fashion the new functio set in frequent interplay with the strongly involved audience.
Over the whole session length, the enhancement of the productivity and performance improvement as well as the overall stability of the new major relase were questioned very often.
The consolidated experience of the session room concluded that serveral good architectural decisions for this release were made, e.g.: [less](http://lesscss.org/) compiler, modes (default, env, prod), stricter separation of layout and logic via templates and modules, dependency injection, service contracts, XML schema definition for config files.
The software project has become much more open and community driven. Another observation was that version 2.1 might finally be able to offer a sufficient performance.

The next encouraging talk — by Andreas Ziethen from [ScaleCommerce](http://www.scale.sc), an experienced DevOps engineer and self-claimed "senior apprentice" — focused on the usage of [GitLab](https://www.gitlab.com) for deployment in conjunction with [Rundeck](http://rundeck.org) for job scheduling and runbook automation.
Today, the interplay of both technologies is already at a very mature quality level and typical tasks like staging and conditional build steps can be represented within versioned job descriptions.
If you have a small shop project with a minimal set of requirements for your CI and CD pipeline setup, the discussed cloud solution might be comparable with [Jenkins](https://jenkins-ci.org), [Bamboo](https://confluence.atlassian.com/bamboo) or [TeamCity](https://www.jetbrains.com/teamcity) in this context.

On the last day, we had three slots before the closing speech.

The first session, presented by Oliver Reißig, centered around Continuous Integration in a large-scale shop platform using [Gradle](http://gradle.org/).
In the second one Eimantas Kaleiva showcased frontend acceptance testing, where the test cases were written by the product owner in a [BDD](http://behaviourdriven.org/)-style webinterface similar to [Cucumber](https://cucumber.io).
The very last talk and [presentation](http://janpersiel.com/why-designers-and-frond-end-developers-should-talk-more-often) by Jan Persiel comprised the findings for relaunches of large shops under various key aspects like the usage of [Atomic Design](http://bradfrost.com/blog/post/atomic-web-design) for the storefront layout or the establishment of worthwhile meeting structures.

## The surroundings

To brighten the mood of all participants, the facilitators supplied superb food which fulfilled multitudinous desires: crispy chicken legs, juicy steak, grilled roast beef, various soups, plenty of vegetarian food, fresh asparagus and salmon, dessert cremes, cake pops, tropical fruits and even a popcorn machine wagon was present.
Consistently, I could spot happy foodies everywhere!

Another form of active relaxation between the session breaks could be accomplished by a short visit of the gaming corner.
Several retro consoles awaited their live field-test in battle matches with Super Mario Kart and other classics.

{% image blog/blog-ecommerce-barcamp-jena-3.jpg %}

## Summary

All in all, the BarCamp offered a friendly and exciting atmosphere to meet new people with a big treasure trove of experience in shop systems.
Many sessions were very enjoyable with a broad spectrum of topics, and there were some outstanding ones, too.
From what I have seen, I can totally recommend this unconference. Especially for PHP developers and all sector newcomers, this event is definitely worth it.

Before the eCommerceCamp is after the eCommerceCamp, so be ready for a visit next year!
