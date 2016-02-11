---
layout: page
key: api-change-log
title: API Change Log
version: v1
---

This change log covers significant updates and changes to the ePages REST API.
In order to keep track of these changes we recommend you to follow [@epagesdevs](https://twitter.com/epagesdevs) on Twitter or subscribe to our [RSS feed for the API Change Log](https://developer.epages.com/apps/feed.xml).

<hr>

## 2016-02-09

### Latest changes with software release 6.17.39

 * [`GET` shop information](page:apps-api-get-shops-shopid-information)
 * [`PATCH` product](page:apps-api-patch-shops-shopid-products-productid-information)
 * [`POST` slideshow](page:apps-api-post-shops-shopid-products-productid-slideshow-information)
 * [`GET` slideshow/sequence](page:apps-api-get-shops-shopid-products-productid-slideshow-sequence-information)
 * [`DELETE` slideshow/{imageName}](page:apps-api-delete-shops-shopid-products-productid-slideshow-imagename-information)
 * [`PUT` slideshow/sequence](page:apps-api-put-shops-shopid-products-productid-slideshow-sequence-information)
 * Added `productImage` attribute
 * Added new attributes `shippingData` and `paymentData` to orders
 * Replaced attribute `comment` with `customerComment` and `internalNote`.

<hr>

## 2016-01-21

### Latest changes with software release 6.17.38

 * Added [`GET` sales](page:apps-api-get-shops-shopid-sales-information) endpoint

<hr>

## 2016-01-19

### Latest changes with software release 6.17.37

 * Added date range filters `createdBefore` and `createdAfter` to query parameters of [`GET` orders](page:apps-api-get-shops-shopid-orders-information#query-parameters)