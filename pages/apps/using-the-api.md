---
layout: page
key: apps-using-the-api
title: Using the API
---

# RESTful principle

Our highest claim is to ensure you're having a good time developing your app. That's why we're trying to make the API understandable for both developers and humans.

Let's make things less complicated: It's very easy to build and test applications, since the API is based on RESTful principles. The API uses the following standard HTTP verbs to make use of the required store data:

  * `GET` requests resources
  * `POST` creates resources
  * `PUT` modifys resources
  * `DELETE` deletes resources

# Schema

All API access is over HTTPS. All data is sent and received as JSON.

{% highlight text %}
https://rs/Shops/DemoShop/legal/privacy-policy

HTTP 1.1 200 OK
Content-Length: application/json
Date: Tue, 24 Feb 2015 11:30:16 GMT
Server: Jetty(9.2.7.v20150116)
X-ePages-Media-Type: application/vnd.epages.v1+json
X-RateLimit-Limit: 6000
X-RateLimit-Remaining: 5999
X-RateLimit-Reset: 2015-02-24T11:30:16.481Z
{% endhighlight %}

All timestamps are returned in ISO 8601 format:

{% highlight text %}
YYYY-MM-DDTHH:MM:SS.Z
{% endhighlight %}

# Registration

Before you can start coding off you'll need to sign up for the ePages Developer Program. Gain access to all the resources you need to create your app successfully.

