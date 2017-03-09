---
layout: page
key: apps-use-cases
title: Use cases
---

You plan an integration with ePages?
That's great!
Here are some use cases we can think of.
Need more information on implementing a specific use case?
Click [here](page:apps-implement-use-case).

## Social Commerce

Build an application that show cases products on social media platforms like Facebook, integrates products on a blogging platform or on any given site with a widget.

Suggested calls: [`GET` products](page:apps-api-get-shopid-products-information), [`GET` categories](page:apps-api-get-shopid-categories-information)

Optional calls: [`POST` carts](page:apps-api-post-shopid-carts-information), [`PUT` carts/{cartId}/line-items/{lineItemId}](page:apps-api-put-shopid-carts-cartid-line-items-lineitemid-information), [`GET` legal](page:apps-api-get-shopid-legal-information)

Availability: <i class="fa fa-check"></i>

## Portal Engines

Build an application that adds products to price comparison or shopping portals.

Suggested calls: [`GET` products](page:apps-api-get-shopid-products-information) (batch)

Optional calls: [`GET` categories](page:apps-api-get-shopid-categories-information)

Availability: <i class="fa fa-check"></i>

## Shipping

Build an application that allows you to print shipping labels and to control the status of an order.

Suggested calls: [`GET` orders](page:apps-api-get-shopid-orders-information), [`PATCH` orders/{orderId}](page:apps-api-patch-shopid-orders-orderid-information)

Optional calls: [`GET` products](page:apps-api-get-shopid-products-information)

Availability: <i class="fa fa-check"></i>

## Accounting

Build an application that allows you to manage and process orders.

Suggested calls: [`GET` orders](page:apps-api-get-shopid-orders-information), [`PATCH` orders/{orderId}](page:apps-api-patch-shopid-orders-orderid-information)

Optional calls: [`GET` products](page:apps-api-get-shopid-products-information)

Availability: <i class="fa fa-check"></i>

## Content Optimisation and Marketing

Build an application that optimizes or enhances the content of product or category descriptions for Search Engine Optimization (SEO), for general marketing purposes or to add translations to all descriptive content.

Suggested calls: [`GET` products](page:apps-api-get-shopid-products-information), [`PATCH` products/{productId}](page:apps-api-patch-shopid-products-productid-information), [`GET` categories](page:apps-api-get-shopid-categories-information), [`PUT` categories/{categoryId}](page:apps-api-put-shopid-categories-categoryid-information)

Availability: <i class="fa fa-check"></i>

## Legal Service

Build an application that provides up-to-date legal information (imprint, terms and conditions, etc.) automatically.

Suggested calls: [`GET` legal](page:apps-api-get-shopid-legal-information), [`PUT` legal/contact-information](page:apps-api-put-shopid-legal-contact-information-information), [`PUT` legal/privacy-policy](page:apps-api-put-shopid-legal-privacy-policy-information), [`PUT` legal/terms-and-conditions](page:apps-api-put-shopid-legal-terms-and-conditions-information), [`PUT` legal/rights-of-withdrawal](page:apps-api-put-shopid-legal-rights-of-withdrawal-information), [`PUT` legal/shipping-information](page:apps-api-put-shopid-legal-shipping-information-information)

Availability: <i class="fa fa-check"></i>

## Basic Point of Sale (POS)/Marketplace

Build an application that automatically updates the stock level of a product upon a POS/Marketplace sale.

Suggested calls: [`GET` products](page:apps-api-get-shopid-products-information), [`GET` products/{productId}](page:apps-api-get-shopid-products-productid-information), [`PATCH` products/{productId}](page:apps-api-patch-shopid-products-productid-information)

Optional calls: [`GET` categories](page:apps-api-get-shopid-categories-information)

Availability: <i class="fa fa-check"></i>

## Sales Analytics

Build an application that allows to determine top selling products, top customers, top regions or optimize cross-selling products by evaluating orders.

Suggested calls: [`GET` products](page:apps-api-get-shopid-products-information), [`GET` orders](page:apps-api-get-shopid-orders-information), [`GET` categories](page:apps-api-get-shopid-categories-information), [`GET` sales](page:apps-api-get-shopid-sales-information)

Availability: <i class="fa fa-check"></i>

## Image Service

Build an application that provides the ability to get images for a product, upload improved images, delete old images or set the default product image as well as reorder the slideshow.

