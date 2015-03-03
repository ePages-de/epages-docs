---
layout: page
key: apps-develop-app
title: Developing an app
---

# Create an app

## What kind of apps do we support?
In a first approach, we only support external apps. These apps connect via the REST API to the shop to exchange data and let the merchant work with these data within an external service.

## Set-up

1. Within your test shop backoffice, click the tab **Apps**.
2. In the drop down menu, choose the field **Developer Apps**.
3. In the **Developer Apps** view, click the button **Add**.
3. Fill out the entry field **App name**. This field is mandatory.
4. Click the button **Save**. You will be assigned a unique **Consumer key** and **Consumer secret**. Remember these credentials as you will have to integrate them into the configuration files or the actual code of your application. We also automatically authorise your own account and generate an **Application callback URL**, **Application notification URL** and **Access token**.

{% callout danger Important! %}
For your application's own security: DO NOT share your **Consumer secret** with anyone!
{% endcallout %}

The credentials you'll receive might look like this:

{% image example-consumer-key-secret.png 50% %}
Example credentials
{% endimage %}

Once this is done, you can start coding off. You are free to use any kind of code language.
But when developing your app, please consider our [API call limit](page:apps-using-the-api#api-call-limit).

# Submit an app

## Your app is ready for takeoff?

Yay! You're done with developing your awesome app and you're excited to make it available to our App store? Congrats! We are just as much excited as you are!

Let's go submitting your app.

1. Within your test shop, click the tab **Developer Apps**.
2. Click the button **Submit app**.
3. Fill out the submission form.

This is what we need to thoroughly test the functionality of your app.

| What?              | Why?                                                                                                    |
|--------------------|---------------------------------------------------------------------------------------------------------|
| General information      | We need your contact details for proper identification.                                           |
| Details about your app   | Facts like app settings, language, price of your service, support information etc are relevant for the submission process.|
| Marketing information    | Your app goes live and needs to be placed nicely in the ePages App Store. |

## You have reached the home stretch!

Click the button **Submit app now**.

Makes us jump for joy! Your app is on its way! We will be testing your app and come back to you as soon as our review has been completed. Give us XXX days time.
