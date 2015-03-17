---
layout: page
key: apps-install
title: Install an app
---

Your app cannot access ePages data without getting authorisation from the merchant first. In this section we will help you through this authorisation process.

# Credentials

You retrieved a `clientId` and a `clientSecret` that are known to both ePages and your application. If not, visit [get your credentials](page:apps-create#get-your-credentials). Your app uses these credentials for identification during the authorisation process.

# Terminology

Before jumping into the authorisation process, let's look at some terms that will be used in this section.

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

The merchant decided to install your app. Great! He will then be asked whether he wants to grant the permissions that your app is requesting. While submitting the app, you have to define a **scope** for that. ePages displays the user consent form to the merchant as follows:

{% image asking-for-permission.png %}
Consent page
{% endimage %}

## 2. Confirm the installation

The merchant agrees and submits the consent form by clicking the button **Install** on the consent page. The merchant will be redirected to the app's **Application Callback URL**.

## 3. Receive authorisation code

ePages makes a `GET` request to the **Application Callback URL** provided by the app developer.

Example:

{% highlight text %}
GET https://exampleapp.com/callback?code={code}&shopId={shopId}&returnUrl={returnUrl}&accessTokenUrl={accessTokenUrl}&baseResourceUrl={baseResourceUrl} HTTP/1.1
{% endhighlight %}

Substitutions would be made as given in this example table:

| Query parameter              | Example                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------|
| {`code`}      | f32ddSbuff2IGAYvtiwYQiyHyuLJWbey     |
| {`shopId`}   | CreamyIceShop|
| {`returnUrl`}    | http://hostname/epages/CreamyIceShop.admin/?ObjectID=17811&ViewAction=MBO-ViewAppDetails&appID=54f46f318732110bd85f41c7 |
| {`accessTokenUrl`}      | http://hostname/rs/shops/CreamyIceShop/token |
| {`baseResourceUrl`}      | http://hostname/rs/shops/CreamyIceShop |

Your app can use the `code` in combination with your `clientId` and `clientSecret` for obtaining an `accessToken`. This code is temporary.

## 4. Registration (optional)

If your app requires a registration process, this optional step can be included before obtaining the `accessToken`. During this, the app would display the registration or login form to the merchant.

## 5. Send request for access token

To request an `accessToken`, make a HTTPS `POST` request to the API including the following parameters:

| Field              | Description                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------|
| `code`      | The code provided in the **Application Callback URL** ([see above](page:apps-install#receive-authorisation-code)).     |
| `clientId`   | The client key for the app (see the [get your credentials](page:apps-create#get-your-credentials) section).|
| `clientSecret`    | The shared client secret for the app (see the [get your credentials](page:apps-create#get-your-credentials) section). |

Example:

{% highlight text %}
POST /http://hostname/rs/shops/CreamyIceShop/token HTTP/1.1
Content-Type: application/x-www-form-urlencoded

code=f32ddSbuff2IGAYvtiwYQiyHyuLJWbey&client_id=value&client_secret=value
{% endhighlight %}

A successful response to this request contains the following:

| Field              | Description                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------|
| `accessToken`      | The token that can be sent to the ePages API.     |

A JSON object is returned with an `accessToken`, similar to the following:

{% highlight text %}
HTTP/1.1 200 OK
Content-Type: application/json
X-epages-Media-Type: application/vnd.epages.v1+json
{% endhighlight %}
{% highlight json %}
{
  "accessToken": "4HZ9hriF6J3GOnd10JbFzdVehycOvAZf"
}
{% endhighlight %}

This is a permanent `accessToken` that can be used to access the shop's data as long as the app is installed in the merchant's shop. This `accessToken` allows your application to act on behalf of the merchant on this specific shop.

{% callout danger Top secret! %}
With this `accessToken` you make authenticated requests to the shop's data. Store the `accessToken` securely against the `baseResourceUrl`. Do not share the `accessToken` with anyone!
{% endcallout %}

## 6. Redirect the merchant

Once the authorisation process is complete, your app has to send the merchant back to the `returnUrl` the app received [before](page:apps-install#receive-authorisation-code).

# Make an authenticated request to the API

Now that your application has received an `accessToken`, it can make authenticated requests to the ePages API.

Example:

{% highlight text %}
GET /http://hostname/rs/shops/CreamyIceShop/{resource} HTTP/1.1
"Accept": "application/vnd.epages.v1+json"
"Authorization": "Bearer {accessToken}"
{% endhighlight %}

The substitution would be made as given in this example table:

| Parameter              | Example                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------|
| {`accessToken`}      | 4HZ9hriF6J3GOnd10JbFzdVehycOvAZf     |
| {resource}      | products     |


# Fancy more information?

All API calls are authenticated according to the OAuth 2.0 protocol. Here you go for more details: [OAuth 2.0 protocol](https://tools.ietf.org/html/rfc6749).