Suggested calls: [`GET` products](page:apps-api-get-shopid-products-information), [`PATCH` products/{productId}](page:apps-api-patch-shopid-products-productid-information), [`GET` products/{productId}/slideshow](page:apps-api-get-shopid-products-productid-slideshow-information), [`POST` products/{productId}/slideshow](page:apps-api-post-shopid-products-productid-slideshow-information), [`DELETE` products/{productId}/slideshow/{imageName}](page:apps-api-delete-shopid-products-productid-slideshow-imagename-information), [`GET` products/{productId}/slideshow/sequence](page:apps-api-get-shopid-products-productid-slideshow-sequence-information), [`PUT` products/{productId}/slideshow/sequence](page:apps-api-put-shopid-products-productid-slideshow-sequence-information)

Availability: <i class="fa fa-check"></i>

Need more support?
Click [here](page:apps-implement-use-case).

## Advanced Point of Sale (POS)/Marketplace

Build an application that automatically updates the stock level of a product upon a POS/Marketplace sale and allows to create and manage customers and orders.

Suggested calls: [`GET` products](page:apps-api-get-shopid-products-information), [`PATCH` products/{productId}](page:apps-api-patch-shopid-products-productid-information), [`GET` customers](page:apps-api-get-shopid-customers-customerid-information), [`PATCH` customers/{customerId}](page:apps-api-patch-shopid-customers-customerid-information), [`POST` customers](page:apps-api-post-shopid-customers-information), [`GET` orders](page:apps-api-get-shopid-orders-information), [`PATCH` orders/{orderId}](page:apps-api-patch-shopid-orders-orderid-information), [`POST` carts/{cartId}/order](page:apps-api-post-shopid-carts-cartid-order-information)

Optional calls: [`GET` categories](page:apps-api-get-shopid-categories-information)

Availability: <i class="fa fa-check"></i>

## Customer Relationship Management (CRM) and Newsletters

Build an application that analyzes and groups/targets customers by ordered products and/or newsletter preferences and generates personalized newsletters accordingly.

Suggested calls: [`GET` customers](page:apps-api-get-shopid-customers-customerid-information), [`PATCH` customers/{customerId}](page:apps-api-patch-shopid-customers-customerid-information), [`POST` customers](page:apps-api-post-shopid-customers-information), [`GET` orders](page:apps-api-get-shopid-orders-information), [`GET` products](page:apps-api-get-shopid-products-information), [`GET` newsletter-campaigns](page:apps-api-get-shopid-newsletter-campaigns-information), [`GET` newsletter-campaigns/{campaignId}/subscribers](page:apps-api-get-shopid-newsletter-campaigns-campaignid-subscribers-information)

Availability: <i class="fa fa-check"></i>

## Enterprise Management Systems (EMS)

Build an application that manages products, customers and orders as well as handles fulfillment, accounting and customer support.

Suggested calls: [`GET` products](page:apps-api-get-shopid-products-information), [`PATCH` products/{productId}](page:apps-api-patch-shopid-products-productid-information), [`POST` products](page:apps-api-post-shopid-products-information), [`DELETE` products/{productId}](page:apps-api-delete-shopid-products-productid-information), [`GET` customers](page:apps-api-get-shopid-customers-customerid-information), [`PATCH` customers/{customerId}](page:apps-api-patch-shopid-customers-customerid-information), [`POST` customers](page:apps-api-post-shopid-customers-information), [`GET` orders](page:apps-api-get-shopid-orders-information), [`PATCH` orders/{orderId}](page:apps-api-patch-shopid-orders-orderid-information), [`POST` categories/{categoryId}](page:apps-api-post-shopid-categories-categoryid-information), [`POST` carts/{cartId}/order](page:apps-api-post-shopid-carts-cartid-order-information)

Optional calls: [`GET` categories](page:apps-api-get-shopid-categories-information)

Availability: <i class="fa fa-check"></i>

## Basic Storefront Apps

Implement different types of social media buttons, a live chat to interact with customers or place badges into a shop's storefront.

Suggested calls: [`GET` script-tags](page:apps-api-get-shopid-script-tags-information), [`POST` script-tags](page:apps-api-post-shopid-script-tags-information), [`DELETE` script-tags/{scriptTagId}](page:apps-api-delete-shopid-script-tags-scripttagid-information)

Availability: <i class="fa fa-check"></i>
