---
layout: page
key: api-getting-started
title: Getting started
---

# Introduction

## The ePages API
The ePages API provides developers the interface to create awesome apps or single shop connections. It is designed to give developers a convenient way to access data contained within ePages stores. With a standard interface to store data, it is very simple to create third party applications that can communicate with our merchant's stores.

Our highest claim is to ensure you're having a good time developing your app. That's why we're trying to make the API understandable for both coders and humans.

Let's make things less complicated: It's very easy to build and test applications, since the API is based on RESTful principles. The API uses the following standard HTTP verbs to make use of the required store data:

  * `GET ` (request)
  * `POST` (create)
  * `PUT` (modify)
  * `DELETE` (delete)

And what next? The API supports the JSON standard, which basically is the universal connector for data on the internet, and makes coders lives way easier, when using our RESTful API.
Requests to the API can only be made using HTTPS to grant access to authorised users only.

## The API documentation
Starting with the ePages API is simple. You've made it already through the short intro. Would you like to check out the [Use cases](doc:use-cases) now?

Or you can go directly for the GETTING STARTED section that provides all the necessary information on [registering](doc:registration) with our platform. Find out more about the [OAuth authentication process](doc:oauth) and the [API call limit](doc:api-call-limit).

The APPS section will get you on the road to develop your app. [Create an app](doc:create-an-app) and [submit an app](doc:submit-an-app) in no time!

The reference material for an API is an intrinsic part of any API - without it, the API is unusable. That's why every important aspect is explicitly stated in our API REFERENCE section [here](doc:resources).

## Any questions?
Find answers to the common questions in our FAQ section. More complicated topic? We get you in touch with our support. Just send us your request and we will get back to you.

# Authentication

placeholder

# Making a request

placeholder

# JSON

placeholder

# Error handling

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



Developing the ePages API is an ongoing process. Please let us know if you're missing a resource that you want to be listed here.


