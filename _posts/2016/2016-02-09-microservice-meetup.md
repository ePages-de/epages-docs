---
layout: post
title: "epages hosts Microservices Meetup"
date: "2016-02-09 07:16:34"
icon: cc-discover
categories: events
authors: ["Mathias"]
---

Full house at epages in Hamburg!
Last Wednesday, we hosted the [Microservices Meetup Hamburg](http://www.meetup.com/de-DE/Microservices-Meetup-Hamburg/events/224965581/?a=socialmedia).
About 30 developers accepted the invitation and came to listen to the story about our journey through the world of Service Discovery.

{% image blog-microservice-meetup-1.jpg %}{% endimage %}

We had two presentation slots that filled the evening.
And next to soft drinks, beer and pizza, there was also enough time to talk shop.

With microservices we are pushing complexity from the application into the infrastructure. One of the complexities that you find yourself confronted with in the world of microservices is service discovery.

When many services need to find their peers you want a service discovery solution that can add and remove services as they come and go, check the health of the known services, remove unhealthy ones and provide load balancing capabilities to be able to spread the load among the service instances.

We evaluated different service discovery solutions with different strategies. In his presentation Dirk went through these solutions, explained their characteristics and reasoned about the pros and cons.

He started with [Eureka](https://github.com/Netflix/eureka/wiki/Eureka-at-a-glance) from the Netflix OSS stack. We used it in one of our early prototypes. Eureka works with a central registry that is replicated on each service and uses client-side load balancing for service calls.

Eureka itself made a good impression but we discarded it along the way - also because back then it required code changes on the client side and we wanted something less intrusive.

We tried to keep service discovery out of our code as much as possible and we added Docker to our infrastructure tool set. So the service discovery solution should seamlessly integrate into this environment as well. This lead us to a [Consul](https://www.consul.io/)-based service discovery approach that we already talked about in detail [earlier on this blog](https://developer.epages.com/blog/2015/09/28/service-discovery.html).

Later we chose [Kubernetes](http://kubernetes.io/) as our container management solution and in Kubernetes we already found a DNS-based service discovery solution that could also fulfill our needs. So it felt strange to have our own service discovery stack running while Kubernetes offers something similar. That lead us to the adoption of Kubernetes also for service discovery. This helped us to reduce our infrastructure complexity and relieved us from managing additional components.

On the service client side we introduced [Ribbon](https://github.com/Netflix/ribbon/wiki) for outbound service calls. Thus we can work with logical service names in a managed environment like Kubernetes but can also wire services together that run locally in a dev environment. Using the Spring framework the usage of Ribbon can be reduced to a few annotations enabling us to keep our service code (almost) free of service discovery concerns.

{% image blog-microservice-meetup-3.jpg %}{% endimage %}

After Dirk finished to guide us through this journey towards our current service discovery solution we took a break to recover with beer and pizza. There were excited discussions about the topic showing that service discovery is a topic that is of great interest in the community at the moment.

{% image blog-microservice-meetup-2.jpg %}{% endimage %}

After the pizza break Oli continued with a demo including live coding of two services demonstrating our service discovery solution in action. Oli not only showed how easy calling a service is on the development side, but also how scaling and health-checking can work in Kubernetes. You can find the [demo code on github](https://github.com/otrosien/meetup-2016-02-code).

The slides of our talk can be found [here](http://epages-de.github.io/meetup-2016-02-slides/).

We really like the idea of Meetups and are happy that we could participate. So it is not unlikely that more Meetups @epages will follow. Last but not least we would like to thank Thomas Hackbarth for organizing the Microservices Meetup Hamburg and for given us the oppportunity to host this event.
