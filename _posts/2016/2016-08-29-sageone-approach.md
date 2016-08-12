---
layout: post
title: "How we connected Sage One with ePages"
date: "2016-08-12 14:00:28"
image: blog-header/bridge.jpg
categories: tech-stories
authors: ["Mats"]
---

In my team the recent and still ongoing project is the implementation of an application serving as a connector between the ePages e-commerce solution and [Sage One](https://developer.sageone.com).
Sage One is an ERP solution.
The main purpose of this connector-application is to transfer the orders being created in the ePages shop into the Sage One accounting application.

## The initial plan

Our initial plan was to build a standalone application using the [ePages REST API](https://developer.epages.com/apps) to obtain the order information that have to be transferred to Sage One.
Soon the requirement of a deeper integration into the ePages administration area came up.
So we had to find a different approach.
In our recent payment integration PayPal Plus introduced a “thin layer”-approach.
That means, we used a Java application as a layer between the ePages Perl code and the [PayPal API](https://developer.paypal.com).
In this approach we used the Java layer as a plain communication adapter in order to be able to use the PayPal Java SDK. Understanding the Java layer as a plain communication adapter we were strictly avoiding any business logic there.
The Java layer is only transferring information between the ePages Perl core and the Paypal API.

{% image blog/paypalplus-approach.jpg %}

The main reason to keep all the business logic in the ePages Perl core was that PayPal Plus as a payment required a deep integration in the checkout process.
We also wanted to avoid spreading business logic over two systems.

## The approach

For the Sage One connector there is no need for an integration into the checkout process.
Therefore, we chose a slightly different approach.
This time we were shifting the entire business logic to the Java layer.
The Perl part serves as the view, only containing view-related logic.
As an error handling strategy we decided to use an approach of status reflection.
The Java layer exposes the status of each individual shop and order through an internal REST API.
This way the view-layer can obtain the status to provide feedback on the outcome of a certain operation.

{% image blog/sageone-approach.jpg %}

Shifting the business logic to Java had big advantages.
Especially in terms of coding speed, test-coverage and maintainability, since the refactoring facilities in Java are way superior compared to Perl.
This approach also gave us a clear separation of concerns, assigning each application layer a specific task.
The Java layer is responsible for all business logic, holding all controller and model code.
It exposes the status of each shop and order through REST.
The Perl layer is only responsible for view-related functionality.
It uses the REST endpoints of the Java layer in order to obtain status information or trigger synchronization procedures.

## The other side of the coin

The downside of this approach is that we have an additional dependency in our solution.
This makes the entire solution a bit more complex, especially in terms of debugging.
Abstracting the business logic to Java requires also some special solutions in order to achieve certain functionality that would be classified as ‘basic’ in a Perl standalone cartridge.
The reason is that we are not able to use a lot of the Perl core functionality because our business data is stored in the Java layer.
