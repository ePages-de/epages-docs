---
layout: page
key: apps-create-custom
title: Create an app
---

Once you have your test shop in place, you can create a custom app for a specific shop, and only for that shop.

You automatically receive a **Client ID** and a **Client Secret** when you create an app in your test shop.
After successful authorisation of your app, you will be assigned an **Access token**.

## Get your credentials

1. In the sidebar of your shop's administration area, click **Apps**.

2. Click the tab **Private apps**.

3. In the **Private apps** view, click **Add**.
    {% image click-customapps.png %}

4. Fill out the input field **App name** and choose the required **App Scopes**. [Read here](page:app-scopes) for further information on the scopes. Once this is done, click **Generate access data**.
    {% image fillout-custom-appdata.png %}

5. You will be assigned your **App Scopes**, a **Client ID**, a **Client Secret** as well as an **Access token**.
The **Access token** is granted by your test shop, so that you can start accessing the ePages API immediately.
    {% image testshop-custom-credentials.png %}

## Happy coding!

Once this is done, you can start coding away.
But when developing your app, please consider our [API call limit](page:apps-api-call-limit).
