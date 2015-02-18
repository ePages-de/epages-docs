---
layout: page
key: api-intro
title: Introduction
---

Developing the ePages API is an ongoing process. Please let us know if you're missing a resource that you want to be listed here.

# Errors

The API uses HTTP response codes to indicate success or failure of a request. That means, the 2xx range indicates success, the 4xx range indicates validation errors or problems with the provided parameters (e.g. missing required parameters) and the 5xx range indicates errors on our side.

A typical HTTP 2xx response could look like this:

{% highlight json %}
{
}
{% endhighlight %}

A typical HTTP 4xx response could look like this:

{% highlight json %}
{
  "message": "Bad Request",
  "status": 400
}
{% endhighlight %}

A typical HTTP 5xx response could look like this:

{% highlight json %}
{
  "message": "Internal Server Error",
  "status": 500
}
{% endhighlight %}
