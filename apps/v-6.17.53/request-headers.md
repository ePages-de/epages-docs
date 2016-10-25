---
layout: page
key: apps-request-headers-v-6.17.53
title: Request headers
---

Request headers give basic information on the request to a server.
The following table contains the required request headers that allow you to pass information on the request and the client itself to the server.

| Header      | Value      | Description    | Example   |
|---------------|---------------| -------|----------|
| Accept      | String | The media&nbsp;type acceptable for the response. | `application/vnd.epages.v1+json`   |
| Authorization      | String | The credentials for accessing the API. | `Bearer 4HZ9hriF6J3GOnd10JbFzdVehycOvAZf`|
| Content-Type      | String | The media&nbsp;type of the body of the request. Required for `put` and `post` requests. | `application/json`   |
| User-Agent      | String | The software or agent that accesses the API. | `statistics app`|
