---
layout: page
key: apps-webhooks
title: Webhooks
---

Webhooks allow developers to build apps that receive near-real-time information about events that happen in ePages shops.
Instead of making constant API calls to check for specific changes on the shop, you can register webhooks.
So, directly after having registered for our [Developer Program](/#modal-popup-6), you might want to know more about how we have implemented webhooks.

In order to receive the respective information about the events that your app subscribes to, webhooks require a callback URL.
When the event happens, we'll send a `POST` request to your callback URL.
Your app can then process the information send by us based on that event.

Your app might require the following information:

* an order has been created
* an order has been updated
* an order has been deleted
* your app has been uninstalled.

## Ready to start creating a webhook

To create a webhook, make a [`POST` request](page:apps-api-post-shopid-webhooks-information) to the respective webhook resource, including:

* The app's `callbackUrl` (has to be `https`)
* The `eventType`
    * APP_UNINSTALL
    * ORDERS_CREATE
    * ORDERS_UPDATE
    * ORDERS_DELETE

By default, new webhooks will be set to **active**.
If you want a webhook to be inactive initially, pass the following key-value `"active": false` with the request.

An `HTTP 201` response indicates that the webhook was successfully set.

## Receive webhook callbacks

### Structure of callback requests

In order to receive the callback we send whenever events are triggered, you’ll need to create an application and configure your server.

A notification would look like this:

{% highlight json %}
{
   "id":"732EBF70-7138-426C-ABA4-E48AFDE3E47E",
   "baseUrl":"https://example.test.com/rs/shops/DemoShop",
   "entityUrl":"https://example.test.com/rs/shops/DemoShop/orders/58B6F171-3417-072A-0304-AC1532194AAB",
   "createdOn":"2017-03-20T10:58:18Z",
   "eventType":"ORDER_UPDATE",
   "entity":{ ... }

{% endhighlight %}

| Name      | Type      | Description    |
|---------------|---------------| -------|
| `id`   | string | The unique identifier of the webhook object. |
| `baseUrl`   | string | The URL to the REST API of the shop. |
| `entityUrl`   | string | The URL to the entity. |
| `createdOn`  | string | The time the notification was created. |
| `eventType`  | string | The event that triggers the webhook. Can be *ORDER_CREATE*, *ORDER_UPDATE*, *ORDER_DELETE* or *APP_UNINSTALL*. |
| `entity`   | object | Can be either empty or shows the object the event type is about (e.g. in case of an order event, it contains the affected order, just like e.g. a [`GET` orders/{orderId}](https://developer.epages.com/apps/api-reference/get-shopid-orders-orderid) request.  |

Depending on server traffic, notifications on events might take a few seconds.

### Verify callback requests

Each callback ePages sends to registered webhooks contains a `X-Epages-Hmac-Sha256` header with a signature that can be used to verify that the request really comes from ePages.
This signature is calculated by

`signature = encode_Base64( HMAC_SHA256(secret, message) )`

where `secret` is the OAuth2 Client Secret of the app which has registered the webhook (the one, the developer receives when creating an app on the developer portal) and `message` is the request body of the callback request.

#### Java example

The calculation of the signature can be done easily in Java without any external library:

{% highlight java %}
import java.util.Base64;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

public String calculateSignature(String oauth2ClientSecret, byte[] content) {
    final Mac mac = Mac.getInstance(HmacSHA256);
    mac.init(new SecretKeySpec(oauth2ClientSecret.getBytes("UTF-8"), "HmacSHA256"));
    final byte[] signature = mac.doFinal(content);
    return Base64.getEncoder().encodeToString(signature);
}
{% endhighlight %}

Using this method, the signature can be calculated like that:

{% highlight java %}
String secret = "A5pnpId0FyHno8caYRAj2YccFU42kta8"
String body = "{\"id\":\"11AEF3CC-F0D1-485E-B9CF-B28CB409928D\", ....... }]}"

String signature = calculateSignature(secret, body.getBytes());
{% endhighlight %}

#### Ruby example

Use this method to calculate the signature in Ruby:

{% highlight ruby %}
require 'openssl'
require "base64"

def calculateSignature(secret, message)
    hash = OpenSSL::HMAC.digest('sha256', secret, message)
    return Base64.encode64(hash)
end
{% endhighlight %}

Now it can be used like that:

{% highlight ruby %}
secret = 'A5pnpId0FyHno8caYRAj2YccFU42kta8'
message = '{"id":"11AEF3CC-F0D1-485E-B9CF-B28CB409928D", ....... }]}'

signature = calculateSignature(secret, message)
{% endhighlight %}


## Respond to webhook callbacks

To acknowledge that you received the webhook without issue, your server should return an HTTP 200.
Any response code outside the 200 range indicates us that you did not receive the requested webhook.
When a webhook is not received (for whatever reason), here's is how we retry:

Of course, will do our best to deliver the events via the webhooks to your callback URL.

* If a webhook times out or returns a response code outside the 200 range the application will be disabled for 60 seconds.
* Webhooks created during that 60 seconds time frame will be queued up for the next retry attempt so that these webhooks won't be lost.

The maximum retry limit is 11 retries that are set as follows:

* 60 seconds after the last failure
* 180 seconds after the last failure
* 300 seconds after the last failure
* 600 seconds after the last failure
* 900 seconds after the last failure
* 1800 seconds after the last failure
* 3600 seconds after the last failure
* 7200 seconds after the last failure
* 21600 seconds after the last failure
* 50400 seconds after the last failure
* 86400 seconds after the last failure.

After the last retry attempt, the webhook will be deactivated.
We will send a notification to the email address that you used for the registration to our Developer Program.
To activate the webhook again, set `active` to `true` using the [`POST` webhooks/{webhookId}](page:apps-api-post-shopid-webhooks-webhookid-information) request.

## Update or delete a webhook

To update or delete a webhook, use the [`POST` webhooks/{webhookId}](page:apps-api-post-shopid-webhooks-webhookid-information) or [`DELETE` webhooks/{webhookId}](page:apps-api-delete-shopid-webhooks-webhookid-information) respectively.
