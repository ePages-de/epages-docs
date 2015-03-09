---
layout: page
key: apps-oauth
title: OAuth 2.0
---

Your app cannot read ePages data without authenticating first. In order to access to the resources of the REST API, your application must get permission.
In this section we will help you through this authorisation process.

# Credentials

You already retrieved a `client id` and a `client secret` that are known to both ePages and your application. Visit [get your credentials](page:apps-develop-app#get-your-credentials). Your app uses these credentials for identification during the authorisation process.

# Terminology

Before jumping into the authorisation process, let's look at some terms that will be used for this section.

| Name              | Description                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------|
| **Merchant** | A shop owner giving permission to an **App** to access his shop's data through the REST API. Within the OAuth 2.0. protocol this is referred to as `resource owner`. |
| **ePages&nbsp;API** | The ePages REST API. This is where the **App** can view and modify a shop's data. Within the OAuth 2.0. protocol this is referred to as `service provider`.|
| **App**      | An application that would like to access a shop's data. The **Merchant** must grant permission before the **App** can access any data. Within the OAuth 2.0. protocol this is referred to as `client`. |

# Authorisation process

{% image oauth2-flow.png %}
OAuth 2.0 process
{% endimage %}

## Ask for permission

The merchant will be asked whether he wants to grant the permissions that your app is requesting. This is called **user consent**. During the app development, you have to define roles for that. Currently, the only role that is supported is **Read Products**. ePages displays the user consent as a consent page:

{% image asking-for-permission.png %}
Consent page
{% endimage %}

## Confirm the installation

a) The merchant agrees the consent form by clicking the button **Install** on the consent page.  Your application is returned a `code` as a query string as well as the `shopId` and a `redirectUri` that your app can use to obtain an `accessToken`.

Example:

{% highlight text %}
code: MLaORzWY3SP0BJacq3ULaxcWEt8XxzWX
shopId: DemoShop
redirectUri: http://merchant/epages/DemoShop.admin/?ObjectID=17581&ViewAction=MBO-ViewAppDetails&appID=54f46
{% endhighlight %}

b) If the merchant does not grant permission and clicks the button **Cancel** instead, this leads back to the previous page, i.e. the app detail page.

## Registration (optional)

If your app requires a registration, this registration process can be included right now.

## Send request for access token

After your app has obtained the `code` and a possible registration, you can send a request for an access token. This is done by a HTTPS `POST` request to the API in JSON format including the following parameters:

| Field              | Description                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------|
| `code`      | The code provided in the redirectUri ([see above](page:apps-oauth#confirm-the-installation)).     |
| `client id`   | The API key for the app (see the [get your credentials](page:apps-develop-app#get-your-credentials) section).|
| `client secret`    | The shared secret for the app (see the [get your credentials](page:apps-develop-app#get-your-credentials) section). |

Example:

{% highlight text %}
POST ///AccessTokenRequestURL HTTP/1.1
Host: 1234
Content-Type: application/json

code=MLaORzWY3SP0BJacq3ULaxcWEt8XxzWX
client id=8b745d8a070c483db9a3c303df31e698
client secret={client_secret}
{% endhighlight %}

A successful response to this request contains the following:

| Field              | Description                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------|
| `accessToken`      | The token that can be sent to the ePages API.     |

A JSON array is returned with HTTP response code 201 and an `accessToken`, similar to the following:

{% highlight text %}
HTTP/1.1 201 Created
Content-Type: application/json
X-epages-Media-Type: application/vnd.epages.v1+json
{% endhighlight %}
{% highlight json %}
{
  "accessToken": "abcdefg09876"
}
{% endhighlight %}

This is a permanent access token that can be used to access the shop's data as long as the app is installed in the merchant's shop.

{% callout danger Secret stuff! %}
With this `accessToken` you make authenticated requests to the shop's data. Store the `accessToken` safely and DO NOT share it with anyone!
{% endcallout %}

## Receive resource access

After the access token has been returned, make a HTTPS `GET` request to receive the `ResourceAccessURL`.

A successful response to this request could look like this.

{% highlight text %}
"Accept": "application/vnd.epages.v1+json"
"Authorisation": "Bearer" {accessToken}
{% endhighlight %}

## Fancy more information?

All API calls are authenticated according to the OAuth 2.0 protocol. Here you go for more details: [OAuth 2.0 protocol](https://tools.ietf.org/html/rfc6749).
