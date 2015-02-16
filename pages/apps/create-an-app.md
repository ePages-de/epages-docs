---
layout: page
title: Create an app
category: apps
---

# What kind of apps do we support?
In a first approach, we only support external apps. We call them "connectors". Connectors are not integrated into the merchant's backoffice, but interact with a shop via the REST API to use the shop's data.

# Set-up
1. Within your test shop backoffice, choose the tab **Apps**.
2. Choose the field **Private Apps** and click the button **Create app**.
3. Fill out the entry field **App name**. This field is mandatory.
4. Click the button **Save**. The API data **Consumer key**, **Consumer secret**, **Access token** and **Access secret** will be generated automatically.

Once this is done, you can start coding off. Brilliant: you are free to use any kind of code language.
But when developing your app, please consider our [API call limit](doc:api-call-limit).

# Your app is ready for takeoff?

Let's go for the [authorisation](doc:oauth).
Once this is done, your app will be available in your test shop in the field **My apps**.

# Test. Test. Test.

| What?             | What for?                                                                              |
|-------------------|----------------------------------------------------------------------------------------|
| Delete an app.    | Removes the keys of the app in the **Private app** environment. Testing not mandatory. |
| Uninstall an app. | Ensures, that your app is capable of being uninstalled completely. Testing mandatory.  |

## Delete an app:

In the field **Private apps** click the button **Delete**.
If the process has been successful, the app has been removed from **Private apps**.

## Uninstall an app:

1. In the field **My apps**, click the app.
2. In the new window, click the button **Uninstall**.
3. A dialogue appears that you're about to uninstall your app.
4. Click the button **Uninstall**.

If the process worked just fine, the field **My apps** is empty.
Your app is still available in the field **Private apps**.

# Ready, steady, go!

[Submit your app](doc:submit-an-app).
