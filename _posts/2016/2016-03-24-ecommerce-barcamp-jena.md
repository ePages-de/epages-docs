---
layout: post
title: "Visiting the eCommerceCamp in Jena"
date: "2016-03-24 09:03:24"
icon: shopping-cart
categories: events
authors: ["Benjamin"]
---

The [eCommerceCamp](http://www.ecommerce-camp.de) is an annual [BarCamp](http://barcamp.org) that takes place in Jena, the capital of the eCommerce sphere in Germany, where a lot of the magic of online shopping started and still happens today. As always the highly affordable tickets for the unconference were sold out upfront and around 300 participants from near and far were expected. The orga team from [tritum](http://www.tritum.de) and [marmalade](http://www.marmalade.de) did a terrific job by creating an inspiring environment, which let everyone look forward to up-to-date topics about shop systems, productivity habits, email marketing, new technologies, customer satisfaction and team collaboration or even juggling with circus balls.

## The participants

The clientele consists mainly of UI and UX designers, frontend and backend developers, project managers, some marketing people and also a few dedicated testers from web agencies with 1 to 20 people, who typically work with self-contained content management systems like [Magento](https://magento.com), [OXID](http://www.oxid-esales.com), [Shopware](https://en.shopware.com), [TYPO3](https://typo3.org) or even [WordPress](https://wordpress.com). Attendees from the global eCommerce players are typically lesser represented, but this doesn't mean that local matadors like [Intershop](http://www.intershop.com) or ePages are not there as well.

{% image blog/blog-ecommerce-barcamp-1.jpg %}{% endimage %}

## The setting

The event began with a dinner on Thursday evening in the famous local restaurant [Zur Noll](http://www.zur-noll.de/), which should break the ice of everyone's comfort zone and kickoff the communication flow.

On Friday morning all participants met in the auditorium at the [Ernst-Abbe-Hochschule Jena](http://www.eah-jena.de/), University of Applied Sciences, which served as hosting space. After a collective breakfast the session planning for both days took place. Everybody can suggest an own Open Space talk. The crowd expresses interest in a suggestion via raising their hands. This immediate reaction allows a proper planning of the time slot and room allocation for the session.

## The sessions

To give you a better impression of the actual contents of the conference I want to outline some of the sessions. As I am a backend software craftsman you may recognise easily that I skipped the marketing and lawfully oriented parts of the event and tried to focus on the more technical talks.

{% image blog/blog-ecommerce-barcamp-2.jpg %}{% endimage %}

The first session was held by Christoph Rüger, who is part of a small team that has built a new cloud service that reads data from files (uploaded CSV, XML, Google Drive etc.) and let's the user create workflows via Drag'n'Drop (e.g. cronjobs with conditions and scheduling) that can interact with other service providers. Christopher revealed which tools his team used for internal project management and customer communication. He also explained the process of finding the fitting frameworks for developing their service, which was a quite interesting to follow.

The next presentation dealt with the topic "Infrastructure as Code". Jan Peschke and Manuel Dieckmann prepared a talk about how they automated the rollout and development of Shopware environments with [Ansible](https://www.ansible.com/) and [OpenStack](https://www.openstack.org), a solution similar to [Amazon AWS](https://aws.amazon.com). Currently this cloud technology is on the transition to the state of production-readyness but not there yet. However a lot of minor service providers already emphasize OpenStack in the marketing ads as a blazing part of their customer portfolio. In the session it was made clear that developers have to be very careful with such announced offers as the promises of most providers can be very disappointing and do not hold up to an usable support of OpenStack. So be careful, if you opt against rackspace. Nevertheless, the framework in general is very interesting and already provides a lot of functionality. It will be worth to follow in the future.

{% image blog/blog-ecommerce-barcamp-4.jpg 45% right %}The orga team{% endimage %}

Another interesting session was a guided discussion about [Magento 2](https://magento.com/developers/magento2). Björn Jacob and Tobias Vogt explained in an entertaining fashion the new functio set in frequent interplay with the strongly involved audience. Over the whole session length, the enhancement of the productivity and performance improvement as well as the overall stability of the new major relase were questioned very often. The consolidated experience of the session room concluded that serveral good architectural decisions for this release were made, e.g.: [less](http://lesscss.org/) compiler, modes (default, env, prod), stricter separation of layout and logic via templates and modules, dependency injection, service contracts, XML schema definition for config files. The software project has become much more open and community driven. Another observation was that version 2.1 might be able to offer a competive performance.

The last track on Friday was offered by Andreas Ziethen, who humbly claims to be the senior apprentice at his company. In fact he is the highly likeable head of RND that flawlessly proved his comprehensive knowledge about deployment automation in front of a full room. The encouraging talk focused on the usage of [GitLab](https://www.gitlab.com) for deployment and [Rundeck](http://rundeck.org) for job scheduling and runbook automation. Today, the interplay of both technologies is already at a very mature quality level and typical tasks like staging and conditional build steps can be represented within versioned job descriptions. If you have a small shop project with a minimal set of requirements for your CI and CD pipeline setup the discussed solution might be competitive with [Jenkins](https://jenkins-ci.org), [Bamboo](https://confluence.atlassian.com/bamboo) or [TeamCity](https://www.jetbrains.com/teamcity/).

On Saturday there were only three time slots before the closing speech. 

The first session, presented by Oliver Reißig, centered around Continuous Integration in a large-scale shop platform utilizing [Gradle](http://gradle.org/). In the second one Eimantas Kaleiva showcased frontend acceptance testing, where the test cases were written by the product owner in a [BDD](http://behaviourdriven.org/)-style webinterface similar to [Cucumber](https://cucumber.io). The very last session comprised the findings for relaunches of large shops under various key aspects (e.g. the usage of [Atomic Design](http://bradfrost.com/blog/post/atomic-web-design) for the storefront layout or the establishment of worthwhile meeting structures) and was moderated by Jan Persiel.

## The surroundings

To brighten the mood of all participants the facilitators supplied superb food which fulfilled multitudinous desires: crispy chicken legs, juicy steaks, grilled roast beefs, 5 different soups, plenty of vegetarian food, fresh asparagus and salmon, many sandwich variations, 10 dessert cremes, cake pops, tropical fruits and even a popcorn machine wagon was present. Consistently, I could spot happy foodies everywhere!

Another form of active relaxation between the session breaks could be accomplished by a short visit of the gaming corner. Several retro consoles awaited their live field-test in battle matches with Super Mario Kart and other classics.

{% image blog/blog-ecommerce-barcamp-3.jpg %}{% endimage %}

## Resume

All in all, the conference offered a friendly atmosphere to meet new people with a wide range of backgrounds. Many sessions were quite enjoyable with a wide variety of topics. There were some great ones, too. From what I have seen, the conference can totally be recommended for PHP developers and ecommerce newcomers.

Before the eCommerceCamp is after the eCommerceCamp, so be ready for a visit next year!
