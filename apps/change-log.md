---
layout: page
key: api-change-log
title: API Change Log
version: v1
---

This change log covers significant updates and changes to the ePages REST API.
In order to keep track of these changes we recommend you to follow [@epagesdevs](https://twitter.com/epagesdevs) on Twitter or subscribe to our [RSS feed for the API Change Log](https://developer.epages.com/apps/feed.xml).

<hr>

## 2016-07-11

### Changes with software release 6.17.49

#### <i class="fa fa-plus"></i> New

* [`POST` carts/{cartId}/coupon](https://developer.epages.com/apps/api-reference/post-shops-shopid-carts-cartid-coupon.html)
* [`DELETE` carts/{cartId}/coupon/{couponLineItemId}](https://developer.epages.com/apps/api-reference/delete-shops-shopid-carts-cartid-coupon-couponlineitemid.html)
* [`POST` product-category-assignments](https://developer.epages.com/apps/api-reference/post-shops-shopid-product-category-assignments.html)
* [`DELETE` product-category-assignments](https://developer.epages.com/apps/api-reference/delete-shops-shopid-product-category-assignments.html)
* [`GET` tax-classes](https://developer.epages.com/apps/api-reference/get-shops-shopid-tax-classes.html)
* [`GET` tax-classes/{taxClassId}](https://developer.epages.com/apps/api-reference/get-shops-shopid-tax-classes-taxclassid.html)

#### <i class="fa fa-pencil"></i> Update

* Changed `minCart` attribute to [`minimumCart`](https://developer.epages.com/apps/data-types#minimumcart).
* Added `taxClassId` attribute to cart responses, where missing.
* Added `deliveryWeight` attribute to data type [`productLineItem`](https://developer.epages.com/apps/data-types#productlineitem).
* Added `couponLineItem` attribute to data type [`lineItemContainer`](https://developer.epages.com/apps/data-types#lineitemcontainer).

<hr>

## 2016-06-21

### Changes with software release 6.17.48

#### <i class="fa fa-plus"></i> New

* [`GET` categories/{categoryId}/sequence](https://developer.epages.com/apps/api-reference/get-shops-shopid-categories-categoryid-sequence.html)
* [`PUT` categories/{categoryId}/sequence](https://developer.epages.com/apps/api-reference/put-shops-shopid-categories-categoryid-sequence.html)
* [`POST` categories/{categoryId}](https://developer.epages.com/apps/api-reference/post-shops-shopid-categories-categoryid.html)
* [`DELETE` categories/{categoryId}](https://developer.epages.com/apps/api-reference/delete-shops-shopid-categories-categoryid.html)

#### <i class="fa fa-pencil"></i> Update

* Changed `minCartValue` attribute to `minCart` and expanded its attributes.
* Added `taxClassId` attribute to data type [`taxClass`](https://developer.epages.com/apps/data-types#taxclass).
* Added attributes `partiallyDispatchedOn`, `partiallyPaidOn` and `partiallyInvoicedOn` to data type [`order`](https://developer.epages.com/apps/data-types#order).

#### <i class="fa fa-minus"></i> Remove

* `GET` products/{productId}/categories: This endpoint will no longer be supported. Please use [`GET` categories](https://developer.epages.com/apps/api-reference/get-shops-shopid-categories.html) by applying the query parameter `productId`.

<hr>

## 2016-06-03

### Changes with software release 6.17.47

#### <i class="fa fa-pencil"></i> Update

* Added `stocklevel` attribute to  all **product** calls with data type [`product`](https://developer.epages.com/apps/data-types#product).
* Added `shippingMethod` link to all **carts** calls that include the `shippingData` attribute.
* Added `taxClass` attribute to data type [`product`](https://developer.epages.com/apps/data-types#productlineitem).
* Added `visible` attribute to data type [`product`](https://developer.epages.com/apps/data-types#product).

<hr>

## 2016-05-23

### Changes with software release 6.17.46

#### <i class="fa fa-plus"></i> New

* [`POST` categories/{categoryId}](https://developer.epages.com/apps/api-reference/post-shops-shopid-categories-categoryid.html)

#### <i class="fa fa-pencil"></i> Update

* Added `deliveryPeriod` attribute to [`GET` products](https://developer.epages.com/apps/api-reference/get-shops-shopid-products.html), [`GET` products/{productId}](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid.html), [`GET` products/updated/{productProperty}](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-updated-productproperty.html), [`PATCH` products/{productId}](https://developer.epages.com/apps/api-reference/patch-shops-shopid-products-productid.html) and [`POST` products](https://developer.epages.com/apps/api-reference/post-shops-shopid-products.html).

<hr>

## 2016-04-27

### Changes with software release 6.17.45

#### <i class="fa fa-pencil"></i> Update

* Added `createdAfter` and `createdBefore` attributes to [`GET` sales](https://developer.epages.com/apps/api-reference/get-shops-shopid-sales.html).

<hr>

## 2016-04-20

### Changes with software release 6.17.44

#### <i class="fa fa-plus"></i> New

* [`GET` newsletter-campaigns](https://developer.epages.com/apps/api-reference/get-shops-shopid-newsletter-campaigns.html)
* [`GET` newsletter-campaigns/{campaignId}subscribers](https://developer.epages.com/apps/api-reference/get-shops-shopid-newsletter-campaigns-campaignid-subscribers.html)

<hr>

## 2016-04-11

### Changes with software release 6.17.43

#### <i class="fa fa-plus"></i> New

* [`POST` products](https://developer.epages.com/apps/api-reference/post-shops-shopid-products.html)
* [`GET` watched-products](https://developer.epages.com/apps/api-reference/get-shops-shopid-watched-products.html)
* [`GET` customers](https://developer.epages.com/apps/api-reference/get-shops-shopid-customers.html)
* [`POST` carts/{cartId}/order](https://developer.epages.com/apps/api-reference/post-shops-shopid-carts-cartid-order.html)

#### <i class="fa fa-pencil"></i> Update

* Added `taxClass` attribute to [`GET` products/{productId}](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid.html).
* Added `stocklevel` attribute to [`GET` products/{productId}](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid.html) and [`PATCH` products/{productId}](https://developer.epages.com/apps/api-reference/patch-shops-shopid-products-productid.html) for requests with *products_write* scope.

#### <i class="fa fa-minus"></i> Remove

* `PUT` orders/{orderId}: This endpoint will no longer be supported. Please use [`PATCH` orders/{orderId}](https://developer.epages.com/apps/api-reference/patch-shops-shopid-orders-orderid.html).
* `GET` products/{productId}/stock-level: This endpoint will no longer be supported. Please use [`GET` products/{productId}](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid.html).
* `PUT` products/{productId}/stock-level: This endpoint will no longer be supported. Please use [`PATCH` products/{productId}](https://developer.epages.com/apps/api-reference/patch-shops-shopid-products-productid.html).

<hr>

## 2016-03-07

### Changes with software release 6.17.42

#### <i class="fa fa-plus"></i> New

* [`POST` customers](https://developer.epages.com/apps/api-reference/post-shops-shopid-customers.html)
* [`GET` customers/{customerId}](https://developer.epages.com/apps/api-reference/get-shops-shopid-customers-customerid.html)
* [`PATCH` customers/{customerId}](https://developer.epages.com/apps/api-reference/patch-shops-shopid-customers-customerid.html)
* [`PATCH` orders/{orderId}](https://developer.epages.com/apps/api-reference/patch-shops-shopid-orders-orderid.html)

#### <i class="fa fa-pencil"></i> Update

* Added `main-category` link to [`GET` products/{productId}](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-productid.html).

<hr>

## 2016-02-25

### Changes with software release 6.17.41

#### <i class="fa fa-plus"></i> New

* [`GET` products/updated/{productProperty}](https://developer.epages.com/apps/api-reference/get-shops-shopid-products-updated-productproperty.html)

#### <i class="fa fa-pencil"></i> Update

* Renamed attribute `cancelledOn` to `rejectedOn` as well as attribute `shippedOn` to `deliveredOn` within **orders** calls.
* Added attribute `customerNumber` to [`GET` orders](https://developer.epages.com/apps/api-reference/get-shops-shopid-orders.html) and [`GET` orders/{orderId}](https://developer.epages.com/apps/api-reference/get-shops-shopid-orders-orderid.html).

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

* Added `productImage` attribute.
* Added new attributes `shippingData` and `paymentData` to orders.
* Replaced attribute `comment` with `customerComment` and `internalNote`.

<hr>

## 2016-01-21

### Changes with software release 6.17.38

#### <i class="fa fa-plus"></i> New

* [`GET` sales](https://developer.epages.com/apps/api-reference/get-shops-shopid-sales.html)

<hr>

## 2016-01-19

### Changes with software release 6.17.37

#### <i class="fa fa-pencil"></i> Update

* Added date range filters `createdBefore` and `createdAfter` to query parameters of [`GET` orders](https://developer.epages.com/apps/api-reference/get-shops-shopid-orders.html#query-parameters).
