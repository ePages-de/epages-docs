---
layout: page
key: apps-create
title: Create an app
---

Once you have your test shop in place, you can create an app.
You automatically receive a **Client ID** and a **Client Secret** when you create an app in your test shop.
After successful authorisation of your app, you will be assigned an **Access token**.

| Value              | Description                                                                                             |
|--------------------|---------------------------------------------------------------------------------------------------------|
| **Client&nbsp;ID**      | The unique identifier for your app. |
| **Client&nbsp;Secret**   | Used in combination with the **Client ID** for getting an **Access token** during the [authorisation process](page:apps-install#authorisation-process).|
| **Access&nbsp;token** | The token granted from your test shop to the newly created app. You can use this token for accessing the API. [Read here for further details.](page:apps-install) |

# Get your credentials

1. Within the administration area of your test shop, click the tab **Apps & Themes**.
In the drop down menu, choose the field **Developer apps**.
    {% image click-apps.png %}{% endimage %}

2. In the **Developer apps** view, click the button **Add**.
    {% image add-button.png %}{% endimage %}

3. Fill out the input field **App name**.
Specify the **Application Callback URL**.
Make sure the URL is https and publicly accessible.
Note: HTTP Application Callback URLs can be used for developer apps, but you need to provide an HTTPS URL once you want to submit the app to the App & Theme Store.
Once the input fields are filled out, click the button **Generate access data**.
    {% image fillout-app-name.png %}{% endimage %}

4. You will be assigned a **Client ID** and a **Client Secret**.
    {% image test-shop-credentials.png %}{% endimage %}
Happy coding! Once this is done, you can start coding away.
You are free to use any kind of programming language.
But when developing your app, please consider our [API call limit](page:apps-api-call-limit).

5. Once you have developed your app, click the button **Test authorisation**.
    {% image test-authorisation.png %}{% endimage %}

6. After successful authorisation, you will be assigned an **Access token**.
      {% image access-token.png %}{% endimage %}
Integrate the **Access token** into your application and test your app.
Make sure that your app can access the API.

{% callout danger Important! %}
Store your **Client Secret** and **Access token** securely!
{% endcallout %}
