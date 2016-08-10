---
layout: post
title: "approach of sageone connector as a deep integrated app"
date: "2016-08-29 07:00:28"
image: blog-header/sageone-deep-app.jpg
categories: tech-stories
authors: ["Mats"]
---

In the third-party team our recent and still ongoing project was the implementation of an application serving as a connector between the epages e-commerce system and Sage One. Sage One is an ERP solution. The main purpose of this connector-application is to transfer the orders being created in the epages shop into the sageone accounting application.

Our initial plan was to build a standalone application using the epages REST API to obtain the order information that have to be transferred to sageone. Soon the requirement of a deeper integration into the epages back office arose. So we needed to find a different approach. In our recent payment integration PayPal Plus introduced a “thin layer”-approach. Whats meant by this is that we used a Java application as a layer between the epages Perl code and the PayPal API. In this approach we used the Java layer as a plain communication adapter in order to be able to use the PayPal Java-SDK. Understanding the Java layer as a plain communication adapter we were strictly avoiding any business logic there. The Java layer is only transfering information between the epages Perl core and the Paypal API.

{% image blog/paypalplus-approach.jpg %}

The main reason to keep all the business logic in the epages Perl core was that PayPal Plus as a payment required a deep integration in the checkout-process. We also wanted to avoid spreading business logic over two systems.

For the Sage One integration we don’t rely on the checkout. Therefore we choose to go with a slightly different approach. This time we were shifting the entire business logic to the Java layer. The Perl part is serving as the view, only containing view related logic. As an error handling strategy we decided to use an approach of status reflection. The Java layer exposes the status of each individual shop and order through a internal REST API. This way the View-layer can obtain the status, to provide feedback on the outcome of an certain operation.

{% image blog/sageone-approach.jpg %}

The shift of business logic to Java gave us big advantages. Especially in terms of coding speed, test-coverage and maintainability, since the refactoring facilities in Java are way superior compared to Perl. This approach also gave us a clear separation of concerns, assigning each application layer a specific task. The Java layer is responsible for all business logic, holding all controller and model code. It is exposing the status of each shop and order through REST. The Perl layer is only responsible for view related functionality. It is using the REST endpoints of the Java layer in order to obtain status information or trigger synchronisation procedures.

The downside of this approach is that we have an additional dependency in our solution. This makes the entire solution a bit more complex, especially in terms of debugging.
The abstractation of the business logic to Java requiers also some special solutions in order to achieve certain functionality in the view that would be classified as ‘basic’ in a Perl standalone cartridge. The reason is that we are not able to use a lot of the Perl core functionality because our business data is stored in the Java-layer.
