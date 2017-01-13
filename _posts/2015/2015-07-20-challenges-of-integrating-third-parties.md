---
layout: post
title: "Challenges of integrating third-parties"
date: "2015-07-20 14:26:17"
image: blog-header/puzzle.jpg
categories: tech-stories
authors: ["Ulf B."]
---

Third-party applications are an important part of the service that ePages offers.
As our applications are built on an internal application platform, ePages developers are highly dependent on third-party services.
Read more to find out why it is not the easiest thing to integrate third-parties and how we tackle this.

## The use case

{% image blog/blog-third-party-overview.png %}

Example: If a customer buys a product in an ePages online shop, they could choose e.g. PayPal as payment method and DHL as delivery method.
The customer could also obtain an insurance with Trusted Shops.
(Read further [here](http://www.epages.com/en/partner/technology-partner/) to get an overview of our technology partners.)
A checkout alone can easily have three third-party dependencies.

The merchant, in turn, receives information via server-sided callbacks, if an order has been paid.
They can generate shipping labels via the web service of a third-party shipping method or synchronise their online shop with ERP-software.
These are just a few examples of third-party integrations at ePages.
There are a lot more use cases where both customer and merchant can use third-party services.

Payment, deliveries, market places, marketing and tax calculation - for many applications, specialised services are available that have to be integrated into the platform at various locations.
In all of these areas new startup companies are founded that offer new services.
At the same time, also existing companies expand their service portfolio in order to not lose the connection in the dynamic e-commerce market.
These circumstances keep us busy not only in integrating new services periodically but also by maintaining the existing integrations.

If companies expand abroad, as is the case at ePages, it might be required to include additional services, to being attractive for the merchants in that specific country.
We integrated e.g. USPS and FedEx, since it would not make any sense to enter the US market without an integration of these common US shipping agents.

## Third-party libraries vs Third-party web services

Today's software is mostly based on third-party components, as there are already proven solutions in place that can be easily reused.
Furthermore, these projects are supported by great communities that continuously develop the software and often are absolute experts in this respective field.

However, with regards to third-party components we have to distinguish between third-party libraries and third-party web services.
Third-party libraries are integrated directly into the code base and remain unchanged until a new library version is included.

Working with third-party web services is more complex.
Even if a third-party web service, other than a third-party library, does not directly expand the code base, one must never forget:
By integrating a third-party service, this service will be part of your software.
The software will be expanded by functionality that is dependent on the availability of the third-party web service and acts as expected.
This fact puts special demands on the developers.

## The challenge

Usually the only things we know about the third-party web service is the endpoint URL and a more or less helpful documentation.
The problem is, that not only the API itself, but also both the endpoint and the documentation, can change every time.
You will only notice the change if something does not work anymore.
Sometimes an SDK exists for the API that should facilitate working with it.
But sometimes the SDK does not support the latest API version or the required programming language is not available.

Often the documentation was only produced in the national language of the API developers, making it impossible to understand the content.
The result is that integration problems cannot be fixed by our developers in Barcelona if the documentation is e.g. only available in German.

## The approach

Ideally, we are in direct contact with the developers of the respective third-party to clarify any questions or concerns.
Unfortunately, that is not always the case.
In this case we have to find out by ourselves how the web service works using the trial-and-error method or reverse engineering.

When working with a SOAP API, the WSDL-file that describes the service, provides many helpful bits of information.
Using a tool such as SoapUI, such a file can be analysed easily.
Even test requests can be sent via the SoapUI.

For such tests, the third-party provides special test accounts.
Unfortunately, these are sometimes only valid for a limited period of time.
This is only then noticed, if the account is required again, e.g. if after some time problems with an integration arise that have to be fixed on short notice.

To test our integrations we are writing Unit tests as well as integration and Selenium tests.
By carrying out these tests we are alerted to these problems at an early stage.

Some companies even operate special test platforms with a separate endpoint.
What sounds like a very developer-friendly offer, has a major disadvantage: doing the tests on one system and using a different system for production.
Ideally, the test system should act exactly as the live-system, but that is not always the case.
This is especially annoying if after the rollout customers report problems that did not arise on the test platform.

## The conclusion

All in all one can say that third-party integrations are challenging for developers.
But using suitable tools and a high test coverage can definitely help to master these challenges.
Go for it!

A special thanks to our technology partners for informing us beforehand when they plan to make changes.
