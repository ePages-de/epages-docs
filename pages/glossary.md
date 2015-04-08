---
layout: page
key: glossary
title: Glossary
---

# A

## Access Token
A credential that is used for authorising a requester (app developer) to access a resource. It is used as kind of a password to prove that the requester is who it claims to be. An application needs to create an access token for authorisation to access the ePages resources through the API.


## API (Application Programming Interface)
A particular set of code and specifications that software programs can follow to communicate with each other. It serves as an interface between different software programs and facilitates their interaction. The API allows programmers to use predefined functions to interact with the operating system, instead of writing them from scratch.

## Application Callback URL


## Application Notification URL

# C

## Client ID
A randomly generated, but not secret, ID that is the unique identifier for an application.


## Client Secret
A randomly generated, secret string, that is used in combination with the Client ID to get an Access Token during the authorisation process.

# H

## HTTPS (Hypertext Transfer Protocol Secure)
A communication protocol in the World Wide Web to securely transfer data. It is based on the HTTP protocol, but additionally codes the data via SSL/TLS. ePages uses HTTPS for exchanging resource representations between client (application) and ePages API.

## HTTPS request
A message sent from the client (application) to the API using HTTPS. The request consists of an initial line that specifies an HTTP method such as `GET` or `POST`, the path to the requested resource and the version of HTTP to use. It can also provide additional information (meta data) about the request and optionally, a message body that provides input data for the request.

## HTTPS response
A message sent by the ePages API in response to an HTTPS request sent from the client. The response consists of a response status code that indicates a successful or failed request. One or more header lines can provide additional information (meta data) on the response and optionally, a message body that provides data returned in response to the request.

# J

## JSON
JavaScript Object Notation. A compact data-interchange format to exchange data between applications. Read here for further details on [JSON](http://json.org).

# R

## Resource
The fundamental concept in any RESTful API. An object with a type, associated data, relationships to other resources, and a set of methods that operate on it. Only a few standard methods are defined for a resource, as `GET`, `POST`, `PUT` and `DELETE`.

## REST (Representational State Transfer)
A software architecture style consisting of guidelines and best pratices for creating scalable web services. It is a coordinated set of constraints applied to the design of components in a distributed hypermedia system that can lead to a more performant and maintainable software architecture.

# U

## URI (Uniform Resource Identifier)
A string of characters used to identify the name of a resource. This identification enables the interaction with representations of the resource over a network using specific protocols.

