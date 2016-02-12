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

* [`GET` shop information](https://developer.epages.com/apps/api-reference/get-shops-shopid.html)
* [`PATCH` product](https://developer.epages.com/apps/api-reference/patch-shops-shopid-products-productid.html)
* [`POST` slideshow](https://developer.epages.com/apps/api-reference/post-shops-shopid-products-productid-slideshow.html)
* [`GET` slideshow/sequence](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-slideshow-sequence.html)
* [`DELETE` slideshow/{imageName}](https://developer.epages.com/apps/api-reference/delete-shops-shopid-products-productid-slideshow-imagename.html)
* [`PUT` slideshow/sequence](https://developer.epages.com/apps/api-reference/put-shops-shopid-products-productid-slideshow-sequence.html)
* Added `productImage` attribute
* Added new attributes `shippingData` and `paymentData` to orders
* Replaced attribute `comment` with `customerComment` and `internalNote`.

<hr>

## 2016-01-21

### Latest changes with software release 6.17.38

* Added [`GET` sales](https://developer.epages.com/apps/api-reference/get-shops-shopid-sales.html) endpoint

<hr>

## 2016-01-19

### Latest changes with software release 6.17.37

* Added date range filters `createdBefore` and `createdAfter` to query parameters of [`GET` orders](https://developer.epages.com/apps/api-reference/get-shops-shopid-orders.html#query-parameters)
