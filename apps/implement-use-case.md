---
layout: page
key: apps-implement-use-case
title: Implementing a use case
---

## Image Service

### Uploading a new product image

1. Use the [`POST` products/slideshow](page:apps-api-post-shopid-products-productid-slideshow-information) endpoint to upload a new image to the slideshow of the product.
If you want to replace an existing image, delete that image first using the [`DELETE` products/slideshow/{imageName}](page:apps-api-delete-shopid-products-productid-slideshow-imagename-information) endpoint.

2. After having added a new image to the slideshow, you can assign the image to a product using the [`PATCH` products](page:apps-api-patch-shopid-products-productid-information) endpoint.
Update the product image by addressing the attribute path `productImage`.

Example:
  {% highlight text %}
  [{
    "op": "add",
    "path": "/productImage",
    "value": "product_picture.png"
  }]
  {% endhighlight %}
