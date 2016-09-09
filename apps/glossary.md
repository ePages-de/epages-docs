---
layout: page
key: apps-glossary
title: Glossary
categories: ['a','c','h','j','m','o','r','u']
---

<div class="btn-group" role="group">
 {% for letter in page.categories %}
   <button type="button" class="btn btn-default"><a href="#{{ letter }}">{{ letter | upcase }}</a></button>
 {% endfor %}
</div>

## A

### Access Token
The credential authorising an app developer to access the ePages API and act on behalf of the merchant.
An application needs to request an access token as part of the OAuth2 flow to access the ePages resources.

### API (Application Programming Interface)
A particular set of code and specifications that software programs can follow to communicate with each other.
It serves as an interface between different software programs and facilitates their interaction.
The API allows programmers to use predefined functions to interact with the operating system, instead of writing them from scratch.

### Application Callback URL
After having confirmed the installation of an application in his store, the merchant will be redirected to this URL, i.e. the URL of the application.

### API call limit
In order to control the use of the ePages API, ePages sets a limit on how many times the API can be called in an hour.

### Authentication
The process of proving your identity to a system.

## C

### Client ID
A randomly generated, but not secret, ID that is the unique identifier for an application.

### Client Secret
A randomly generated, secret string, that is used in combination with the Client ID to get an access token during the authorisation process.

## H

### HTTPS (Hypertext Transfer Protocol Secure)
A communication protocol in the World Wide Web to securely transfer data.
It is based on the HTTP protocol, but additionally codes the data via SSL/TLS. ePages uses HTTPS for exchanging resource representations between client (application) and ePages API.

### HTTPS request
A message sent from the client (application) to the API using HTTPS.
The request consists of an initial line that specifies an HTTP method such as `GET` or `POST`, the path to the requested resource and the version of HTTP to use.
It can also provide additional information (metadata) about the request and optionally, a message body that provides input data for the request.

### HTTPS response
A message sent by the ePages API in response to an HTTPS request sent from the client.
The response consists of a response status code that indicates a successful or failed request.
One or more header lines can provide additional information (metadata) on the response and optionally, a message body that provides data returned in response to the request.

### HTTP response code
A response code will be send from a server as a response to every HTTP request.
The server communicates to the client if the request has been successful or not.

## J

### JSON
JavaScript Object Notation.
A compact data-interchange format to exchange data between applications. Read here for further details on [JSON](http://json.org).

## M

### Media type
A standard identifier to indicate the representation of data.
A media type consists of a type, subtype and zero or more optional parameters, e.g. for `application/json`, `application` is the type and `json` the subtype.

## O

### OAuth 2.0
With OAuth being an open standard for authorisation, the OAuth 2.0 is the next evolution of the OAuth protocol.
It focuses on client developer simplicity while providing specific authorisation flows for web or desktop applications or mobile phones.

## R

### Resource
The fundamental concept in any RESTful API. An access point for functionality of a REST web service.
Through resources, all functions and features of the API can be accessed via the HTTP request methods `GET`, `POST`, `PUT` and `DELETE`.

### REST (Representational State Transfer)
A software architecture style consisting of guidelines and best practices for creating scalable web services.
It is a coordinated set of constraints applied to the design of components in a distributed hypermedia system that can lead to a more performant and maintainable software architecture.

## U

### URI (Uniform Resource Identifier)
A string of characters used to identify the name of a resource.
This identification enables the interaction with representations of the resource over a network using specific protocols.

### User agent
A software agent that is acting on behalf of a user.
The user agent must always be set to make sure an API request can be processed properly.
That helps filtering out clients that do not send a user agent string and might be ill behaved scripts or unwanted users that cause a lot of load on the servers.

### UTF-8
**U** niversal Character Set + **T** ransformation **F** ormat - **8** bit is a character encoding capable of encoding all code points of Unicode/ISO-10646 (UCS).
