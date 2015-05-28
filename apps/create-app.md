---
layout: page
key: apps-create
title: Create an app
---

Once you have your test shop in place, you can create an app. You automatically receive a **Client ID**, **Client Secret** and **Access token** when you create an app in your test shop.

| Value              | Description                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------|
| **Client&nbsp;ID**      | The unique identifier for your app. |
| **Client&nbsp;Secret**   | Used in combination with the **Client ID** for getting an **Access Token** during the [authorisation process](page:apps-install#authorisation-process).|
| **Access&nbsp;token** | The token granted from your test shop to the newly created app. You can use this token for accessing the API. [Read here for further details.](page:apps-install) |

# Get your credentials

1. Within the administration area of your test shop, click the tab **Apps & Themes**. In the drop down menu, choose the field **Developer apps**.
    {% image click-apps.png %}{% endimage %}

2. In the **Developer apps** view, click the button **Add**.
    {% image add-button.png %}{% endimage %}

3. Fill out the entry field **App name**. This field is mandatory. Then click the button **Generate API access data**.
    {% image fillout-app-name.png %}{% endimage %}

4. You will be assigned a **Client ID**, **Client Secret** and **Access token**.
    {% image test-shop-credentials.png %}{% endimage %}

{% callout danger Important! %}
Store your **Client Secret** and **Access token** securely!
{% endcallout %}

You may want to integrate the **Client ID** and **Client Secret** into your application for the authorisation process.  Also, you are given the **Access token** upfront without having to pass the authorisation process. This **Access token** is granted by your test shop, so that you can start accessing the ePages API immediately.

# Happy coding

Once this is done, you can start coding away. You are free to use any kind of code language.  But when developing your app, please consider our [API call limit](page:apps-api-call-limit).
