---
layout: page
key: authentication
title: Authentication
---
# OAuth

Your app cannot access the REST API resources without authenticating first. In order to access to the ePages data, your application must be authenticated.
All API calls are authenticated according to the OAuth 2.0 protocol. Fancy more detailed information? Here you go: [OAuth 2.0 protocol](https://tools.ietf.org/html/rfc6749).

Once you have signed up for the developer program and you have created your app successfully, you will be assigned a unique **Consumer key** and **Consumer secret**. Remember these credentials as you will have to integrate them into the configuration files or the actual code of your application.

{% callout danger Important! %}
For your application's own security: DO NOT share your consumer secret with anyone!
{% endcallout %}

The credentials you'll receive might look like this:

{% image example-consumer-key-secret.png 50% %}
Example of OAuth keys
{% endimage %}

# Authorisation

1. Within your test shop backoffice, again choose the tab **Apps**.
2. Choose the field **Private Apps** and click the button **Create app**.
3. Click the button **Test authorisation**. You will be requested to enter the **Application callback URL** and **Application notification URL**.
4. Click the button **Test authorisation** again. You will be forwarded to an external page to complete the authorisation process.
5. Once the test authorisation has been finished successfully, you will be fowarded to

{% callout danger Authorisation to be described %}
  development in progress
{% endcallout %}
