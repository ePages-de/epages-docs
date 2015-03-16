---
layout: page
key: apps-response-headers
title: Response headers
---

| Header      | Value      | Description    | Example   |
|---------------|---------------| -------|----------|
| Content&#8209;Length      |  | The length of the response body in 8-bit bytes. | `45`   |
| Content-Type      | `application/json`, `text/html; charset0ISO-8859-1` | The media type of this content. | `application/json`  |
| Date      | ISO 8601 format | The date and time the response was sent. | `Mon, 23 Feb 2015 11:18:38 GMT`   |
| Server    |  | The name of the server. | `Jetty(9.2.7.v20150116)`   |
| X-epages-Media&#8209;Type  | `application/json`, `text/html` | The media type of the requested file. | `application/vnd.epages.v1+json`   |
| X-RateLimit-Limit    | Integer | The number of calls allowed per hour. | `6000`   |
| X-RateLimit-Remaining    | Integer | The number of calls that can be made before hitting the limit. | `5998`   |
| X-RateLimit-Reset    | Integer | The next time the quota will be reset. | `2015-02-20T13:14:34.611Z`   |