{% image https://www.filepicker.io/api/file/CuP4suO0RH6H4BkKT9GI %}
This is how the registration screen looks like.
{% endimage %}

## Sign up for free.

1. Enter your name and email address in the required fields.
2. Agree to the terms and conditions.
3. Check your mailbox for the login details from your registration and create a test shop.

{% callout info Helpful stuff! %}
  If you're eager for more information on how to set up your demo shop, check out our [Online Help](https://www.online-help-center.com/) for merchants.
{% endcallout %}

# OAuth

Your app cannot access the REST API resources without authenticating first. In order to access to the ePages data, your application must be authenticated.
All API calls are authenticated according to the OAuth 2.0 protocol. Fancy more detailed information? Here you go: [OAuth 2.0 protocol](https://tools.ietf.org/html/rfc6749).

Once you have signed up for the developer program and you have created your app successfully, you will be assigned a unique **Consumer key** and **Consumer secret**. Remember these credentials as you will have to integrate them into the configuration files or the actual code of your application.

{% callout danger Important! %}
For your application's own security: DO NOT share your consumer secret with anyone!
{% endcallout %}

The credentials you'll receive might look like this:

{% image example-consumer-key-secret.png 50% %}
Example of OAuth keys
{% endimage %}

# Authorisation

1. Within your test shop backoffice, again choose the tab **Apps**.
2. Choose the field **Private Apps** and click the button **Create app**.
3. Click the button **Test authorisation**. You will be requested to enter the **Application callback URL** and **Application notification URL**.
4. Click the button **Test authorisation** again. You will be forwarded to an external page to complete the authorisation process.
5. Once the test authorisation has been finished successfully, you will be fowarded to

{% callout danger Authorisation to be described %}
  development in progress
{% endcallout %}

# Making an API call

{% callout danger This is a red callout %}
Following content to be discussed with Oli/Alessandro.
{% endcallout %}

Requests to the API can only be made using HTTPS to enable secure, confident and unaltered data transmission and to grant access to authorised users only.
All URLs start with /rs/. If we change the API in backward-incompatible ways, we'll add a version marker and maintain stable support for the old URLs.

# Error handling

The API uses HTTP response codes to indicate success or failure of a request. That means, the 2xx range indicates success, the 4xx range indicates validation errors or problems with the provided parameters whereas the 5xx range indicates errors on our side.

{% callout info Sometimes ... HTML responses... %}
Generally, you can expect a JSON response, when making an API request. Due to internal technial reasons, however, in the 4xx and 5xx range HTML responses can occur, see [the example for the 4xx response](page:apps-using-the-api#a-typical-http-4xx-response-could-look-like-this).
{% endcallout %}

## A typical HTTP 2xx response could look like this:

### Status

200 OK

### Headers

{% highlight text %}
Content-Length: 45
Content-Type: application/json
Date: Mon, 23 Feb 2015 10:51:33 GMT
Server: Jetty(9.2.7.v20150116)
X-epages-Media-Type: application/vnd.epages.v1+json
{% endhighlight %}

### Body

{% highlight json %}
{
    "default": "en_GB",
    "items": [
        "en_GB",
        "de_DE"
    ]
}
{% endhighlight %}

## These are the responses in the 2xx range that can occur, when requesting the ePages API:

### 200: OK

This is the standard response for a successful HTTP request.

### 201: Created

The request has been fulfilled and resulted in a new resource being created, e.g a cart.

### 204: No Content

The server successfully processed the request, but is not returning any content. Typically used as a response to a successful delete request.

## A typical HTTP 4xx response could look like this:

### Status

400 Bad Request

### Headers

{% highlight text %}
Content-Length: 45
Content-Type: text/html; charset0ISO-8859-1
Date: Mon, 23 Feb 2015 11:18:38 GMT
Server: Jetty(9.2.7.v20150116)
{% endhighlight %}

### Body

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

## These are the responses in the 4xx range that can occur, when requesting the ePages API:

### 400: Bad Request

The server cannot or will not process the request due to something that is perceived to be a client error, e.g. a non-number is sent to the server, but a number was expected.

### 403: Forbidden

The request was valid, but the server is refusing to respond to it, e.g. the request is not signed with OAuth, an incorrect signature is used or the client is refused because it is lacking permissions.

### 404: Not Found

The requested resource could not be found, but may be available in future, e.g. a product has been requested, that is not available.

### 405: Method Not Allowed

A request was made of a resource using a request method not supported by that resource, e.g. using a `POST` on a resource that requires a `GET`.

### 406: Not Acceptable

The content negotiation between client and server failed. As ePages uses the Accept header to specify the API version, it requires the client to send exactly this header for the respective version of the REST API. So for the currently existing version v1, this is `Accept: application/vnd.epages.v1+json`.

The server response for the content-type is always `application/json` unless stated otherwise.

### 429: Too Many Requests

Too many requests have been sent to the API in a given amount of time, e.g. the API call limit has been exceeded, see also [API call limit](page:apps-using-the-api#api-call-limit).

## A typical HTTP 5xx response could look like this:

### Status

500 Internal Server Error

### Headers

{% highlight text %}
Content-Length: 45
Content-Type: text/html; charset0ISO-8859-1
Date: Mon, 23 Feb 2015 11:18:38 GMT
Server: Jetty(9.2.7.v20150116)
{% endhighlight %}

### Body

{% highlight json %}
{
    "message": "Internal Server Error, Request: GET /rs/shops/DemoShop/locales",
    "status": "500"
}
{% endhighlight %}

## These are the responses in the 5xx range that can occur, when requesting the ePages API:

### 500: Internal Server Error

A generic error message that is given, when an unexpected condition was encountered and a no more specific message is suitable.

### 502: Bad Gateway

The server was acting as a gateway or proxy and received an invalid response from the upstream server, e.g. internal ePages services not available. Generally, this is only a temporary state.

### 503: Service Unavailable

The server is currently unavailable, e.g. the REST API is unavailable. Generally, this is only a temporary state.

# API call limit

API call limit means that the rate at which requests to the API are called are limited and defined by ePages.

The calls are limited to 6000 API calls per auth token per hour. Once, the limit is exceeded, the call will return HTTP status XYZ and a message telling you that you've been limited.

The rate limit usage is returned in the response headers from each request, e.g.

{% highlight text %}
HTTP 1.1 200 OK
RateLimit-Limit: 6000
RateLimit-Remaining: 5896
Rate-Limit-Reset: to be defined
{% endhighlight %}

RateLimit-Limit: number of calls you are allowed per day

RateLimit-Remaining: number of calls you can make before hitting the limit

RateLimit-Reset: next time the limit will be updated.

# Current version

By default, all requests receive the **v1** version of the API. We encourage you to explicitly request this version via the `Accept` header.

{% highlight text %}
Accept: application/vnd.epages.v1+json
{% endhighlight %}

# Here we go!

Done! You're all set! It's that simple! Get straight down to the nitty-gritty and [create your app](page:apps-develop-app#create-an-app).
