---
layout: page
key: 1and1-response-codes
title: Response codes
---

The API uses HTTP response codes to indicate success or failure of a request. That means, the 2xx range indicates success; the 4xx range indicates validation errors or problems with the provided parameters, whereas the 5xx range indicates errors on our side.

{% callout info Exceptions confirm the rule... %}
Generally, you can expect a JSON response, when making an API call. However, due to internal technical reasons, in the 4xx and 5xx range HTML responses can occur, see [the 4xx example response](page:1and1-response-codes#example-response-1).
{% endcallout %}

# Responses in the 2xx range

| Code      | Text      | Description    |
|---------------|---------------| -------|
| 200       | OK                | This is the standard response for a successful HTTP request.

## Example response

{% highlight text %}
HTTP/1.1 200 OK
Content-Length: 45
Content-Type: application/json
Date: Mon, 23 Feb 2015 10:51:33 GMT
Server: Jetty(9.2.7.v20150116)
X-epages-Media-Type: application/vnd.epages.v1+json
{% endhighlight %}
{% highlight json %}
{
    "default": "en_GB",
    "items": [
        "en_GB",
        "de_DE"
    ]
}
{% endhighlight %}

# Responses in the 4xx range

| Code      | Text      | Description    |
|---------------|---------------| -------|
| 404      | Not&nbsp;Found     | The requested shop could not be found, but may be available in future, e.g. a shopID has been requested, that is not available.
| 406      | Not&nbsp;Acceptable| Not all required parameters have been transferred or incorrect parameters have been transferred.
| 409      | Conflict  | The request could not be completed due to a conflict with the current state of the resource, e.g. no need to change the shop with the given shopID or the shop has a strict lock.

## Example response

{% highlight text %}
HTTP/1.1 404 Not Found
Content-Length: 45
Content-Type: text/html; charset0ISO-8859-1
Date: Mon, 23 Feb 2015 11:18:38 GMT
Server: Jetty(9.2.7.v20150116)
{% endhighlight %}
{% highlight html %}
to be defined by Consulting
{% endhighlight %}

# Responses in the 5xx range

| Code      | Text      | Description    |
|---------------|---------------| -------|
| 503       | Service&nbsp;Unavailable | An exception error occurred, e.g. the server is unavailable. Generally, this is only a temporary state.

## Example response

{% highlight text %}
HTTP/1.1 503 Service Unavailable
Content-Length: 45
Content-Type: text/html; charset0ISO-8859-1
Date: Mon, 23 Feb 2015 11:18:38 GMT
Server: Jetty(9.2.7.v20150116)
{% endhighlight %}
{% highlight json %}
to be defined by Consulting
{% endhighlight %}
