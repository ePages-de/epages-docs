---
layout: docs
key: events
title: Events
---

Events can be triggered when a customer executes a specific action in an ePages online shop.
This can be e.g. a customer opening a new page of a shop, or adding a product to the cart.
If you have implemented an event in your application, you will be informed about related actions and can react accordingly.
Furthermore, your app will receive information related to the event, such as the current page a user is on.

These events are available:

| Event | Type | Description |
| - | - |  - |
| `pageview` | string | Is triggered when the customer opens or reloads a page. Informs about the path of the page. |
| `product` | immutable.js object | Is triggered when the customer selects a product. Informs about the respective product. |
| `category` | immutable.js object | Is triggered when the customer selects a category. Informs about the respective category and related products.|
| `cart:add` | immutable.js object | Is triggered when the customer adds a product to the cart. Informs about the current state of the cart, e.g. included items. This event isn't triggered if the customer makes changes in the cart itself, e.g. changing the amount of an item. |

## Pageview event

In order to make use of this event, you need to add the following snippet to your code:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('pageview', function (event) {
    console.log('pageview url:', event.detail.url)
  })
}
```

You'll receive the following information:

```
pageview url: /about-us
```

## Product event

In order to make use of this event, you need to add the following snippet to your code:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('product', function (event) {
    console.log('product:', event.detail.product.toJS())
  })
}
```

You'll receive the following information:

```
availabilityText: "Available"
available: true
basePrice: {refQuantity: {…}, refPrice: {…}, formatted: "1 m³ = £0,12", quantity: {…}}
conditionMicrodata: "NewCondition"
customAttributes: [{…}]
deliveryPeriod: "2-3"
deliveryPeriodUnit: "DAYS"
description: null
energyLabel: null
energyLabelSourceFile: null
gtin: 7501054530107
hasCrossSelling: false
hasStockLevel: true
hasVariations: false
href: "/p/homemade-cherry-jam"
image: null
isVariationMaster: false
isVariationProduct: false
isVisible: true
links: [{…}, {…}, {…}, {…}, {…}]
lowestPrice: null
mainCategoryId: "5954B711-E377-2A90-C400-D5809AB3F62B"
manufacturer: null
manufacturerPrice: null
metaDescription: ""
name: "Homemade Cherry Jam"
onStock: true
outOfStock: false
price: {taxType: "NET", formatted: "£40,00", amount: 40, currency: "GBP"}
productDataSheet: null
productId: "5954B706-E701-F357-A52D-D5809AB3F606"
productVariationSelection: null
productVariationValues: ""
sku: "1007"
slideshow: [{…}, {…}, {…}, {…}]
slug: "homemade-cherry-jam"
stockLevelClass: "in"
stockLevelMicrodata: "InStock"
title: "Homemade Cherry Jam"
variationMaster: null
variations: null
vatNote: "components.productComponent.priceExclusiveVat"
warnStock: false
```
## Category event

In order to make use of this event, you need to add the following snippet to your code:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('category', function (event) {
    console.log('category:', event.detail.category.toJS(), 'products:', event.detail.products.toJS())
  })
}
```
You'll receive the following information:

```
categoryId: "5AD608E0-22C3-0009-F213-D5823AB36AC8"
content: {id: "4e230bbd-2a8a-4941-8c43-3de323d40a9e", pageId: "208eb23a-3f83-4e7e-a890-87d5de254af7", themeId: "a42ec23f-59f2-41b5-bf35-a99b8ccd0663", blocks: Array(0), elements: Array(0)}
createdAt: "2018-04-17T14:48:29.000Z"
ep6path: "/Shops/Categories/Jam"
guid: "5AD608E0-22C3-0009-F213-D58093346AC8"
id: "208eb3ba-3f83-4e7e-a890-87d5de223af7"
isVisible: true
lft: null
metaDescription: ""
navigation: null
rgt: null
shopId: "7eb738eb-68b1-4ff1-8aa8-9d74e785a621"
slug: "jam"
title: "Jam"
titleTag: ""
type: "category"
updatedAt: "2018-04-17T14:48:29.000Z"
url: "/jam"
```

## Cart:add event

In order to make use of this event, you need to add the following snippet to your code:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('cart:add', function (event) {
    console.log('new cart data:', event.detail.cart)
  })
}
```

You'll receive the following information:

```
billingAddress: null
canHaveCoupon: true
cartId: "5C06901F-150C-3D9B-B144-D509AB34875"
checkoutButtons: [{…}]
checkoutState: null
checkoutUrl: "https://pm.epages.com/epages/apidocu.sf/?ObjectPath=/Shops/apidocu/AnonymousUsers/1/Baskets/46072&ChangeAction=PickupBasket&PickupToken=MjNiZThlOGM0MjAzZWQ0N2ZjYmZmZDFiZjI3OTQxMzkwOWY4ZjZlOGE4NTM0ZWIxMjg3NmY2NzBiY2IxYzQ1OV8xNDgyMjIzMDcz"
coupon: null
couponCampaign: null
grandAmount: "£76,01"
grandAmountNote: "components.productComponent.priceExclusiveVat"
minimumOrderValue: null
netAmount: "£76,01"
paymentLineItem: {lineItemPrice: {…}, paymentMethod: {…}}
pickupToken: "ZjM3M2Q2YmY4jkFjYWRlZTIzZTBlYzQwMDU4MjYzZjYwNDNhZGY0NWM1N2JiNjZhMGI0YWNlNWFkYzU4ZTQ3OF8xNTQzOTM5MjIx"
productLineItems: [{…}, {…}, {…}]
registerSessionUrl: "https://pm.epages.com/epages/apidocu.sf/?ObjectPath=/Shops/apidocu/AnonymousUsers/2/Baskets/46072&ChangeAction=PickupBasket&PickupToken=NTRjZWJmNjdhNzNlYTUzNDAxZTgyZTc4ODYwYTliMDUxMDIzNDQ2OWY2NWQ5NWRmN2Q2YmVjZjVjNzljOTQ2N18xNDgyMjI3OTE3"
shippingAddress: null
shippingLineItem: {lineItemPrice: {…}, shippingMethod: {…}}
subAmount: "£76,01"
taxType: "NET"
taxes: []
totalNumberOfItems: 3
_links: null
```

