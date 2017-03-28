---
layout: post
title: "eCommerceCamp Jena 2017"
date: "2017-XX-XX 07:00:00"
image: XXX
categories: events
authors: ["Jan"]
---

The e-commerce camp is a German [BarCamp](https://en.wikipedia.org/wiki/BarCamp) conference which took place from March, 16 to March, 18 in Jena. The subject was the exchange of experiences in the fields shop system integration, Content/Marketing/Usability/Logistic, project management, security and technology in general.

This blog post is a summary of the talks which I attended there.

# Stable Software in Volatile Environements

Kore Nordmann (Qafoo)

All software systems increase in complexity over time. With increased complexity it becomes more and more difficult to react to changing requirements and resolve defects. When forced to do updates, e.g. changed APIs or new database technology required, it often happens that it becomes so difficult to change the system that people think about chaning the underlying system, e.g. move from Shopware to Oxid or from Oxid to Shopware. Three years are a critical time frame for this. Thus the complexity needs to be hold as low as possible.

The suggested solution to survive after those three years is to use a hexagonial architecture. There should be minimum dependencies on the underlying framework. The extensions should use their own domain objects and dependency injection for the framework functionality. This is a tradeoff between long term stability and short term development time. One possible strategy to achieve the goal is to to focus on the business domain is the branch by abstraction pattern. Further tips from him were to use frameworks instead of implementing low-level layers by yourself, hide the frameworks behind a facade to be able to swap them out later on, use own domain objects for the feature implementation instead of the objects from the framework, and to include design guidelines in the Definition of Done.

Kore doesn't see REST APIs as a good option to achieve the recommended decoupling for shop extensions as for him they are too slow for always everything. He preferes to use plain old PHP objects instead.

# The evolution of shop systems

Nico Saborowski, dotSource

The current e-commerce system is dominated by platforms, e.g. Amazon and ebay in the B2C market and Alibaba and mercateo in the B2B market. Those marketplaces are cheaper for the merchants but come with their own challenges. There is a tought price competition and those marketplaces can define rules which might conflict with their own business plans.

So what can business do as an alternative to marketplaces? They can apply an agressive low-price strategy, sell in multiple channels, personalize marketing material, improve the product documentation (e.g. with "visual micro content" and product configurators) or use the online shop primarily for C-customers.

Some years ago the online shops where driven by the ERP system. The ERP system contained lots of modules (e.g. PIM, CRM) and the shop was connected to it. The next generatation of online shops was shop drive. The ERP system with all its modules was connected to the shop system. The latest generation is customer driven. The shop is in the center. For all the other required tools the best of breed solution is selected and connected to the shop, maybe a self-implemented solution, similar to the microservice architecture style.

# Those who give, will win!

Siegbert Emde – JTL-Software

This talk started with a report the cultural shock of the speaker when he started to work at JTL software. He suggested ideas to maximize the sales but found only closed doors. The reason behind this is that they focus on providing good services instead of many. The company started out as a software projected implemented for a friend and has later been open sourced. They said that they don't try to sell everthing they can but recommend other tools if it better fits to the requirements of the client. This strategy leads to effective recommendation marketing. The company is earning the salary of about 100 employees with hosting services and support. There is no individual software development but new features are implemented after votes in their online community.

The second half of the presentation was an overview over the components of the software. At the core it is a warehouse management software. There are also a couple of other modules, e.g. their eBay and Amazon integration easyAuction. All the features of JTL can be used via third-party tools via their connector module. Only one feature is not available as open source: having multiple shops.

# Hexagonal Architecture

Patrick Jahns - solutionDrive

The talk started with the question of whom considers himself a Shopware or oxid developer? There were a few people in the room who answered this question with yes. The follow up question was whether they know about software architure if they know a framework, e.g. [Symfony](https://symfony.com/). The only answer was no. This was succeeded by an observation that new projects often start with more discussions about which tools and framworks to use than about the software architecture.

An example for unmaintainable code was shown to illustrate the problems that come along with this. Though this can yield quick wins it can lead to problems regarding the long term maintainability: it is difficult to test, hard to reuse, tests have a long runtime and it is difficult to read. Another cause for technical dept can be too tight coupling to the framework of choice. As solution for this the [Hexagonal Architecture](http://alistair.cockburn.us/Hexagonal%2Barchitecture) concept from Alistair Cockburn was presented and combined the idea that the domain-related problems are at the heart of the software and should be prioritized as such by Eric Evans. The [SOLID principles](http://butunclebob.com/ArticleS.UncleBob.PrinciplesOfOod) and [Clean Architecture](https://www.youtube.com/watch?v%3DNsjsiz2A9mg) proclaimed by Uncle Bob are also related to this.

Someone in the audience mentioned that the presented clean code practices is a great idea for hobby projects but too hard to implement in business projects with tight budgets and deadlines. This started a discussion of the pros and cons. The solution for this problem might be to apply [continuous refactoring](https://www.youtube.com/watch?v%3DvqEg37e4Mkw&feature%3Dyoutu.be&t%3D12m34s). Further it was mentioned that both extremes on the quality scale are not healthy. There needs to be a compromise. E.g., the core product should have a high internal quality and fixed budget projects could be wrapped by an interface and then added on top of it.
