---
layout: page
key: apps-getting-started
title: Getting started
---

# Introduction

The ePages API provides developers the interface to create awesome apps or single shop connections. It is designed to give developers a convenient way to access data contained within ePages stores. With a standard interface to store data, it is very simple to create third party applications that can communicate with our merchant's stores.

Our highest claim is to ensure you're having a good time developing your app. That's why we're trying to make the API understandable for both developers and humans.

Let's make things less complicated: It's very easy to build and test applications, since the API is based on RESTful principles. The API uses the following standard HTTP verbs to make use of the required store data:

  * `GET` (request)
  * `POST` (create)
  * `PUT` (modify)
  * `DELETE` (delete)

# JSON

The API supports the JSON standard, which basically is the universal connector for data on the internet, and makes developers lives way easier, when using our RESTful API.

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

{% image example_consumer_key_secret.png 50% %}
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

Requests to the API can only be made using HTTPS to grant access to authorised users only.
All URLs start with https://xyz.com/api/. If we change he API in backward-incompatible ways, we'll add a version marker and maintain stable support for the old URLs.

# Error handling

The API uses HTTP response codes to indicate success or failure of a request. That means, the 2xx range indicates success, the 4xx range indicates validation errors or problems with the provided parameters (e.g. missing required parameters) and the 5xx range indicates errors on our side.
These are the typical responses that can occur:

* 200 OK - standard response for a successful HTTP request.
* 201 Created - request has been fulfilled and resulted in a new resource being created.

A typical HTTP 2xx response could look like this:

{% highlight json %}
{
    "name": "Contact information",
    "title": null,
    "navigationCaption": "Contact information",
    "shortDescription": "You adapt this text via the preview or data sheet view under the &quot;Content/Categories&quot; menu item of your Administration.",
    "description": "<p>Account number: ...<p/>",
    "company": "",
    "contactPerson": "John Doe",
    "contactPersonJobTitle": null,
    "address": "Pilatuspool 2<br />20355 Hamburg<br />Germany",
    "phone": null,
    "fax": null,
    "email": "john.doe@epages.com"
}
{% endhighlight %}

* 400 Bad Request - server cannot or will not process the request due to something that is perceived to be a client error
* 404 Not Found - requested resource could not be found but may be available in future

A typical HTTP 4xx response could look like this:

{% highlight json %}
{
  "message": "Bad Request",
  "status": 400
}
{% endhighlight %}

* 500 Internal Server Error -
* 503 Service Unavailable -

A typical HTTP 5xx response could look like this:

{% highlight json %}
{
  "message": "Internal Server Error",
  "status": 500
}
{% endhighlight %}

# Call limits


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


**Any questions?**

Find answers to the common questions in our [FAQ section](page:faq). More complicated topic? We get you in touch with our support. Just send us your request and we will get back to you.

# Here we go!

Done! You're all set! It's that simple! Get straight down to the nitty-gritty and [create your app](page:apps-develop-app#create-an-app).
