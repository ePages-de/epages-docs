---
layout: page
key: apps-use-cases
title: Use cases
---

# Social Commerce

Build an application that show cases products on social media platforms like Facebook, integrates products on a blogging platform or on any given site with a widget.

Suggested calls: [`GET` products](page:apps-api-get-shops-shopid-products-information), [`GET` categories](page:apps-api-get-shops-shopid-categories-information)

Optional calls: [`POST` carts](page:apps-api-post-shops-shopid-carts-information), `PUT` carts, [`GET` legal](page:apps-api-get-shops-shopid-legal-information)

Availability: <i class="fa fa-check"></i>

# Portal Engines

Build an application that adds products to price comparison or shopping portals.

Suggested calls: [`GET` products](page:apps-api-get-shops-shopid-products-information) (batch)

Optional calls: [`GET` categories](page:apps-api-get-shops-shopid-categories-information)

Availability: <i class="fa fa-check"></i>

# Shipping

Build an application that allows you to print shipping labels and to control the status of an order.

Suggested calls: `GET` orders, `PUT` orders

Optional calls: [`GET` products](page:apps-api-get-shops-shopid-products-information)

Availability planned: **11/2015**

# Accounting

Build an application that allows you to manage and process orders.

Suggested calls: `GET`orders, `PUT` orders

Optional calls: [`GET` products](page:apps-api-get-shops-shopid-products-information)

Availability planned: **11/2015**

# Content Optimisation and Marketing

Build an application that optimises or enhances the content of product or category descriptions for Search Engine Optimisation (SEO), for general marketing purposes or to add translations to all descriptive content.

Suggested calls: [`GET` products](page:apps-api-get-shops-shopid-products-information), `PUT` products, [`GET` categories](page:apps-api-get-shops-shopid-categories-information), `PUT` categories

Availability planned: **12/2015**

# Legal Service

Build an application that provides up-to-date legal information (imprint, terms and conditions, etc.) automatically.

Suggested calls: [`GET` legal](page:apps-api-get-shops-shopid-legal-information), `PUT` legal

Availability planned: **12/2015**

# Basic Point of Sale (POS)/Marketplace

Build an application that automatically updates the stock level of a product upon a POS/Marketplace sale.

Suggested calls: [`GET` products](page:apps-api-get-shops-shopid-products-information), `PUT` products

Optional calls: [`GET` categories](page:apps-api-get-shops-shopid-categories-information)

Availability planned: **12/2015**

# Advanced Point of Sale (POS)/Marketplace

Build an application that automatically updates the stock level of a product upon a POS/Marketplace sale and allows to create and manage customers and orders.

Suggested calls: [`GET` products](page:apps-api-get-shops-shopid-products-information), `PUT` products, `GET` customers, `PUT` customers, `POST` customers, `GET` orders, `PUT` orders, `POST` orders

Optional calls: [`GET` categories](page:apps-api-get-shops-shopid-categories-information)

Availability planned: **06/2016**

# Customer Relationship Management (CRM) and Newsletters

Build an application that analyses and groups/targets customers by ordered products and/or newsletter preferences and generates personalised newsletters accordingly.

Suggested calls: `GET` customers, `PUT` customers, `POST` customers, `GET` orders, [`GET` products](page:apps-api-get-shops-shopid-products-information)

Availability planned: **06/2016**

# Enterprise Management Systems (EMS)

Build an application that manages products, customers and orders as well as handles fulfillment, accounting and customer support.

Suggested calls: [`GET` products](page:apps-api-get-shops-shopid-products-information), `PUT` products, `POST` products, `DELETE` products, `GET` customers, `PUT` customers, `POST` customers, `GET` orders, `PUT` orders, `POST` orders

Optional calls: ([`GET` categories](page:apps-api-get-shops-shopid-categories-information))

Availability planned: **06/2016**
