---
layout: page
key: 1and1-intro
title: Introduction
---

# Requirement

The ePages application with its Simple Provisioning Web Service provides a standard interface for the shop management, also referred to as provisioning. At present, the client is reorganising the customer portal and the order process. In future, both the control and the provisioning of the shops should be done via the REST API. The communication can be synchronous or asynchronous depending on the specific  case of application.

Additional requirements:

* For the method **Create** the domain of the business unit (store) has to be returned, in which the shop as been created.
* Simple versioninig of the REST API to simplify changing already existing methods.

# Solution

To provide the REST API a servlet will be developed, which accepts the respective requests and calls the ePages web service. This documentation uses **TestShop** as shopID. This is freely changeable, e.g. via a GUID.
