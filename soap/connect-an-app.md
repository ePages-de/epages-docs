---
layout: page
key: soap-authentication
title: Connect an app
---

Your app cannot access ePages data without getting authorisation from the merchant first.
In this section we will help you through this authorisation process.

# Connecting with ePages shops

## Terminology

Before explaining this process in detail, the following table shows some terms that will be used in this section.

| Name      | Description    |
|---------------|---------------|
| **Merchant**   | A shop owner giving permission to an application to access the shop’s data through the SOAP API.  |
| **ePages** | This is where the application can view and modify a shop’s data by accessing the SOAP API. |
| **Application** | A third party application that would like to access a shop’s data. |

{% image soap-basic-authentication.png %}

## 1. Setting up login

The merchant clicks the registration link provided by the third party.
ePages sends the **backlink** that the third party will use to redirect to the ePages shop after finishing the registration process.
This backlink will be provided via an HTTP `GET` or `POST` request into the registration link.

## 2. Redirecting to app confirmation page

The third party application redirects to the ePages shop using the backlink, also sending the registration ID of the merchant via an HTTP `GET` request.

## 3. Creating SOAP credentials and send to callback URL

The ePages shop creates the credentials that allows the third party application to connect to the web services and to use the above mentioned web services:

* SOAP user
* SOAP password
* SOAP URL
* Provider key

The third party has already previously been provided with the client application credentials and a table containing all secret keys per provider key.
Those secret keys allow the third party to decrypt the data.

## 4. Sending connection confirmation

When the ePages shop sends these credentials, the HTTP response code 200 is expected.
If the HTTP 200 is not returned by the third party server, the credentials will be deleted and obsolete.

## 5. Redirecting to settings page

The merchant will be redirected to the settings page to see the current connection status.

# To be provided by the third party

| Name      | Description    |
|---------------|---------------|
| Registration&nbsp;URL   | The URL that allows the merchant to register for the application. ePages will call this URL by sending the provider ID (identification of the platform) and the backlink (URL to redirect after registration) via a `GET` request.  |
| Registration&nbsp;ID | The registration identifier that has to be sent in the backlink URL via a `GET` request.|
| Callback&nbsp;URL | The URL that the ePages shop will send the credentials to. |
| Authorisation&nbsp;URL | The URL of the third party, where the merchant can handle his orders and create shipping labels.|
| Logos and marketing text | Required to customise the pages related to the connection process. |
