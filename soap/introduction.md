---
layout: page
key: soap-introduction
title: Introduction
---

# Easy-to-consume SOAP API

The ePages SOAP API is easy to consume.
Each web service has a unique identity.
Its address is defined by a URI and is often called an endpoint.
For our web service description we use WSDL (Web Services Definition Language) and the web service itself can be listed and discovered in a UDDI (Universal Description Discovery and Integration) registry.

# Data exchange

{% image soap-data-exchange.png %}

# Extensibility

Web services represent a very flexible and extensible interface to other systems.
With the help of simple instruments based upon a BaseService, ePages Flex and Enterprise customers can create their own web service applications without impacting on the existing standard web services.

# Web service methods

Our web services are invoked via HTTP and provide the standard methods to manage the business objects over their life times such as:

| Method        | Description   |
|---------------|---------------|
| create()      | Adds one or more new items to a shop.        |
| find()        | Finds existing items in a shop.              |
| getInfo()     | Retrieves a list of items of a shop.         |
| exists()      | Checks if one or more specific items exist in a shop. |
| update()      | Updates one or more existing items in a shop.|
| delete()      | Deletes one or more items from a shop.       |

Some complex web services however, have additional or different methods.
Read further in the [web service directory](page:soap-directory) or directly check the [resources](page:soap-api).

# Support

Find answers to the common questions in our [FAQ](page:soap-faq).
