---
layout: post
title: "Payment integrations"
date: "2015-11-03 09:00:00"
image: blog-header/money.jpg
categories: tech-stories
authors: ["Xavi"]
---

Bank transfers and credit cards aren't the only payment methods available when buying a product from an ePages shop.
Unlike in the real world, online shopping offers a much wider range of possibilities and solutions such as [Ingenico](http://www.ingenico.com/), [Skrill](https://www.skrill.com/en/) or [Klarna](https://www.klarna.com/us), which can be used to purchase products from our shops.

## General overview

The following procedure describes the process of buying a product:

1. A customer browses an ePages shop and finds a product they want to buy.
2. The customer adds that product to a basket and starts the check out process.
3. After choosing payment and shipping methods, the customer is redirected to an external site where they can complete the payment.
4. Finally, the customer is redirected back to the ePages shop, where they are informed about the status of their order.

That external site mentioned above belongs to a specific payment method - the one that was chosen by the customer from those that are offered in the shop. The Payment method needs to know what is being bought so that payment can be completed.
In order to do that, we need to create connectors, which allow ePages and the payment method to communicate with each other.

## Payment flow

{% image blog/blog-payment-integrations.png %}

A payment flow will normally consist of at least the following elements or steps: create payment, redirect to gateway, backlink and callback.

* **Create payment.**
At this point we need to take a look at the documentation of the given payment method to know what parameters are expected, that is, how we can communicate with each other.
Afterwards, we need to collect all required information, such as price, products or chosen shipping method, and send it to the payment method.
* **Redirect to payment gateway.**
The customer is then redirected to an external site which belongs to their chosen payment method.
There they will need to fill in some data and complete the payment.
* **Backlink.** After completing the payment, the customer will be redirected back to the shop.
The page where they will land is defined on a message called “backlink”.
For instance, if some kind of problem arose, backlink will point to a page where an error message is shown.
However, if the payment was successful, the customer will see a page that will inform them of that fact.
* **Callback.** The payment method will also send an asynchronous message to ePages to notify the status of the order.
For example, if an order has already been paid and the payment has been confirmed, the callback message will contain this information and ePages will set the order to paid in the shop.

## SOAP vs REST Callouts

Communication with payment methods is carried out either via SOAP or REST calls.
Using one or the other affects the architecture and flow of a connector.

On the one hand, when using SOAP, we create a hash structure containing all information which we need to send.
Then, we use a library to generate our SOAP request using the hash structure.
We also provide this library with a WSDL file, which describes the structure of SOAP messages, and an XSD file, which is used to verify the correctness of the message.

On the other hand, REST communication is done by means of an additional communication layer.
First, we build a DTO or Data Transfer Object, which contains all information that will be sent to the payment method.
Then, we use a REST call to send this DTO to our communication layer, who is responsible for assembling and formatting the data it received so that payment methods can understand it.
Finally, the communication layer sends the new structure to the payment method, that should complete the payment.

Responses are handled similarly. If we use SOAP for our requests, we expect SOAP responses.
Similarly, REST requests require REST responses.

## So... is that it?

Well, no, not really.
Each payment method is implemented differently.
Therefore, we need to create a specific connector for each of them.
However, they also have lots of things in common, some of which are explained in this article.
