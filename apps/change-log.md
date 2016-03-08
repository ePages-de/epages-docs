---
layout: page
key: api-change-log
title: API Change Log
version: v1
---

This change log covers significant updates and changes to the ePages REST API.
In order to keep track of these changes we recommend you to follow [@epagesdevs](https://twitter.com/epagesdevs) on Twitter or subscribe to our [RSS feed for the API Change Log](https://developer.epages.com/apps/feed.xml).

<hr>

## 2016-03-07

### Changes with software release 6.17.42

#### <i class="fa fa-plus"></i> New

* [`POST` customers](https://developer.epages.com/apps/api-reference/post-shops-shopid-customers.html)
* [`GET` customers/{customerId}](https://developer.epages.com/apps/api-reference/get-shops-shopid-customers-customerid.html)
* [`PATCH` customers/{customerId}](https://developer.epages.com/apps/api-reference/patch-shops-shopid-customers-customerid.html)
* [`PATCH` orders/{orderId}](https://developer.epages.com/apps/api-reference/patch-shops-shopid-orders-orderid.html)

#### <i class="fa fa-pencil"></i> Update

* Added `main-category` link to [`GET` products/{productId}](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid.html)

<hr>

## 2016-02-25

### Changes with software release 6.17.41

#### <i class="fa fa-plus"></i> New

* [`GET` products/updated/{productProperty}](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-updated-productproperty.html)

#### <i class="fa fa-pencil"></i> Update

* Renamed attribute `cancelledOn` to `rejectedOn` as well as attribute `shippedOn` to `deliveredOn` within **orders** calls
* Added attribute `customerNumber` to [`GET` orders](https://developer.epages.com/apps/api-reference/get-shops-shopid-orders.html) and [`GET` orders/{orderId}](https://developer.epages.com/apps/api-reference/get-shops-shopid-orders-orderid.html)

<hr>

## 2016-02-18

### Changes with software release 6.17.40

* None.

<hr>

## 2016-02-09

### Changes with software release 6.17.39

#### <i class="fa fa-plus"></i> New

* [`GET` {shopId}](https://developer.epages.com/apps/api-reference/get-shops-shopid.html)
* [`PATCH` products/{productId}](https://developer.epages.com/apps/api-reference/patch-shops-shopid-products-productid.html)
* [`POST` products/{productId}/slideshow](https://developer.epages.com/apps/api-reference/post-shops-shopid-products-productid-slideshow.html)
* [`GET` products/{productId}/slideshow/sequence](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid-slideshow-sequence.html)
* [`DELETE` products/{productId}/slideshow/{imageName}](https://developer.epages.com/apps/api-reference/delete-shops-shopid-products-productid-slideshow-imagename.html)
* [`PUT` products/{productId}/slideshow/sequence](https://developer.epages.com/apps/api-reference/put-shops-shopid-products-productid-slideshow-sequence.html)

#### <i class="fa fa-pencil"></i> Update

* Added `productImage` attribute
* Added new attributes `shippingData` and `paymentData` to orders
* Replaced attribute `comment` with `customerComment` and `internalNote`

<hr>

## 2016-01-21

### Changes with software release 6.17.38

#### <i class="fa fa-plus"></i> New

* [`GET` sales](https://developer.epages.com/apps/api-reference/get-shops-shopid-sales.html)

<hr>

## 2016-01-19

### Changes with software release 6.17.37

#### <i class="fa fa-pencil"></i> Update

* Added date range filters `createdBefore` and `createdAfter` to query parameters of [`GET` orders](https://developer.epages.com/apps/api-reference/get-shops-shopid-orders.html#query-parameters)
