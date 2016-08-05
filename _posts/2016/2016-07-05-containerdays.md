---
layout: post
title: "ContainerDays Hamburg"
date: "2016-07-05 10:16:17"
image: blog-header/container2.jpg
categories: events
authors: ["Christian K."]
---

On the 27th and 28th of June 2016, the first ContainerDays took place in the Port of Hamburg, Germany.
The main goal of this event was to:

> "[..] provide the European container community with the necessary platform to promote and professionalize the thriving container movement."

The event was divided into a conference day and a workshop day.
The first day was dedicated to workshops that focused on the practical use of container technologies like [Docker](https://www.docker.com/), [Kubernetes](http://kubernetes.io/), and [Mesosphere](https://mesosphere.com/).
The workshops were followed by a Meetup session in the evening.
The second day focused on talks from experts within the container community.
They presented their insights and experiences in the field of the IT infrastructure of the future.

In this post, I share some notes that I took from the various sessions I was particularly interested in.

## Meetup

### Tobias Schneck - [ConSol Software GmbH](https://www.consol.com/): Containerized End-2-End-Testing

The main point of this talk was about putting a VNC-Server and Selenium-like testing software ([sakuli](https://github.com/ConSol/sakuli)) in a container, and run UI tests with it.
They also integrated the E2E test in [Nagios](https://www.nagios.org/) and got some nice graphs and error reports out of it.

[Slides](https://rawgit.com/toschneck/presentation/docker-meetup-container-days/index.html#/)

### [Aaron Huslage](https://twitter.com/huslage) - [Docker](https://www.docker.com/): New Stuff in Docker 1.12

Aaron showed the new features of the upcoming docker release. The biggest part was the new orchestration framework (see [blog post](https://blog.docker.com/2016/06/docker-1-12-built-in-orchestration/)).

Some main points:

* Swarm Clustering, self healing.
* Build in PKI, rotation, revoke ...
* Routing Mesh: overlay network, load balancing, DNS based service discovery, IPVS
* Service API: scheduling, scaling, rolling upgrades, health checks

## Conference Day

### [Mandy Waite](https://twitter.com/tekgrrl) - [Google](https://www.google.de) : From Borg to Kubernetes: The history and future of container orchestration

This talk was mainly about efficient usage of cluster resources in Borg and with Kubernetes:

* New Feature in 1.3: Federated Cluster
{% youtube 86jZdmAjWns %}

### [Boyan Dimitrov](https://twitter.com/nathariel) - [Sixt](https://www.sixt.de/): Enterprise Microservice Adoption

The talk was about the first services developed as a microservice.

* Old solution: 95% developed in house and run in own datacenter
* Challenges: dependencies between teams, faster automation, enable teams to innovate and deliver

The approach:

* Bootstrap full stack team with archivable task
* Communicate a lot
* Create API, self contained databases, service should be killable, fail fast, define success
* Service template, new repos, Jenkins Jobs, Makefile
* Continuous delivery track: simple and repeatable
* Use [Micro](https://blog.micro.mu/) (microservice toolkit)
* Scale the pilot

The already have production traffic on Kubernetes.

### Erkan Yanar (Freelancer): Linuxkernel features building my $container

Erkan showed some basic commands how to interact with the kernel features that build the container.

Building blocks of container:

* chroot
* Capabilities: cat /proc/self/status, capsh --decode
* cgroups: examples: devices memory freeze
* Namespaces: cmd tool unshare

### Rainer Sträter - [1&1 Internet SE](http://www.1und1.de/): Application deployment and management at scale with 1&1

* Motivation for container: Web hosting stacks, new demands from customers, complex updates
* Everything is a container (mysql, php, ...)
* GlusterFS storage layer
* Kubernetes Cluster Size: 1000 Nodes, 1000 Container per Node
* Cluster running on CoreOS
* Open vSwitch for routing traffic
* Automation of container build with [drone.io](https://drone.io/). Watch for changes, build, test push.
* Applications need to support immutable updates
* Currently no own container
* Shortly publicly available as "Managed Hosting"

### [Mathias Lafeldt](https://twitter.com/mlafeldt) - [Jimdo](http://www.jimdo.com/index.php): A journey through wonderland

* Cloud migration took 5 years, now running on AWS
* Every team did their own monitoring, deployment, test, and other stuff
* Toolsmith team created Wonderland environment
* They run dockerised applications and one off tasks
* Provide APIs for logs, deployment, ...
* Toolsmith team as internal service provider: SLA, workshops, documentation, ....
* Tools in use: Docker registry, Vault, Chat bot, CoreOS (no SSH for devs)

[Slides](https://speakerdeck.com/mlafeldt/a-journey-through-wonderland)

### [Henning Jacobs](https://twitter.com/try_except_) - [Zalando](https://tech.zalando.de/): Plan B: Service to Service authentication with OAuth

About the dev environment:

* Shift to radical agility, autonomous teams, no team lead
* One datacenter per Team (AWS)
* All traffic is external traffic

What else?

* IAM on S3 for authorisation management
* S3 holds user and password, with that you can get Bearer tokens
* Token validation is tricky
* JWT for authentication with ES256 algorithm
* Validate via HTTP "Token Info" method or new OAuth RFC Token Introspective Endpoint
* Implemented revoke single token and revoke tokens by claim
* Revocation service gets revoked list every 30 seconds
* Service user needs to know credentials and token URL
* Service provider needs to know token info URL
* Cassandra for token storage
* 0.5 ms for validation + 8ms token info

[Documentation](http://planb.readthedocs.io/en/latest/)

[Slides](http://de.slideshare.net/try_except_/plan-b-service-to-service-authentication-with-oauth)

### [Florian Leibert](https://twitter.com/flo) - [Mesosphere](https://mesosphere.com/): Lightning Talk

* Helped Twitter and Airbnb to containerize their appilcations
* Presented Mesos as OS for the data centre
* Live example of Apache Spark with Zeppelin for analytics

### [Tobias Schmidt](https://twitter.com/dagrobie) - [Soundcloud](https://soundcloud.com/): Efficient monitoring in modern environments

Why Monitor?

* automatic alerting
* long term trends
* validate new features/experiments
* debugging

Points to check:

* Metrics: Host(CPU, memory, I/O, network, file system)
* Container (CPU, memory, restarts, OOM, throttling)
* Application (throughput, latency, queues)

Four golden signals to monitor:

1. Latency: time to serve a request; median doesn't reflect the user experience
2. Traffic: Demand placed on the system
3. Errors: Failure responses to user requests
4. Saturation & Utilisation: Consumption on constraint resources

* Alerting: optimise mean time to react and mean time to repair
* Symptom vs. Cause based monitoring
* Monitor/Alert for your users
* Only page if something needs immediate human intervention

* Prevent alert fatigue with:
  * Alert grouping, batch alerts
  * easy silencing
  * dependencies between services
  * static thresholds

What else?

* Use ticketing system for tracking non critical errors
* Critical(sms),warn(ticket), info(log only)
* Use run books, playbooks, and link them in the alerts
* Practice outages "game days"

[Slides](https://speakerdeck.com/grobie/efficient-monitoring-in-modern-environments)

### [Florian Sellmayr](https://twitter.com/fsellmayr) - [ThoughtWorks](https://www.thoughtworks.com/): A web shop in containers - Building the microservice platform for otto.de

* Running on Apache Mesos
* 600 VMs running live shop
* 10, 20 or 50 new services per year
* Plain docker is w/o fun, only glorified rpm
* Goals: freedom and responsibilities to the devs, new services without ops interaction, increase standardisation
* Distributed Systems are hard!
* Mesos a moving target. (frequent updates) → Keep on top of your tools
* Service discovery is hard in mesos
* Multi-Tenancy, shield teams from each other
* Managing Secrets, people find ways to work around shitty secret systems
* Task isolation, shop part vs. batch part
* Container isolation, mesos and docker isolation does not match
* Learn how to manage the chance in your cluster
* Work for 4-5 people one year
