---
layout: post
title: "Guest post: Softwerkskammer Jena shipped the Docker Party to ePages!"
date: "2016-04-21 12:04:21"
image: blog-header/docker-party.jpg
categories: events
authors: ["Softwerkskammer Jena (Oliver and Benjamin)"]
---

The newly founded [Softwerkskammer Jena](http://www.softwerkskammer.org/groups/jena) had its first [Developer Meetup](http://www.meetup.com/jenadevs) at the beginning of April.
ePages hosted the event and provided conference rooms, several workstations as well as a variety of snacks, pizza and beverages.
Over 35 attendees joined the Docker Party.
Developers from nearby companies, students from the local universities and even some freelancers followed the [invitation](https://github.com/jenadevs/jenadevs-meetup-001-docker-party/blob/master/orga/Softwerkskammer_Jena_Developers_Meetup_001_Docker_Party.pdf).
We had 4 hours of coding fun from 6 pm until nearly 10 pm with an open end at the local pub, where vivid discussions lasted until 2 am in the morning.

## Agenda

We started with a short meet and greet as well as a brief introduction about the [Softwerkskammer](http://softwerkskammer.org) – the german part of the [Software Craftsmanship Community](http://manifesto.softwarecraftsmanship.org) – and its current distribution together with some helpful contact information like the [@jenadevs](https://twitter.com/jenadevs) Twitter account.

Then the Docker Party was launched, and we celebrated the [3rd birthday of Docker](https://www.docker.com/community/docker-birthday-3)!

The agenda included a one hour talk along with a demo to introduce the technological foundation as well as different workshops for every skill level:

  1. **Beginners:** The official Docker [birthday app project](https://github.com/jenadevs/docker-birthday-3)
  2. **Advanced:** Build your own Dockerfile according to best practises in conjunction with integration tests
  3. **Special:** CoresOS cluster workshop
  4. **Easter egg:** [Orchestration workshop](https://github.com/jenadevs/orchestration-workshop) by [Jérôme Petazzoni](https://twitter.com/jpetazzo), the creator of [Docker-in-Docker](https://github.com/jpetazzo/dind)

## Introduction talk with demo and best practises

The first part of the introduction talk focused on the Docker basics, the components of the Docker ecosystem and the general tooling workflow of building images, running containers and pushing them to the Docker Hub.
We had a demo on the basic commands along with some live coding on the terminal, where several containers were also inspected at runtime.

The second part considered some best practises for writing your own Dockerfile, based on the [official Docker recommendations](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices), tips by [Michael](http://crosbymichael.com/dockerfile-best-practices.html) [Crosby](http://crosbymichael.com/dockerfile-best-practices-take-2.html) as well as the experiences of [epagesdevs](http://twitter.com/epagesdevs) with developing, testing, integrating, deploying and running supportive images for the eCommerce platform.

This was a nice opportunity to also show some typical use cases at ePages, e.g. the Continuous Delivery Pipeline for integration testing, or that both, the ePages and the provider infrastructure are already based partly on [Kubernetes](http://kubernetes.io).
The talk finished with some typical base images as well as a discussion about official app environment images.

{% image blog/blog-docker-presentation.jpg %}

## Containers, containers, con... er workshops!

Upfront, all necessary material and code for the workshops was hosted on the jenadevs [GitHub](https://github.com/jenadevs) account, which even offers the [complete presentation](https://github.com/jenadevs/jenadevs-meetup-001-docker-party).
Good news: all material of [jenadevs](https://github.com/jenadevs) is free and will always be open-source!

{% image blog/blog-docker-workflow.jpg 30% right %}

### Beginners workshop

The goal of the beginners workshop was to setup the Docker environment, learn the basic commands, follow the common workflow and become familiar with Docker Compose.
The participants were guided through the official Docker birthday [tutorial](https://github.com/jenadevs/docker-birthday-3/blob/master/tutorial.md) by Benjamin Nothdurft and Kay Abendroth.
As a first step, the Docker newbies built a simple web application, which served random kitten pictures using the [Flask](http://flask.pocoo.org) microframework.
In the end, the beginners already created and customised a multi-container voting application with a Python user app, a Redis queue for buffering, a Java worker for processing, a PostgreSQL database for storage and a Javascript administration app - all running from a single `docker-compose.yml` file.

{% image blog/blog-docker-beginners.jpg 40% left %}

### Advanced workshop

This workshop focused on writing your own Dockerfiles, running the containers and configuring integration testing with [CircleCI](https://circleci.com).
Bastian Klein prepared an empty custom [Magento](https://magento.com) `Dockerfile` and `Circle.yml` with comments left only, where the implementation code was completely removed.
The attendees then had to figure out how the Dockerfile commands needed to be configured, guided by the workshop maintainer.

{% image blog/blog-docker-kubernetes.jpg 30% right %}

### Special workshop

The most experienced Docker users gathered together in the special workshop, where the main focus was a bit shifted.
Three workstation laptops had been prepared to introduce [CoreOS](https://coreos.com) to the participants.
Andreas Grohmann introduced the open-source lightweight operating system designed to provide infrastructure to clustered deployments to the each participant.
The goal was to [setup a cluster environment](https://developer.epages.com/blog/2016/01/19/how-to-setup-a-coreos-cluster-on-windows-and-centos.html#why-use-coreos) with three nodes and run Docker on it.
Everyone succeeded.
Afterwards, Christian Köhler gave an insight on how to configure Kubernetes with a short demonstration.
He also distinctly outlined the advantages of Docker Swarm.

## Summary

In retrospect, this meetup was a great success.
Every participant had the possibility to have fun, meet other developers and learn something new.
Except for the beginners, who finalised their well-documented tutorial at home, all participants were able to finish all workshop tasks on time with excellent results.
So it was obvious, that a lot of guests joined parts of the orga team in the local bar and just talked about the experience in their developer life, their favourite editors and some "nerdy" stuff.

Thanks to all attendees and ePages coworkers for making this happen!

## Next meetup

The goal of the Softwerkskammer Jena is to establish a platform for regular meetings.
And we already arranged the next meetup!
In the course of a one-day event, we will facilitate a [coding dojo](http://codingdojo.org) consisting of a classical [Coderetreat](http://coderetreat.org) and lighting talks with demos on [TDD](https://en.wikipedia.org/wiki/Test-driven_development) concepts upfront, e.g. Unit testing with mock objects.
Again, the participants will be able to choose between different workshop-like groups.
In each group we train our coding skills on a specific kata in iterative 45-minute-rounds under certain [constraints](http://coderetreat.org/facilitating/activity-catalog) in [pairs](https://en.wikipedia.org/wiki/Pair_programming) and with different team mates in each round.

We are very happy that [Marco Emrich](https://twitter.com/marcoemrich) from the [Softwerkskammer Nürnberg](https://www.softwerkskammer.org/groups/nuernberg) will join us - a highly passionate trainer and an experienced Coderetreat facilitator.
We cannot think of anyone better to help the participants understand how to start with the test-first approach!

Save the date: this one-day event is planned for Saturday, the 21st of May 2016 from 9:30 am until 5:30 pm!
Feel free to already sign up for the event at the [meetup](http://www.meetup.com/jenadevs) or the [Softwerkskammer](https://www.softwerkskammer.org/groups/jena) platform.

PS: The Docker shirts and stickers finally arrived yesterday after persistent negotiations with the customs office.
You may catch yours at the next meetup!
See you there.

{% imagecaption blog/blog-docker-jenadevs-orga.jpg 47% left %}The orga team{% endimagecaption %}

{% imagecaption blog/blog-docker-stickers.jpg 47% right %}The Docker shirts and stickers{% endimagecaption %}
