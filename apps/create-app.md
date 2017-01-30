---
layout: page
key: apps-create
title: Create an app
---

Once you have your test shop in place, you can create an app.
Oh, by the way, this is the API URL for your test shop: `https://devshop.epages.com/rs/shops/{shopId}`.

You automatically receive a **Client ID** and a **Client Secret** when you create an app in your test shop.
After successful authorisation of your app, you will be assigned an **Access token**.

| Value              | Description                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------|
| **Client&nbsp;ID**      | The unique identifier for your app. |
| **Client&nbsp;Secret**   | Used in combination with the **Client ID** for getting an **Access token** during the [authorisation process](page:apps-install#authorisation-process).|
| **Access&nbsp;token** | The token granted from your test shop to the newly created app. You can use this token for accessing the API. [Read here for further details.](page:apps-install) |

## Get your credentials

1. Within the administration area of your test shop, click **Apps & Themes**.
In the drop down menu, choose **App Store**.
    {% image click-appstore.png %}

2. Click the button **Private apps**.
    {% image click-privateapps.png %}

3. In the **Private apps** view, click **Add**.
    {% image add-button.png %}

4. Fill out the input field **App name** and specify the **Application Callback URL**.
Make sure the URL is https and publicly accessible.
Choose the required **App Scopes**. Read here for further information on the scopes.
Note: HTTP Application Callback URLs can be used for private apps, but you need to provide an HTTPS URL if you want to submit the app to the App Store.
Once this is done, click **Generate access data**.

    {% image fillout-appdata.png %}

5. You will be assigned your **App Scopes**, a **Client ID**, a **Client Secret** as well as an **Access token**.
The **Access token** is granted by your test shop, so that you can start accessing the ePages API immediately.
    {% image testshop-credentials.png %}

{% callout danger Warning %}
Store your **Client Secret** and **Access token** securely!
{% endcallout %}

## Happy coding!

Once this is done, you can start coding away.
But when developing your app, please consider our [API call limit](page:apps-api-call-limit).

## Test the authorisation process

Once you have implemented the authorisation flow in your app, you can trigger it by clicking the button **Test authorisation**.
Make sure that the **Applicaton Callback URL** for your app is correct.
Your app will be checked for proper implementation of the [OAuth 2.0 flow](page:apps-install#authorisation-process).
{% image test-authorisation.png %}

{% callout info Note %}
Triggering the test authorisation flow removes the existing **Access token** first.
{% endcallout %}

### Successful authorisation

If your authorisation has been successful, you will be assigned a new **Access token**.

### Unsuccessful authorisation

If the authorisation process failed, you will end up without having an **Access token**.
To create a new token without having passed a successful authorisation flow, simply create a new developer app.
