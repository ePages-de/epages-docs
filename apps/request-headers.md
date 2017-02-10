---
layout: page
key: apps-request-headers
title: Request headers
---

Request headers give basic information on the request to a server.
The following table contains the required request headers that allow you to pass information on the request and the client itself to the server.

| Header      | Value      | Description    | Example   |
|---------------|---------------| -------|----------|
| Accept      | String | The media&nbsp;type acceptable for the response. | `application/vnd.epages.v1+json`   |
| Authorization      | String | The credentials for accessing the API. | `Bearer 4HZ9hriF6J3GOnd10JbFzdVehycOvAZf`|
| Content-Type      | String | The media&nbsp;type of the body of the request. Required for `PUT` and `POST` requests. | `application/json`   |
| X-epages-Cart-Token | String | The token that will be issued when a cart is created. To be included in any request to a newly created cart, otherwise a 403 error is returned. | `UmFuZG9tSVbYnncIV4kUCiM0` |
| User-Agent      | String | The software or agent that accesses the API. | `statistics app`|
