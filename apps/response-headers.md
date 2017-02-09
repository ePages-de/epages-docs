---
layout: page
key: apps-response-headers
title: Response headers
---

A successfully sent request (see [Request headers](page:apps-request-headers)) is followed by an HTTP response.
The below table contains the response headers sent by the server.

| Header      | Value      | Description    | Example   |
|---------------|---------------| -------|----------|
| Content&#8209;Length      | Integer | The length of the response body in 8-bit bytes. | `45`   |
| Content-Type      | String | The media type of this content. | `application/json`  |
| Date      | String, RFC 2822 date| The date and time the response was sent. | `Mon, 23 Feb 2015 11:18:38 GMT`   |
| Server    | String | The name of the server. | `Jetty(9.2.7.v20150116)`   |
| X-epages-Cart-Token | String | The token that will be issued when a cart is created. To be included in any request to a newly created cart, otherwise a 403 error is returned. | `UmFuZG9tSVbYnncIV4kUCiM0` |
| X-epages-Media&#8209;Type  | String | The media type of the requested file. | `application/vnd.epages.v1+json`   |
| X-RateLimit-Limit    | Integer | The number of calls allowed per hour. | `6000`   |
| X-RateLimit-Remaining    | Integer | The number of calls that can be made before hitting the limit. | `5998`   |
| X-RateLimit-Reset    | String, ISO 8601 | The next time the quota will be reset. | `2015-02-20T13:14:34.611Z`   |
