---
layout: post
title: "Challenges of integrating third-parties"
date: "2015-07-16 04:20:17"
icon: cloud
tags: integration third-party API
categories: tech-stories
authors: ["Ulf B."]
---

Third-party applications are an important part of the service that ePages offers.
As our applications are built on an internal application platform, ePages developers are highly dependent on third-party APIs.
Read further, why it is not the easiest thing to integrate third-parties and how we tackle this.

# The use case

If a customer buys something, he could choose e.g. PayPal as payment method or DHL as delivery method.
The customer could also obtain an insurance with Trusted Shops.
So a checkout alone can easily have three third-party dependencies.
The merchant, in turn, receives information via server-sided callbacks, if an order has been already paid.
He can generate shipping labels via the web service of a third-party shipping method or synchronise his online shop with ERP-software.

# The services

Payment, deliveries, market places, marketing or tax calculation - for many applications, specialised services are available that have to be integrated into the platform at various locations.
In every of these areas new startup companies are founded that offer new services.
At the same time also existing companies expand their service portfolio in order not to lose the connection in the dynamic e-commerce market.

If companies expand abroad, as it is the case at ePages, it might be required to include additional services, to being attractive for the merchants in that specific country.
In order to being able entering the US market for example, we integrated USPS and FedEx. Not being connected with the most important US shipping agents would not make any sense.

# Third-party libraries vs Third-party APIs

Today's software is mostly based on third-party components, as there are already proven solutions in place that can be easily reused.
Furthermore, these project are supported by great communities that continuously develop the software and often are absolute experts in this respective field.

However, with regards to third-party components we have to distinguish between third-party library and third-party API (web service).
Third-party libraries are integrated directly into the code base and remain unchanged until consciously a new library version will be included.
Working with third-party APIs is more complex.
Even if a third-party API, other than a third-party library, is not directly expands the code base, one must never forget:
By integrating a third-party service, this service will be part of the own software.
The software will be expanded by functionality that is dependent on the availability of the third-party API and acts as expected.
This fact puts special demands on the developers.

# The challenge

Mostly one knows only the endpoint of the third-party API and only a more or less useful documentation is available.
The problem is, that both, the endpoint and the documentation, can change every time. You will only notice the change, if something does not work anymore.
Sometimes an SDK exists for the API that should facilitate working with it.
But in most of the cases the SDK does not support the latest API version or the required programming language is not available.

Often the documentation was only produced in the national language of the API developers making it impossible to understand the content.
The result is that integration problems cannot be fixed by our developers in Barcelona if the documentation is e.g. only available in German.

# The approach

Ideally, we are in direct contact with the developers of the respective third-party to clarify any questions or concerns.
Unfortunately, that is not always the case and we have to find it out by ourselves with the trial-and-error method or reverse engineering.

When working with a SOAP API, the WSDL-file that describes the service, provides many helpful information.
Using a tool such as SoapUI, such a file can be analysed easily.
Even test requests can be sent via the SoapUI.

For such tests, the third-party provides special test accounts.
Unfortunately, these are sometimes only valid for a limited period of time.
This is only then noticed, if the account is required again, e.g. if after some time problems with an integration arise that have to be fixed on short notice. This could have been cause by an API change.

To test our integrations we are writing Unit tests as well as integration and Selenium tests.
By carrying out these test we are alerted to these problems already at an early stage.

Some companies even operate special test platforms with a separate endpoint.
What sounds like a very depeloper-friendly offer, has a major disadvantage: doing the tests on one system and using a different system for production.
Ideally, the test system should act exactly as the live-system, but that is not always the case.
This is especially annoying if after the rollout customers report problems that did not arise on the test platform.

# The conclusion

All in all one can say that third-party integrations are challenging for developers. But using suitable tools and a high test coverage can definitely help to master these challenges. Go for it!
