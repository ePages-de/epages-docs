---
layout: docs
key: api-change-log
title: API Change Log
version: v1
---

This change log covers significant updates and changes to the ePages REST API.
In order to keep track of these changes we recommend you to follow [@epagesdevs](https://twitter.com/epagesdevs) on Twitter or subscribe to our [RSS feed for the API Change Log](https://developer.epages.com/apps/feed.xml).

**2017-05-30: We have achieved the desired functional range of the REST API.
Feature-free releases won't be reported anymore.
Of course, we will continue to inform you if there are any breaking changes to the API.**

<hr>

## 2019-07-04

### Changes with software release 7.37.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added attributes `height`, `width`, and `fileSize` to data type [`image`](https://developer.epages.com/apps/data-types.html#image).

<hr>

## 2019-05-27

### Changes with software release 7.36.0

#### <i class="fas fa-plus"></i> New

* [`POST`search/products](https://developer.epages.com/apps/api-reference/post-shopid-search-products.html)

<hr>

## 2019-04-25

### Changes with software release 7.35.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added attribute `isZoomEnabled` to data type [`image`](https://developer.epages.com/apps/data-types.html#image).

* Added attributes `productVariationMasterId` and `productVariationMasterName` to data type [`product`](https://developer.epages.com/apps/data-types.html#product).

<hr>

## 2019-02-21

### Changes with software release 7.34.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added attribute `displayName` to data type [`variationIdentifier`](https://developer.epages.com/apps/data-types.html#variationidentifier).

* Added attribute `displayValue` to data type [`variationIdentifier`](https://developer.epages.com/apps/data-types.html#variationidentifier).

<hr>

## 2019-02-06

### Changes with software release 7.33.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added query parameter `hasAddressData` to [`GET`carts](https://developer.epages.com/apps/api-reference/get-shopid-carts.html).

<hr>

## 2019-01-15

### Changes with software release 7.32.0

#### <i class="fas fa-plus"></i> New

* [`GET`carts](https://developer.epages.com/apps/api-reference/get-shopid-carts.html)

#### <i class="fas fa-pencil-alt"></i> Update

* Added attribute `creationDate` to data type [`cart`](https://developer.epages.com/apps/data-types.html#cart).

* Added attribute `documentPdf` to data type [`orderDocument`](https://developer.epages.com/apps/data-types.html#orderdocument).

* Added query parameter `includePdf` to [`GET`orders/{orderId}/documents](https://developer.epages.com/apps/api-reference/get-shopid-orders-orderid-documents.html).

* Added attribute `issueDate` to data type [`orderDocument`](https://developer.epages.com/apps/data-types.html#orderdocument).

<hr>

## 2018-12-13

### Changes with software release 7.30.0

#### <i class="fas fa-plus"></i> New

* Added `Events` section. This section explains how applications can [receive information about customer actions in ePages online shops](https://developer.epages.com/apps/events.html).

#### <i class="fas fa-pencil-alt"></i> Update

* Added attribute `lowestPrice` to data type [`priceInfo`](https://developer.epages.com/apps/data-types.html#priceinfo).
* Updated description of query parameter `updatedFrom` in [`GET` orders](https://developer.epages.com/apps/api-reference/get-shopid-orders.html).

<hr>

## 2018-10-18

### Changes with software release 7.29.0

#### <i class="fas fa-plus"></i> New

* Added `carts:add`[event](https://developer.epages.com/apps/events.html).

<hr>

## 2018-08-22

### Changes with software release 7.28.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added attribute `registerSessionUrl` to data type [`cart`](https://developer.epages.com/apps/data-types.html#cart).

<hr>

## 2018-08-02

### Changes with software release 7.27.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added attribute `providerName` to data type [`paymentMethodInfo`](https://developer.epages.com/apps/data-types.html#paymentmethodinfo).
* Added attribute `transactionId` to data type [`paymentData`](https://developer.epages.com/apps/data-types.html#paymentdata).

<hr>

## 2018-07-25

### Changes with software release 7.26.0

#### <i class="fas fa-plus"></i> New

* Added `pageview`, `product`, and `category` [events](https://developer.epages.com/apps/events.html).

<hr>

## 2018-04-27

### Changes with software release 7.24.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added attribute `videos` to data type [`product`](https://developer.epages.com/apps/data-types.html#product).

<hr>

## 2018-04-10

### Changes with software release 7.23.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added attribute `noTaxesMessage` to data type [`taxModel`](https://developer.epages.com/apps/data-types.html#taxmodel).

<hr>

## 2018-03-29

### Changes with software release 7.22.0

#### <i class="fas fa-plus"></i> New

* [`GET`products/{productId}/crossselling](https://developer.epages.com/apps/api-reference/get-shopid-products-productid-crossselling.html)

<hr>

## 2018-02-07

### Changes with software release 7.21.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added attribute `energyLabelsMaxEfficiencyString` to data type [`product`](https://developer.epages.com/apps/data-types.html#product).
* Added attributes `energyLabelsString`, `energyLabelsMaxEfficiencyString` and `energyLabelSourceFile` to [`productLineItem`](https://developer.epages.com/apps/data-types.html#productlineitem).

<hr>

## 2017-12-11

### Changes with software release 7.17.0

#### <i class="fas fa-plus"></i> New

* [`GET`orders/{orderId}/documents](https://developer.epages.com/apps/api-reference/get-shopid-orders-orderid-documents.html)
* Added data type [`orderDocument`](https://developer.epages.com/apps/data-types.html#orderdocument).

## 2017-07-25

### Changes with software release 7.12.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added attribute `lineItemCouponDiscount` to data type [`productLineItem`](https://developer.epages.com/apps/data-types.html#productlineitem).

<hr>

## 2017-06-29

### Changes with software release 7.11.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added attributes `couponCampaignId` and `validationErrors` to data type [`couponLineItem`](https://developer.epages.com/apps/data-types.html#couponlineitem).
* Added attribute `title` to data type [`product`](https://developer.epages.com/apps/data-types.html#product).

<hr>

## 2017-05-11

### Changes with software release 7.8.0

* None.

<hr>

## 2017-05-04

### Changes with software release 7.7.0

* None.

<hr>

## 2017-03-29

### Changes with software release 7.6.0

#### <i class="fas fa-plus"></i> New

* `POST` webhooks
* `GET` webhooks/{webhookId}
* `POST` webhooks/{webhookId}
* `DELETE` webhooks/{webhookId}

#### <i class="fas fa-pencil-alt"></i> Update

* Added query parameter [`signature`](page:apps-install#3-receive-authorisation-code) as a message authentification code for the app authorization process.

<hr>

## 2017-03-10

### Changes with software release 7.5.0

#### <i class="fas fa-plus"></i> New

* [`GET` script-tags](https://developer.epages.com/apps/api-reference/get-shopid-script-tags.html)
* [`POST` script-tags](https://developer.epages.com/apps/api-reference/post-shopid-script-tags.html)
* [`DELETE` script-tags/{scriptTagId}](https://developer.epages.com/apps/api-reference/delete-shopid-script-tags-scripttagid.html)

#### <i class="fas fa-pencil-alt"></i> Update

* Added attribute `email` to data type [`shopInfo`](https://developer.epages.com/apps/data-types.html#shopinfo).

<hr>

## 2017-02-09

### Changes with software release 7.4.0

#### <i class="fas fa-pencil-alt"></i> Update

* Until version 7.3.0 the merchant could create a page type "Category" with an ID such as "Shipping" or "Payment". This page was mapped with the [`GET` legal/shipping-information](https://developer.epages.com/apps/api-reference/get-shopid-legal-shipping-information) and [`PUT` legal/shipping-information](https://developer.epages.com/apps/api-reference/put-shopid-legal-shipping-information) requests. With version 7.4.0, a new page type "Payment & Shipping" has been introduced in the administration area of the ePages shop system that these legal calls have been mapped to. If the merchant did not create a new shipping information page via the new page type, the response to these calls will be empty.

* Introduced cart token `X-epages-Cart-Token` for all cart resources, see [Response headers](page:apps-response-headers). The app scopes `carts_read`and `carts_write` have been deprecated at the same time.

<hr>

## 2017-01-30

### Changes with software release 7.3.0

#### <i class="fas fa-plus"></i> New

* [`GET` tax-model](https://developer.epages.com/apps/api-reference/get-shopid-tax-model.html)
* Added [App Scopes](https://developer.epages.com/apps/app-scopes.html) to the `Getting Started` section.
* Added `Custom apps` section. This section explains how to [create a custom app](page:apps-create-custom) for a specific shop.

#### <i class="fas fa-pencil-alt"></i> Update

* Developer apps have been renamed to Private apps. The chapter [Create an app](page:apps-create) in the section `Developing an app` has been refactored and updated.

<hr>

## 2016-12-21

### Changes with software release 7.2.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added further attributes to data type [`address`](https://developer.epages.com/apps/data-types.html#address).
* Added attribute `taxes` to data types [`paymentData`](https://developer.epages.com/apps/data-types.html#paymentdata) and [`shippingData`](https://developer.epages.com/apps/data-types.html#shippingdata).
* Added `includeInvisible` query parameter to [`GET` categories](https://developer.epages.com/apps/api-reference/get-shopid-categories.html) and [`GET` categories/{categoryId}](https://developer.epages.com/apps/api-reference/get-shopid-categories-categoryid.html).

<hr>

## 2016-11-16

### Changes with software release 7.1.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added `visible` attribute to data types [`category`](https://developer.epages.com/apps/data-types.html#category) and [`category (create request)`](https://developer.epages.com/apps/data-types.html#category-create-request).
* Added attributes `deposits`, `ecoParticipations`, `shippingOptions` and `basketDiscount` to data type [`lineItemContainer`](https://developer.epages.com/apps/data-types.html#lineitemcontainer).

<hr>

## 2016-10-25

### Changes with software release 7.0.0

#### <i class="fas fa-pencil-alt"></i> Update

* Added `status` attribute to data type [`paymentData`](https://developer.epages.com/apps/data-types.html#paymentdata).

<hr>

## 2016-10-13

### Changes with software release 6.17.53

* None.

<hr>

## 2016-09-13

### Changes with software release 6.17.52

#### <i class="fas fa-pencil-alt"></i> Update

* Added response code [*410 Gone*](https://developer.epages.com/apps/response-codes#responses-in-the-4xx-range).
* Required to set user agent in [request header](https://developer.epages.com/apps/request-headers).
* Specified attributes `stocklevel`, `depositPrice`, and `manufacturerPrice` for [`POST` products](https://developer.epages.com/apps/api-reference/post-shopid-products.html).
* Added attributes `manufacturerProductNumber`, `minStocklevel`, `productLength`, `productHeight`, `productWidth` `productVariationType`, and `productVariationSelection` to data type [`product`](https://developer.epages.com/apps/data-types.html#product).
* Added data type [`variationIdentifier`](https://developer.epages.com/apps/data-types.html#variationidentifier).
* Removed `products_write` authorisation from `stocklevel` attribute.
* Added query parameter `includeInvisible` to [`GET` products](https://developer.epages.com/apps/api-reference/get-shopid-products.html).
* Localized attribute `name` in `productLineItems` in [`GET` orders/{orderId}](https://developer.epages.com/apps/api-reference/get-shopid-orders-orderid.html).

#### <i class="fa fa-minus"></i> Remove

* Removed attributes `energyLabelsString` and `ecoParticipationPrice` from [`POST` products](https://developer.epages.com/apps/api-reference/post-shopid-products.html) and [`PATCH` products/{productId}](https://developer.epages.com/apps/api-reference/patch-shopid-products-productid.html).

<hr>

## 2016-08-25

### Changes with software release 6.17.51

#### <i class="fas fa-plus"></i> New

* Implemented menu selection for software release version.

#### <i class="fas fa-pencil-alt"></i> Update

* Added data type [`deliveryWeightQuantity`](https://developer.epages.com/apps/data-types.html#deliveryweightquantity).
* Updated data type [`quantity`](https://developer.epages.com/apps/data-types.html#quantity).
* Updated description of query parameter `updatedFrom` in [`GET` orders](https://developer.epages.com/apps/api-reference/get-shopid-orders.html).
* Updated description of [`PATCH` orders/{orderId}](https://developer.epages.com/apps/api-reference/patch-shopid-orders-orderid.html).
* Added response code [*409 Conflict*](https://developer.epages.com/apps/response-codes#responses-in-the-4xx-range.html).
* Updated description of `customerNumber` attribute of data type [`customer (create request)`](https://developer.epages.com/apps/data-types.html#customer-create-request).

#### <i class="fa fa-minus"></i> Remove

* Removed slideshow link from [`GET` products](https://developer.epages.com/apps/api-reference/get-shopid-products.html).
* Removed `shippingMethodsRestrictedTo` attribute from [`GET` products](https://developer.epages.com/apps/api-reference/get-shopid-products.html).

<hr>

## 2016-07-26

### Changes with software release 6.17.50

* None.

<hr>

## 2016-07-13

### Changes with software release 6.17.49

#### <i class="fas fa-plus"></i> New

* [`POST` carts/{cartId}/coupon](https://developer.epages.com/apps/api-reference/post-shopid-carts-cartid-coupon.html)
* [`DELETE` carts/{cartId}/coupon/{couponLineItemId}](https://developer.epages.com/apps/api-reference/delete-shopid-carts-cartid-coupon-couponlineitemid.html)
* [`POST` product-category-assignments](https://developer.epages.com/apps/api-reference/post-shopid-product-category-assignments.html)
* [`DELETE` product-category-assignments](https://developer.epages.com/apps/api-reference/delete-shopid-product-category-assignments.html)
* [`GET` tax-classes](https://developer.epages.com/apps/api-reference/get-shopid-tax-classes.html)
* [`GET` tax-classes/{taxClassId}](https://developer.epages.com/apps/api-reference/get-shopid-tax-classes-taxclassid.html)

#### <i class="fas fa-pencil-alt"></i> Update

* Changed `minCart` attribute to [`minimumCart`](https://developer.epages.com/apps/data-types.html#minimumcart).
* Added `taxClassId` attribute to cart responses, where missing.
* Added `deliveryWeight` attribute to data type [`productLineItem`](https://developer.epages.com/apps/data-types.html#productlineitem).
* Added `couponLineItem` attribute to data type [`lineItemContainer`](https://developer.epages.com/apps/data-types.html#lineitemcontainer).
* Renamed data type `taxClass` to [`taxClassInfo`](https://developer.epages.com/apps/data-types.html#taxclassinfo).
* Added data type [`taxClass`](https://developer.epages.com/apps/data-types.html#taxclass).

<hr>

## 2016-06-21

### Changes with software release 6.17.48

#### <i class="fas fa-plus"></i> New

* [`GET` categories/{categoryId}/sequence](https://developer.epages.com/apps/api-reference/get-shopid-categories-categoryid-sequence.html)
* [`PUT` categories/{categoryId}/sequence](https://developer.epages.com/apps/api-reference/put-shopid-categories-categoryid-sequence.html)
* [`POST` categories/{categoryId}](https://developer.epages.com/apps/api-reference/post-shopid-categories-categoryid.html)
* [`DELETE` categories/{categoryId}](https://developer.epages.com/apps/api-reference/delete-shopid-categories-categoryid.html)

#### <i class="fas fa-pencil-alt"></i> Update

* Changed `minCartValue` attribute to `minCart` and expanded its attributes.
* Added `taxClassId` attribute to data type [`taxClass`](https://developer.epages.com/apps/data-types.html#taxclass).
* Added attributes `partiallyDispatchedOn`, `partiallyPaidOn` and `partiallyInvoicedOn` to data type [`order`](https://developer.epages.com/apps/data-types.html#order).

#### <i class="fa fa-minus"></i> Remove

* `GET` products/{productId}/categories: This endpoint will no longer be supported. Please use [`GET` categories](https://developer.epages.com/apps/api-reference/get-shopid-categories.html) by applying the query parameter `productId`.

<hr>

## 2016-06-03

### Changes with software release 6.17.47

#### <i class="fas fa-pencil-alt"></i> Update

* Added `stocklevel` attribute to  all **product** calls with data type [`product`](https://developer.epages.com/apps/data-types.html#product).
* Added `shippingMethod` link to all **carts** calls that include the `shippingData` attribute.
* Added `taxClass` attribute to data type [`product`](https://developer.epages.com/apps/data-types.html#productlineitem).
* Added `visible` attribute to data type [`product`](https://developer.epages.com/apps/data-types.html#product).

<hr>

## 2016-05-23

### Changes with software release 6.17.46

#### <i class="fas fa-plus"></i> New

* [`POST` categories/{categoryId}](https://developer.epages.com/apps/api-reference/post-shopid-categories-categoryid.html)

#### <i class="fas fa-pencil-alt"></i> Update

* Added `deliveryPeriod` attribute to [`GET` products](https://developer.epages.com/apps/api-reference/get-shopid-products.html), [`GET` products/{productId}](https://developer.epages.com/apps/api-reference/get-shopid-products-productid.html), [`GET` products/updated/{productProperty}](https://developer.epages.com/apps/api-reference/get-shopid-products-updated-productproperty.html), [`PATCH` products/{productId}](https://developer.epages.com/apps/api-reference/patch-shopid-products-productid.html) and [`POST` products](https://developer.epages.com/apps/api-reference/post-shopid-products.html).

<hr>

## 2016-04-27

### Changes with software release 6.17.45

#### <i class="fas fa-pencil-alt"></i> Update

* Added `createdAfter` and `createdBefore` attributes to [`GET` sales](https://developer.epages.com/apps/api-reference/get-shopid-sales.html).

<hr>

## 2016-04-20

### Changes with software release 6.17.44

#### <i class="fas fa-plus"></i> New

* [`GET` newsletter-campaigns](https://developer.epages.com/apps/api-reference/get-shopid-newsletter-campaigns.html)
* [`GET` newsletter-campaigns/{campaignId}subscribers](https://developer.epages.com/apps/api-reference/get-shopid-newsletter-campaigns-campaignid-subscribers.html)

<hr>

## 2016-04-11

### Changes with software release 6.17.43

#### <i class="fas fa-plus"></i> New

* [`POST` products](https://developer.epages.com/apps/api-reference/post-shopid-products.html)
* [`GET` watched-products](https://developer.epages.com/apps/api-reference/get-shopid-watched-products.html)
* [`GET` customers](https://developer.epages.com/apps/api-reference/get-shopid-customers.html)
* [`POST` carts/{cartId}/order](https://developer.epages.com/apps/api-reference/post-shopid-carts-cartid-order.html)

#### <i class="fas fa-pencil-alt"></i> Update

* Added `taxClass` attribute to [`GET` products/{productId}](https://developer.epages.com/apps/api-reference/get-shopid-products-productid.html).
* Added `stocklevel` attribute to [`GET` products/{productId}](https://developer.epages.com/apps/api-reference/get-shopid-products-productid.html) and [`PATCH` products/{productId}](https://developer.epages.com/apps/api-reference/patch-shopid-products-productid.html) for requests with *products_write* scope.

#### <i class="fa fa-minus"></i> Remove

* `PUT` orders/{orderId}: This endpoint will no longer be supported. Please use [`PATCH` orders/{orderId}](https://developer.epages.com/apps/api-reference/patch-shopid-orders-orderid.html).
* `GET` products/{productId}/stock-level: This endpoint will no longer be supported. Please use [`GET` products/{productId}](https://developer.epages.com/apps/api-reference/get-shopid-products-productid.html).
* `PUT` products/{productId}/stock-level: This endpoint will no longer be supported. Please use [`PATCH` products/{productId}](https://developer.epages.com/apps/api-reference/patch-shopid-products-productid.html).

<hr>

## 2016-03-07

### Changes with software release 6.17.42

#### <i class="fas fa-plus"></i> New

* [`POST` customers](https://developer.epages.com/apps/api-reference/post-shopid-customers.html)
* [`GET` customers/{customerId}](https://developer.epages.com/apps/api-reference/get-shopid-customers-customerid.html)
* [`PATCH` customers/{customerId}](https://developer.epages.com/apps/api-reference/patch-shopid-customers-customerid.html)
* [`PATCH` orders/{orderId}](https://developer.epages.com/apps/api-reference/patch-shopid-orders-orderid.html)

#### <i class="fas fa-pencil-alt"></i> Update

* Added `main-category` link to [`GET` products/{productId}](https://developer.epages.com/apps/api-reference/get-shopid-products-productid.html).

<hr>

## 2016-02-25

### Changes with software release 6.17.41

#### <i class="fas fa-plus"></i> New

* [`GET` products/updated/{productProperty}](https://developer.epages.com/apps/api-reference/get-shopid-products-updated-productproperty.html)

#### <i class="fas fa-pencil-alt"></i> Update

* Renamed attribute `cancelledOn` to `rejectedOn` as well as attribute `shippedOn` to `deliveredOn` within **orders** calls.
* Added attribute `customerNumber` to [`GET` orders](https://developer.epages.com/apps/api-reference/get-shopid-orders.html) and [`GET` orders/{orderId}](https://developer.epages.com/apps/api-reference/get-shopid-orders-orderid.html).

<hr>

## 2016-02-18

### Changes with software release 6.17.40

* None.

<hr>

## 2016-02-09

### Changes with software release 6.17.39

#### <i class="fas fa-plus"></i> New

* [`GET` {shopId}](https://developer.epages.com/apps/api-reference/get-shopid.html)
* [`PATCH` products/{productId}](https://developer.epages.com/apps/api-reference/patch-shopid-products-productid.html)
* [`POST` products/{productId}/slideshow](https://developer.epages.com/apps/api-reference/post-shopid-products-productid-slideshow.html)
* [`GET` products/{productId}/slideshow/sequence](https://developer.epages.com/apps/api-reference/get-shopid-products-productid-slideshow-sequence.html)
* [`DELETE` products/{productId}/slideshow/{imageName}](https://developer.epages.com/apps/api-reference/delete-shopid-products-productid-slideshow-imagename.html)
* [`PUT` products/{productId}/slideshow/sequence](https://developer.epages.com/apps/api-reference/put-shopid-products-productid-slideshow-sequence.html)

#### <i class="fas fa-pencil-alt"></i> Update

* Added `productImage` attribute.
* Added new attributes `shippingData` and `paymentData` to orders.
* Replaced attribute `comment` with `customerComment` and `internalNote`.

<hr>

## 2016-01-21

### Changes with software release 6.17.38

#### <i class="fas fa-plus"></i> New

* [`GET` sales](https://developer.epages.com/apps/api-reference/get-shopid-sales.html)

<hr>

## 2016-01-19

### Changes with software release 6.17.37

#### <i class="fas fa-pencil-alt"></i> Update

* Added date range filters `createdBefore` and `createdAfter` to query parameters of [`GET` orders](https://developer.epages.com/apps/api-reference/get-shopid-orders.html#query-parameters).
