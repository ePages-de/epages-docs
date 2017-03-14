---
layout: page
key: apps-webhooks
title: Webhooks
---

Webhooks allow developers to build apps that receive near-real-time information about events that happen in ePages shops.
Instead of making constant API calls to check for specific events on the shop, you can register webhooks.
So, directly after having registered for our [Developer Program](/#modal-popup), you might want to know more about how we have implemented webhooks.

In order to receive the respective information about the events that your app subscribes to, webhooks require a callback URL.
When the event happens, we'll send a `POST` request to your callback URL.
Your app can then process the information send by us based on that event.

You might build an app that requires the following information:

* an order is placed
* a product is added
* a cart is created.

## First things first

Before you can send any requests or receive any responses, you'll need the following:

* Test shop: you can get a test shop by [joining the ePages Developer Program](/#modal-popup)
* Client ID and Client Secret: received during [app creation](page:apps-create#get-your-credentials)
* Access token: received during [app installation](page:apps-install)
* SSL setup.

## Create a webhook

To create a webhook, make a `POST` request to the respective webhook resource, including:

* The app's `callbackUrl`
* The `eventType`.

By default, new webhooks will be set to **active**.
If you want a webhook to be inactive initially, pass the following key-value `"active": false` with the request.

An `HTTP 201` response indicates that the webhook was successfully set.
Refer to the [`POST` webhooks resource](page:apps-api-post-shopid-webhooks-information) for more details.

## Webhook event types

* APP_UNINSTALL
* ORDERS_CREATE
* ORDERS_UPDATE
* ORDERS_DELETE
* PRODUCT_CREATE
* PRODUCT_UPDATE
* PRODUCT_DELETE

## Receive webhook callbacks

In order to receive the callback we send whenever events are triggered, you’ll need to create an application and configure your server.

Depending on server traffic, notifications on events might take a few seconds.

ePages will deactivate webhooks if some events don't go through.
You'll actively need to active the webhook again by passing the key-value `"active": true` with a `POST` webhooks request.

## Respond to webhook callbacks

To acknowledge that you received the webhook without issue, your server should return an HTTP 200.
Any response code outside the 200 range indicates us that you did not receive the requested webhook.
When a webhook is not received (for whatever reason), here's is how we retry:
