---
layout: page
key: apps-api-call-limit
title: API call limit
---

Requests to the API are limited to 6000 calls per hour per token.
The limit applies to all available resources.
Once the limit is exceeded, the request will be rejected.
HTTP status `429 - Too many requests` will be returned and a message telling you that you've been limited, see also [Response codes](page:apps-response-codes).

The rate limit usage is returned in the [response headers](page:apps-response-headers) from each request, e.g.

{% highlight text %}
X-RateLimit-Limit: 6000
X-RateLimit-Remaining: 5999
X-Rate-Limit-Reset: 2015-02-20T13:14:34.611Z
{% endhighlight %}

X-RateLimit-Limit: number of calls you are allowed per hour

X-RateLimit-Remaining: number of calls you can make before hitting the limit

X-RateLimit-Reset: next time the quota will be reset.
