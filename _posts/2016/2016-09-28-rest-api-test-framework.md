---
layout: post
title: "How we test our API"
date: "2016-09-28 11:11:11"
image: blog-header/heartbeat.jpg
categories: tech-stories
authors: ["Ulf B."]
---

Long ago, when starting the development on the ePages public REST API, they decided to
implement it as a separate service because
at this time, ePages6 was only one huge Perl monolith and already hard to handle.

This service is implemented in JAVA using Jersey and it communicates with the monolith via REST and SOAP.
So we had to add a REST API to the Perl monolith as well, but just a simplified one - without any complex token and right management.
This is completely moved to the Java part where existing features of Jersey could be used.

Of course all the resource and services classes are coverey by unit test on both side, Perl and Java, but
since the functionality of the API is based on two different projects that lie in two different repositories
which have two different teams responsible for the releases,
we wanted to have a way to check with one click if everything - from end to end - is working as expected.
This was the starting point of RAT - our Rest API Test framework.

## RAT

The idea of RAT is to have a framework that test all the features of the REST API, so RAT sends requests to the API and validates the response.
To be able to compare the response with an expected one, we let the test base on shop of the DemoShopType
(The developer installation of ePages includes a DemoShopType which allows to create a demo shop with certain products of different types and a few orders).
We wanted the test cases to be able to run in a arbitrary order. The problem is that some of the API calls change a shop (DELETE product),
which lead to different results in the following calls. The solution is to create new shops for testing those calls.
The ePages6 REST API does not offer an endpoint to create new shops so far, so we used the ePages SOAP API to do that.


#### Technologies

RAT is based on [Serenity BDD](http://www.thucydides.info) and [REST-assured](http://rest-assured.io/). Similar to [Cucumber](https://cucumber.io/) in the Ruby world,
Serentiy allows you to describe and structure the test cases in way that acts like a complete specification with a checklist.


The certain test cases are implemented using REST-assured. It is a framework that is specially designed for testing REST APIs and allows easily to send different kind of requests and validation of their responses.

After running all the test, Serenity generates a HTML test report. On its homepage, the report offers a nice pie chart showing the test results of each category. The following image shows how this diagram currently looks like in our project.

{% image blog/blog-rat-serenity-results.png %}

We try to work test-driven, therefore there are a few test cases in a *pending* state (To do that, Serentity offers a @Pending annotation).
These test cases are already written but will be skipped since the features they should test are not yet implemented. As soon as everything is in place, the tests can be activated.


{% image blog/blog-rat-serenity-results-slideshow.png %}
