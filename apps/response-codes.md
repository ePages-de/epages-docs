---
layout: page
key: apps-response-codes
title: Response codes
---

The API uses HTTP response codes to indicate success or failure of a request.
That means, the 2xx range indicates success; the 4xx range indicates validation errors or problems with the provided parameters, whereas the 5xx range indicates errors on our side.

{% callout info Exceptions confirm the rule... %}
Generally, you can expect a JSON response, when making an API call.
However, due to internal technical reasons, in the 4xx and 5xx range HTML responses can occur, see [the 4xx example response](page:apps-response-codes#example-response-1).
{% endcallout %}

## Responses in the 2xx range

| Code      | Text      | Description    |
|---------------|---------------| -------|
| 200       | OK                | This is the standard response for a successful HTTP request.
| 201       | Created           | The request has been fulfilled and resulted in a new resource being created, e.g a cart.
| 204       | No&nbsp;Content   | The server successfully processed the request, but is not returning any content. Typically used as a response to a successful `DELETE` request.

### Example response

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

## Responses in the 4xx range

| Code      | Text      | Description    |
|---------------|---------------| -------|
| 400       | Bad&nbsp;Request  | The server cannot or will not process the request due to something that is perceived to be a client error, e.g. a non-number is sent to the server, but a number was expected.
| 403       | Forbidden         | The request was valid, but the server is refusing to respond to it, e.g. the request is not signed with OAuth, an incorrect signature is used or the client is refused because it is lacking permissions.
| 404      | Not&nbsp;Found     | The requested resource or item could not be found, but may be available in future, e.g. a product has been requested, that is not available.
| 405      | Method&nbsp;Not&nbsp;Allowed | A request was made of a resource using a request method not supported by that resource, e.g. using a `POST` on a resource that requires a `GET`.
| 406      | Not&nbsp;Acceptable| The content negotiation between client and server failed. As ePages uses the Accept header to specify the API version, it requires the client to send exactly this header for the respective version of the REST API. So for the currently existing version v1, this is `Accept: application/vnd.epages.v1+json`. The server response for the content-type is always `application/json` unless stated otherwise.
| 409      | Conflict | The request could not be processed because of a conflict in the request, e.g. using a `PATCH` on an order, that is in edit mode.
| 410      | Gone | The resource requested is no longer available and will not be available again, e.g. when a cart became an order.
| 429      | Too Many Requests  | Too many requests have been sent to the API in a given amount of time. The API call limit has been exceeded, see also [API call limit](page:apps-api-call-limit).

### Example response

{% highlight text %}
HTTP/1.1 400 Bad Request
Content-Length: 45
Content-Type: text/html; charset0ISO-8859-1
Date: Mon, 23 Feb 2015 11:18:38 GMT
Server: Jetty(9.2.7.v20150116)
{% endhighlight %}
{% highlight html %}
<head>
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1"/>
<title>Error 400 </title>
</head>
<body>
<h2>HTTP ERROR: 400</h2>
<p>Problem accessing /rs/shops/DemoShop/legal/rights-of-withdrawal. Reason:
<pre>    Bad Request</pre></p>
<hr /><i><small>Powered by Jetty://</small></i>
</body>
</html>
{% endhighlight %}

## Responses in the 5xx range

| Code      | Text      | Description    |
|---------------|---------------| -------|
| 500       | Internal&nbsp;Server&nbsp;Error | A generic error message that is given, when an unexpected condition was encountered and a no more specific message is suitable.
| 502       | Bad&nbsp;Gateway | The server was acting as a gateway or proxy and received an invalid response from the upstream server, e.g. internal ePages services not available. Generally, this is only a temporary state.
| 503       | Service&nbsp;Unavailable | The server is currently unavailable, e.g. the REST API is unavailable. Generally, this is only a temporary state.

### Example response

{% highlight text %}
HTTP/1.1 500 Internal Server Error
Content-Length: 45
Content-Type: text/html; charset0ISO-8859-1
Date: Mon, 23 Feb 2015 11:18:38 GMT
Server: Jetty(9.2.7.v20150116)
{% endhighlight %}
{% highlight json %}
{
    "message": "Internal Server Error, Request: GET /rs/shops/DemoShop/locales",
    "status": "500"
}
{% endhighlight %}
