---
layout: page
key: apps-oauth
title: OAuth 2.0
---

Your app cannot access ePages data without getting authorisation from the merchant first. In this section we will help you through this authorisation process.

# Credentials

You already retrieved a `clientId` and a `clientSecret` that are known to both ePages and your application. If not, visit [get your credentials](page:apps-develop-app#get-your-credentials). Your app uses these credentials for identification during the authorisation process.

# Terminology

Before jumping into the authorisation process, let's look at some terms that will be used for this section.

| Name              | Description                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------|
| **Merchant** | A shop owner giving permission to an **App** to access his shop's data through the REST API. Within the OAuth 2.0 protocol this is referred to as **resource owner**. |
| **ePages** | This is where the **App** can view and modify a shop's data by accessing the REST API. Within the OAuth 2.0 protocol this is referred to as **service provider**.|
| **App**      | An application that would like to access a shop's data. The **Merchant** must grant permission before the **App** can access any data. Within the OAuth 2.0 protocol this is referred to as **client**. |

# Authorisation process

{% image oauth2-flow.png %}
OAuth 2.0 process
{% endimage %}

## 1. Ask for permission

The merchant decided to install your app. Great! He will then be asked whether he wants to grant the permissions that your app is requesting. While submitting the app, you have to define a **scope** for that. Currently, the only supported scope is *Read Products*. ePages displays the user consent form to the merchant as follows:

{% image asking-for-permission.png %}
Consent page
{% endimage %}

## 2. Confirm the installation

The merchant agrees and submits the consent form by clicking the button **Install** on the consent page.
He will then be redirected to your **Application Callback URL**.

## 3. Receive authorisation code

Once your app has been authorised by the merchant, it is returned a `code` as well as a `shopId`, `redirectUrl`, `accessTokenUrl` and `baseResourceUrl` as query parameters on your **Application Callback Url**. Your app can use the `code` in combination with your `clientId` and `clientSecret` for obtaining an `accessToken`.

Example:

/GET ...

{% highlight text %}
code: MLaORzWY3SP0BJacq3ULaxcWEt8XxzWX
shopId: DemoShop
redirectUrl: http://merchant/epages/DemoShop.admin/?ObjectID=17581&ViewAction=MBO
accessTokenRequestUrl: https://oauth.epages.com/oauth/get_access_token
resourceAccessUrl: https://
{% endhighlight %}

## 4. Registration (optional)

If your app requires a registration process, this optional call can be included before obtaining the `accessToken`. During this call, the app would display the registration or login form to the merchant.

## 5. Send request for access token

To request an `accessToken` make a HTTPS `POST` request to the API in JSON format including the following parameters:

| Field              | Description                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------|
| `code`      | The code provided in the `redirectUrl` ([see above](page:apps-oauth#confirm-the-installation)).     |
| `clientId`   | The client key for the app (see the [get your credentials](page:apps-develop-app#get-your-credentials) section).|
| `clientSecret`    | The shared client secret for the app (see the [get your credentials](page:apps-develop-app#get-your-credentials) section). |

Example:

HTTP POST ...

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

A JSON object is returned with HTTP response code 201 and an `accessToken`, similar to the following:

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

This is a permanent `accessToken` that can be used to access the shop's data as long as the app is installed in the merchant's shop. This `accessToken` allows your application to act on behalf of the merchant on this specific shop.

{% callout danger Secret stuff! %}
With this `accessToken` you make authenticated requests to the shop's data. Store the `accessToken` securely against the `baseResourceUrl`. DO NOT share the `accessToken` with anyone!
{% endcallout %}

## 6. Redirect the merchant

Once the authorisation process is complete, the app has to send the merchant back to the `redirectUrl` the app received [before](page:apps-oauth#receive-authorisation-code).

## Use access token to access API

With the `accessToken` received, make a HTTPS `GET` request to obtain the `baseResourceUrl`.

GET/....

A successful response to this request could look like this.

{% highlight text %}
"Accept": "application/vnd.epages.v1+json"
"Authorisation": "Bearer" {accessToken}
{% endhighlight %}

## Fancy more information?

All API calls are authenticated according to the OAuth 2.0 protocol. Here you go for more details: [OAuth 2.0 protocol](https://tools.ietf.org/html/rfc6749).
