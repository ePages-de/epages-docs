---
layout: page
key: _templates
title: Templates
searchable: false
---

My templates:
[Create an App](page:apps-develop-app#create-an-app)

{% image epages-logo.png %}
This is an image with at most 100% width
{% endimage %}

- title: Analytics Reporting
  url: page:usecases.html#analytics--reporting

Callout - Info

{% callout info Helpful stuff! %}
  If you're eager for more information on how to set up your demo shop, check out our [Online Help](https://www.online-help-center.com/) for merchants.
{% endcallout %}

Callout - Danger

{% callout danger Pending %}
  to be decided/clarified!

  softlaunch: 100 per day  (eCom 1000) or 400 per day (eCom) 5000, if that is realistic has to be tested.
  The developer has to stick to this specification but it's not active yet.
{% endcallout %}

Highlight - Code

{% highlight text %}
HTTP 1.1 200 OK
RateLimit-Limit: 6000
RateLimit-Remaining: 5896
Rate-Limit-Reset: to be defined
{% endhighlight %}

[Product resources](page:api-resources-products)
