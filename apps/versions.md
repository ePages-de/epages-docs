---
layout: page
key: apps-version
title: API version
---

By default, all requests receive the **v1** version of the API.
We encourage you to explicitly request **v1** via the [`Accept` header](page:apps-media-type), e.g.

{% highlight text %}
Accept: application/vnd.epages.v1+json
{% endhighlight %}

or

{% highlight text %}
Accept: application/vnd.epages.v1+csv
{% endhighlight %}
