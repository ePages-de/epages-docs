---
layout: docs
key: events
title: Events
---

Events are triggered when a specific action is completed.
This can be helpful, if your app needs specific information, e.g. details of the current page or the fact that a product item is added to the cart.
These events are currently available:

| Event | Type | Description |
| - | - |  - |
| pageview | string | A new page is loaded. Gives information on the path of the new page. |
| product | immutable.js object | A product page is loaded. Gives information on the current product. |
| category | immutable.js object |A category page is loaded. Gives information on the current category and related products.|
| cart:add | immutable.js object | A product was added to the cart. Gives information on the current state of the cart, e.g. included items. This event isn't triggered if the customer makes changes in the cart itself, e.g. changing the amount of a product. |

If your app request one of these events, it is informed about related actions and can react accordingly.

## Enable events

In order to make use of an event, you need to add the related snippet to your code.

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('pageview', function (event) {
    console.log('pageview url:', event.detail.url)
  })
  window.eComEventTarget.addEventListener('product', function (event) {
    console.log('product:', event.detail.product.toJS())
  })
  window.eComEventTarget.addEventListener('category', function (event) {
    console.log('category:', event.detail.category.toJS(), 'products:', event.detail.products.toJS())
  })
  window.eComEventTarget.addEventListener('cart:add', function (event) {
    console.log('new cart data:', event.detail.cart)
  })
}
```

