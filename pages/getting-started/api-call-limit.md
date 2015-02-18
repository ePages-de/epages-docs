---
layout: page
key: api-call-limits
title: API call limit
---

{% callout danger Pending %}
  to be decided/clarified!

  softlaunch: 100 per day  (eCom 1000) or 400 per day (eCom) 5000, if that is realistic has to be tested.
  The developer has to stick to this specification but it's not active yet.
{% endcallout %}

API call limit means that the rate at which requests to the API are called are limited and defined by ePages.
The API call limit is applied to... `TODO`

Depending on the ePages shop type, an API auth token can limited to 100 API calls or 400 API calls per day, respectively. Once, the limit is exceeded, the call will return HTTP status XYZ and a message telling you that you've been limited.

The rate limit usage is returned in the response headers from each request, e.g.

{% highlight text %}
HTTP 1.1 200 OK
RateLimit-Limit: 100
RateLimit-Remaining: 93
Rate-Limit-Reset: 1400009878
{% endhighlight %}

RateLimit-Limit: number of calls you are allowed per day

RateLimit-Remaining: number of calls you can make before hitting the limit

RateLimit-Reset: next time the limit will be updated.
