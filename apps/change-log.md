---
layout: page
key: api-change-log
title: API Change Log
version: v1
---

This change log covers significant updates and changes to the ePages REST API.
In order to keep track of these changes we recommend you to follow [@epagesdevs](https://twitter.com/epagesdevs) on Twitter or subscribe to our [RSS feed for the API Change Log](https://developer.epages.com/apps/feed.xml).

| Date      | Description      | Available with software release  |
|---------------|---------------| -------|----------|
| 2016&#8209;02&#8209;09 | Added new endpoint: | 6.17.39 |
| |[`GET` shop information](page:apps-api-get-shops-shopid-information) | |
| | Added new attributes `shippingData` and `paymentData` to orders. | |
| | Replaced attribute `comment` with `customerComment` and `internalNote`. | |
| 2016&#8209;02&#8209;04 | Added new endpoints: | 6.17.39 |
| |[`PATCH` product](page:apps-api-patch-shops-shopid-products-productid-information) | |
| |[`POST` slideshow](page:apps-api-post-shops-shopid-products-productid-slideshow-information) | |
| |[`DELETE` slideshow/{imageName}](page:apps-api-delete-shops-shopid-products-productid-slideshow-imagename-information) |  |
| |[`GET` slideshow/sequence](page:apps-api-get-shops-shopid-products-productid-slideshow-sequence-information) |  |
| |[`PUT` slideshow/sequence](page:apps-api-put-shops-shopid-products-productid-slideshow-sequence-information) |  |
| | Added `productImage` attribute |  |
| 2016&#8209;01&#8209;21 | Added [`GET` sales](page:apps-api-get-shops-shopid-sales-information) endpoint. | 6.17.38 |
| 2016&#8209;01&#8209;19    | Added date range filters `createdBefore` and `createdAfter` to query parameters of [`GET` orders](page:apps-api-get-shops-shopid-orders-information#query-parameters).  | 6.17.37 |
