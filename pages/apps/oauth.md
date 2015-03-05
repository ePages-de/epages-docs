---
layout: page
key: apps-oauth
title: OAuth
---

# Why OAuth?

Your app cannot read ePages data without authenticating first. In order to access to the resources of the REST API, your application must get permission.
In this section we will help you through this authorisation process.

All API calls are authenticated according to the OAuth 2.0 protocol. Fancy more detailed information? Here you go: [OAuth 2.0 protocol](https://tools.ietf.org/html/rfc6749).

# Terminology

Before jumping into the authorisation process, let's look at some terms that will be used for this section.

* **App**: An application that would like to access to a shops's data. The **Merchant** must grant permission before the **App** can access any data.


* **ePages**: The ePages API. This is where the **App** can view and modify a shop's data.


* **Merchant**: A shop owner giving permission to an **App** to access his shop's data through the REST API.

# Authorisation process

{% image oauth2-flow.jpg %}
OAuth 2.0 process
{% endimage %}

## Get the app's credentials

You will need to retrieve a **Consumer key** and a **Consumer secret** as your app uses these credentials for identification during the authorisation process.
To get the credentials follow the steps in the [set-up section](page:apps-develop-app#set-up) to create an app. The credentials will be provided to you during this process.

## Ask for permission

The merchant first has to authorise the app to access his shop's data. This is done by a consent form provided in a prompt by ePages:

{% image asking-for-permission.png %}
Asking for permission
{% endimage %}

## Confirm the installation

When the merchant agrees the consent form by clicking the button **Install** in the prompt, he will be redirected to the callback URL:

https://
