---
layout: page
key: apps-create
title: Create an app
---

Once you have your test shop in place, you have to create an app to get the `clientID` and `clientSecret` values.
The `clientID` is the unique identifier for your app. You will have to use it for all requests to the API.
The `clientSecret` is just shared between your app and ePages. You have to pass the `clientSecret` once during the [authorisation process](page:apps-install#authorisation-process). Your app uses this value to verify the signature.

## Get your credentials

1. Within the backoffice of your test shop, click the tab **Apps**.
    {% image click-apps.png %}{% endimage %}

2. In the drop down menu, choose the field **Developer Apps**.
    {% image choose-developer-apps.png %}{% endimage %}

3. In the **Developer Apps** view, click the button **Add**.
4. Fill out the entry field **App name**. This field is mandatory.
    {% image fillout-app-name.png %}{% endimage %}

5. Click the button **Save**. You will be assigned a unique `clientId`, `clientSecret` and `accessToken`. Remember these credentials as you will have to integrate them into the configuration files or the actual code of your application.

{% callout danger Important! %}
DO NOT share your **clientSecret** with anyone!
{% endcallout %}

The credentials you'll receive might look like this:

**ClientID**: e587538c751e4e05af93b6119fb249ac

**ClientSecret**: sUBtJFvBEggf8OMp3Q37RHNDiMFMLUwz

**AccessToken**: azFE9jsp00mz4VoqZAnoFgKYTBi20soI

Once this is done, you can start coding off. You are free to use any kind of code language.
But when developing your app, please consider our [API call limit](page:apps-api-call-limit).
