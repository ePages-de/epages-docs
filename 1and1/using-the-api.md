---
layout: page
key: 1and1-using-the-api
title: Using the API
---

# URL schema

All communication will be done via this domain: https://shopadministration.1und1.eu. The mapping between shopID and shard will be realised by ePages via a lookup table.

# Versioning

Versioning will be done via a field in the header, i.e. in the request header includes the version. The server then responds with the respective version whereas the response header includes the version as well.

# Authentication

As we only deal with internal communication, authentication will be done via Basic Auth. A special resource provides one or more tokens to be used for authentication purpose. This has to be included in the request headers.

{% callout info Note: %}
The considered methods use a DIY independent authentication.
{% endcallout %}

# Communication

* Requests to the API can only be made using HTTPS.
* All data is sent and received in JSON.

JSON example:

{% highlight json %}
{
  "data": {
          "parameter1": "Value1",
          "parameter2": "Value2",
          "parameter3": "Value3"
  },
  "meta": {
          "url":
          "https://shopadministration.1und1.eu/api/shops/",
          "guid": "51CB1D95-BD6A-73C0-6A5A-AC140829E020",
          "class": "Shop"
  },
  "errors": [
          {
                "reason": "AUTH_MISSING",
                "message": "authentication missing, data incomplete",
                "guid": "51E3D0CC-13E4-2674-CA05-A9FE9BFA6030"
          }
      ]
}
{% endhighlight %}
