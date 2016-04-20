---
layout: post
title: " Guest post: Jena Developers shipped the Docker Party to ePages!"
date: "2016-04-20 12:04:20"
icon: cubes
categories: events
authors: ["Softwerkskammer Jena"]
---

The newly founded [Softwerkskammer Jena](https://www.softwerkskammer.org/groups/jena) had its first [Developers Meetup](www.meetup.com/jenadevs) on the beginning of April.
ePages hosted the event and provided conference rooms, several workstations as well as a variety of snacks, pizza and beverages. Over 30 attendees joined the Docker Party. Developers from nearby companies, students from the local universities and even some freelancers followed the [invitation](https://github.com/jenadevs/jenadevs-meetup-001-docker-party/blob/master/orga/Softwerkskammer_Jena_Developers_Meetup_001_Docker_Party.pdf). We had 4 hours of coding fun from 6 pm until nearly 10 pm with an open end at the local pub, where avid discussions lasted until 2 am in the morning.

## Agenda

We started with a short meet and greet as well as a brief introduction about the [Softwerkskammer](softwerkskammer.org) – the german part of the [Software Craftsmanship Community](http://manifesto.softwarecraftsmanship.org) – and its current distribution with some helpful contact information like the [@jenadevs](https://twitter.com/jenadevs) Twitter account.

Then the Docker Party was launched and we celebrated the [3rd birthday of Docker](https://www.docker.com/community/docker-birthday-3)!

The agenda included a one hour talk along with a demo to introduce the technological foundation as well as different workshops for every skill level:

  1. **Beginners:** The official Docker birthday app tutorial
  1. **Advanced:** Building your own Dockerfile according to best practises in conjunction with integration tests 
  1. **Special:** CoresOS Cluster Workshop
  1. **Hidden - also known as exploding kittens:** Orchestration Workshop by [Jérôme Petazzoni](https://twitter.com/jpetazzo), the creator of [Docker-in-Docker](https://github.com/jpetazzo/dind) 

## Introduction talk with demo and best practises

The first part of the introduction talk focused on the Docker basics, the components of the Docker ecosystem and the general tooling workflow of building images, running containers and pushing them to the Docker Hub.
We had a demo on the basic commands along with some live coding on the terminal, where several containers were also inspected at runtime.
The second part considered some best practises for writing your own Dockerfile, which was based on the [official Docker recommendations](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices), tips by [Michael](http://crosbymichael.com/dockerfile-best-practices.html) [Crosby](http://crosbymichael.com/dockerfile-best-practices-take-2.html) as well as the experiences of [epagesdevs](http://twitter.com/epagesdevs) with developing, testing, integrating, deploying and running supportive images for our eCommerce platform.
This was a nice opportunity to also show some of our typical use cases at ePages, e.g. in the Continuous Delivery Pipeline, for integration testing or in the operations area of our own and provider infrastructure based already partly on [Kubeneretes](http://kubernetes.io).
The talk finished with some typical base images as well as a discussion about official app environment images.

## Containers, Containers, Con... er Workshops!

Upfront, all necessary material and code for the workshops was hosted on the jenadevs [GitHub](https://github.com/jenadevs) account, which even offers the [complete presentation](https://github.com/jenadevs/jenadevs-meetup-001-docker-party).
Great news: _All material of **[jenadevs](https://github.com/jenadevs)** is free and will always be open-source!_

### Beginners workshop

The goal of the beginner workshop was to setup the Docker environment, learn the basic commands, run the workflow and become familiar with Docker Compose.
The participants followed the [official Docker birthday tutorial](https://github.com/docker/docker-birthday-3/blob/master/tutorial.md), while the more experienced Docker users, Benjamin Nothdurft and Kay Abendroth, offered assistance.
As kittens bustled around the beamer and laptop screens, the Docker newbies built simple web applications using the Python microframework [Flask](http://flask.pocoo.org/) – all running in a container, of course.

### Advanced workshop

This workshop focused on writing your own Dockerfiles, run the containers and integration testing with [CircleCI](https://circleci.com). Bastian Klein prepared an empty custom [Magento](https://magento.com) `Dockerfile` and `Circle.yml` with comments left only, where the implementation code was completely removed.
The attendees then had to figure out how the Dockerfile commands needed to be configured under the guidance of the workshop maintainer.

### Special workshop

The most experienced Docker users gathered together in the special workshop, where the main focus was a bit shifted. Three workstation laptops had been prepared to introduce [CoreOS](https://coreos.com) to the participants. 
Andreas Grohman introduced the open-source lightweight operating system designed for providing infrastructure to clustered deployments to the each participant. 
The goal was to [setup a cluster environment](https://developer.epages.com/blog/2016/01/19/setup-a-coreos-cluster.html#why-use-coreos) with three nodes and run Docker on it.
Everyone succeeded.
Afterwards Christian Köhler gave an insight on how to configure Kubernetes with a short demonstration. He also distinctly outlined the advantages to Docker Swarm.

## Summary 

In retrospect, this meetup was a great success. Every participant had the possibilty to have fun, meet other devs and learn something new.
Except for the beginners, who rarely neede to finalise their well-documented tutorial at home, all participants were able to finish all workshop tasks on time with excellent results. So it was obvious that a lot of guests joined parts of the orga team in the local bar and just talked about the expierience in their developer life, their favorite editors and some nerdier stuff.

Thanks to all attendees and ePages coworkers for making this happen!

## Next meetup

The goal of the Softwerkskammer Jena is to establish a platform for regular meetings.
And we already arranged the next Meetup!
This time we simulate a [coding dojo](http://codingdojo.org) with a full day of classical [Coderetreat](http://coderetreat.org) and lighting talks with demos on [TDD](https://en.wikipedia.org/wiki/Test-driven_development) basics and Unit testing with Mock Objects upfront.
Again, the participants will be able to choose between different workshop-like groups.
In each group we train our coding skills on a specifc kata in iterative 45-minute-rounds under certain [constraints](http://coderetreat.org/facilitating/activity-catalog) in [pairs](https://en.wikipedia.org/wiki/Pair_programming) and with different team mates at each round.

We are very happy that [Marco Emrich](https://twitter.com/marcoemrich) from the [Softwerkskammer Nürnberg](https://www.softwerkskammer.org/groups/nuernberg) will join us - one of the best trainers, and an experienced Coderetreat facilitator. We cannot think of anyone better to help the participants understand how to start with the test-first approach!

Save the date: this one-day event is planned for Saturday, the 21st of May 2016 from 9:30 am until 5:30 pm! Feel free to [already sign up](www.meetup.com/jenadevs) for the event.
