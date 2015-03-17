---
layout: page
key: apps-media-type
title: Media type
---

The ePages API supports requests and responses in JSON only. Requests have to be encoded using the UTF-8 character set.

# Request content type

When making a call that contains a body, the content type to be sent has to be specified in the `Content-Type` header. To send a JSON body the header would be: `Content-Type: application/json`.

# Response content type

You can specify the content you would like to receive in an `Accept` header, e.g. `Accept: application/json`.

# Request structure

The body of a JSON request is an object containing a set of key-value pairs. A simple JSON object could look like this:

{% highlight json %}
{
    "productId": "54DBCA3D-8206-F601-3A43-AC13320B0202",
    "name": "jacket",
    "description": "Weatherproof."
}
{% endhighlight %}

# Response structure

Responses have a similar structure as requests. If a request returns a single object, the response will also contain a single object including the fields for that resource. The response will contain links to available sub-resources, e.g. product images.

{% highlight json %}
{
    "productId": "54DBCA3D-8206-F601-3A43-AC13320B0202",
    "name": "Berghaus Paclite Jacket - Men",
    "shortDescription": "Weatherproof. Small pack size. Ultra light.",
    "description": "Weatherproof and compact. Ultra light. Outer material: 100% Ripstop nylon.",
    "images": [
        {
            "url": "http://epagesj-vm02/WebRoot/Store/Shops/DemoShop/Products/be_404/be_404_blue_h.jpg",
            "classifier": "HotDeal"
        },
        {
            "url": "http://epagesj-vm02/WebRoot/Store/Shops/DemoShop/Products/be_404/be_404_blue.jpg",
            "classifier": "Large"
        },
        {
            "url": "http://epagesj-vm02/WebRoot/Store/Shops/DemoShop/Products/be_404/be_404_blue_xs.jpg",
            "classifier": "Thumbnail"
        }
    ],
    "priceInfo": {
        "quantity": {
            "amount": 1,
            "unit": "piece(s)"
        },
        "price": {
            "taxType": "GROSS",
            "formatted": "199.95 €",
            "amount": 199.95,
            "currency": "EUR"
        },
        "depositPrice": null,
        "ecoParticipationPrice": null,
        "priceWithDeposits": {
            "taxType": "GROSS",
            "formatted": "199.95 €",
            "amount": 199.95,
            "currency": "EUR"
        },
}
{% endhighlight %}
