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
| `product` | immutable.js object | Is triggered when the customer selects a product. Informs about the respective product as well as the current state of the cart. |
| `product:click` | immutable.js object | Is triggered when the customer selects a product impression. The type indicates the source of the product impression, e.g. `category` or `search`. The `detail` will contain informations about the type, for example the category or search query. |
| `wishlist:add` | object | Is triggered when the customer adds a product to their wishlist. The wishlist is only available for logged-in customers. |
| `category` | immutable.js object | Is triggered when the customer selects a category. Informs about the respective category and related products. |
| `search` | immutable.js object | Is triggered when the customer performs a search via the search bar of the online shop. |
| `cart` | object | Is triggered when the customer accesses the cart. Informs about the current state of the cart, e.g. included items. |
| `cart:add` | object | Is triggered when the customer adds a product to the cart. Provides information about the current state of the cart and the product that was added to it. |
| `cart:setQuantity` | object | Is triggered when the quantity of a product in the cart is changed. This also includes the removal of a product. Informs about the quantity change and the affected product. |
| `order:completed` | object | Is triggered when the customer reaches the order confirmation page after completing a purchase. Provides additional information about the order, such as the billing address, the order number, and the selected shipping method. |

## Pageview event

To make use of this event, you need to add the following snippet to your code:

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

To make use of this event, you need to add the following snippet to your code:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('product', function (event) {
    console.log('product:', event.detail.product.toJS(), 'cart:', event.detail.cart.toJS())
  })
}
```

You'll receive the following information:

```
product: {
    availabilityText: "Available"
    available: true
    basePrice: {refQuantity: {…}, refPrice: {…}, formatted: "1 m³ = €0,12", quantity: {…}}
    bulkPrices: null
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
    links: (5) [{…}, {…}, {…}, {…}, {…}]
    listPrice: null
    lowestPrice: null
    mainCategoryId: "5954B711-E377-2A90-C400-D5809AB3F62B"
    manufacturer: null
    manufacturerPrice: null
    metaDescription: ""
    name: "Homemade Cherry Jam"
    onStock: true
    outOfStock: false
    price: {taxType: "NET", formatted: "€40,00", amount: 40, currency: "EUR"}
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
}
cart: {
    billingAddress: null
    canHaveCoupon: true
    cartId: "5C06901F-150A-3D9B-B144-D509AB34800"
    checkoutButtons: [{…}]
    checkoutState: null
    checkoutUrl: "https://pm.epages.com/epages/apidocu.sf/?ObjectPath=/Shops/apidocu/AnonymousUsers/1/Baskets/46072&ChangeAction=PickupBasketPickupToken=MjNiZThlOGM0MjAzZWQ0N2ZjYmZmZDFiZjI3OTQxMzkwOWY4ZjZlOGE4NTM0ZWIxMjg3NmY2NzBiY2IxYzQ1OV8xNDgyMjIzMDcz"
    coupon: null
    couponCampaign: null
    customerEmail: null
    grandAmount: "76,01 €"
    grandAmountNote: "components.productComponent.priceExclusiveVat"
    grandTotal: {amount: 76.01, currency: "EUR", formatted: "€76,01"}
    minimumOrderValue: null
    mustAcceptTermsAndConditions: false
    netAmount: "76,01 €"
    paymentLineItem: {lineItemPrice: {…}, paymentMethod: {…}}
    pickupToken: "ZjM3M2Q2YmY4jkFjYWRlZTIzZTBlYzQwMDU4MjYzZjYwNDNhZGY0NWM1N2JiNjZhMGI0YWNlNWFkYzU4ZTQ3OF8xNTQzOTM5MjIx"
    productLineItems: [{…}, {…}, {…}]
    registerSessionUrl: "https://pm.epages.com/epages/apidocu.sf/?ObjectPath=/Shops/apidocu/AnonymousUsers/2/Baskets/46072&ChangeAction=PickupBasket&PickupToken=NTRjZWJmNjdhNzNlYTUzNDAxZTgyZTc4ODYwYTliMDUxMDIzNDQ2OWY2NWQ5NWRmN2Q2YmVjZjVjNzljOTQ2N18xNDgyMjI3OTE3"
    shippingAddress: null
    shippingLineItem: {lineItemPrice: {…}, shippingMethod: {…}}
    status: null
    subAmount: "76,01 €"
    taxType: "NET"
    taxes: []
    totalNumberOfItems: 3
    _links: null
}
```

## Product:click event

To make use of this event, you need to add the following snippet to your code:

```js

```

You'll receive the following information:

```

```

## Wishlist:add event

To make use of this event, you need to add the following snippet to your code:

```js

```

You'll receive the following information:

```

```

## Category event

To make use of this event, you need to add the following snippet to your code:

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
ep6pathMD5: null
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

## Search event

To make use of this event, you need to add the following snippet to your code:

```js

```

You'll receive the following information:

```

```

## Cart event

To make use of this event, you need to add the following snippet to your code:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('cart', function (event) {
    console.log('cart:', event.detail.cart)
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
customerEmail: null
grandAmount: "76,01 €"
grandAmountNote: "components.productComponent.priceExclusiveVat"
grandTotal: {amount: 76.01, currency: "EUR", formatted: "€76,01"}
minimumOrderValue: null
mustAcceptTermsAndConditions: false
netAmount: "76,01 €"
paymentLineItem: {lineItemPrice: {…}, paymentMethod: {…}}
pickupToken: "ZjM3M2Q2YmY4jkFjYWRlZTIzZTBlYzQwMDU4MjYzZjYwNDNhZGY0NWM1N2JiNjZhMGI0YWNlNWFkYzU4ZTQ3OF8xNTQzOTM5MjIx"
productLineItems: [{…}, {…}, {…}]
registerSessionUrl: "https://pm.epages.com/epages/apidocu.sf/?ObjectPath=/Shops/apidocu/AnonymousUsers/2/Baskets/46072&ChangeAction=PickupBasket&PickupToken=NTRjZWJmNjdhNzNlYTUzNDAxZTgyZTc4ODYwYTliMDUxMDIzNDQ2OWY2NWQ5NWRmN2Q2YmVjZjVjNzljOTQ2N18xNDgyMjI3OTE3"
shippingAddress: null
shippingLineItem: {lineItemPrice: {…}, shippingMethod: {…}}
status: null
subAmount: "76,01 €"
taxType: "NET"
taxes: []
totalNumberOfItems: 3
_links: null
```

## Cart:add event

To make use of this event, you need to add the following snippet to your code:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('cart:add', function (event) {
    console.log('new cart data:',event.detail.cart,'added product:',event.detail.product,'quantity:',event.detail.quantity)
  })
}
```

You'll receive the following information:

```
new cart data:{
    billingAddress: null
    canHaveCoupon: true
    cartId: "5C06901F-150C-3D9B-B144-D509AB34875"
    checkoutButtons: [{…}]
    checkoutState: null
    checkoutUrl: "https://pm.epages.com/epages/apidocu.sf/?ObjectPath=/Shops/apidocu/AnonymousUsers/1/Baskets/46072&ChangeAction=PickupBasket&PickupToken=MjNiZThlOGM0MjAzZWQ0N2ZjYmZmZDFiZjI3OTQxMzkwOWY4ZjZlOGE4NTM0ZWIxMjg3NmY2NzBiY2IxYzQ1OV8xNDgyMjIzMDcz"
    coupon: null
    couponCampaign: null
    customerEmail: null
    grandAmount: "76,01 €"
    grandAmountNote: "components.productComponent.priceExclusiveVat"
    grandTotal: {amount: 76.01, currency: "EUR", formatted: "€76,01"}
    minimumOrderValue: null
    mustAcceptTermsAndConditions: false
    netAmount: "76,01 €"
    paymentLineItem: {lineItemPrice: {…}, paymentMethod: {…}}
    pickupToken: "ZjM3M2Q2YmY4jkFjYWRlZTIzZTBlYzQwMDU4MjYzZjYwNDNhZGY0NWM1N2JiNjZhMGI0YWNlNWFkYzU4ZTQ3OF8xNTQzOTM5MjIx"
    productLineItems: [{…}, {…}, {…}]
    registerSessionUrl: "https://pm.epages.com/epages/apidocu.sf/?ObjectPath=/Shops/apidocu/AnonymousUsers/2/Baskets/46072&ChangeAction=PickupBasket&PickupToken=NTRjZWJmNjdhNzNlYTUzNDAxZTgyZTc4ODYwYTliMDUxMDIzNDQ2OWY2NWQ5NWRmN2Q2YmVjZjVjNzljOTQ2N18xNDgyMjI3OTE3"
    shippingAddress: null
    shippingLineItem: {lineItemPrice: {…}, shippingMethod: {…}}
    status: null
    subAmount: "76,01 €"
    taxType: "NET"
    taxes: []
    totalNumberOfItems: 3
    _links: null
}
added product:{
    availabilityText: "Available"
    available: true
    basePrice: {refQuantity: {…}, refPrice: {…}, formatted: "1 m³ = €0,12", quantity: {…}}
    bulkPrices: null
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
    links: (5) [{…}, {…}, {…}, {…}, {…}]
    listPrice: null
    lowestPrice: null
    mainCategoryId: "5954B711-E377-2A90-C400-D5809AB3F62B"
    manufacturer: null
    manufacturerPrice: null
    metaDescription: ""
    name: "Homemade Cherry Jam"
    onStock: true
    outOfStock: false
    price: {taxType: "NET", formatted: "€40,00", amount: 40, currency: "EUR"}
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
}
quantity 1
```

## Cart:setQuantity event

To make use of this event, you need to add the following snippet to your code:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('cart:setQuantity',function(event) {
    console.log('cart quantity update:','lineItem:',event.detail.lineItem,'quantity:',event.detail.quantity,'quantityDelta:',event.detail.quantityDelta)
  })
}
```

You'll receive the following information:

```
lineItem:{
    energyLabel: null
    energyLabelSourceFile: null
    essentialFeatures: []
    imageUrl: "https://pm.epages.com/epages/apidocu.sf/api/core-storage/images/jam-928256_1920.jpg"
    lineItemCouponDiscount: null
    lineItemId: "29771d97-8ba1-45e0-986e-4f15842fb407"
    lineItemPrice: {amount: 8.8, currency: "EUR", taxType: "GROSS", formatted: "€8.80"}
    name: "Homemade Cherry Jam"
    productId: "66f82e8b-e211-4d5e-8a15-6bfb7a0906a3"
    productUrl: "/p/homemade-cherry-jam"
    quantity: 1
    singleItemPrice: {amount: 8.8, currency: "EUR", taxType: "GROSS", formatted: "€8.80"}
    sku: "1000"
    slug: "homemade-cherry-jam"
    taxClass: "NET"
    variationString: ""
}
quantity: 2
quantityDelta: 1
```

## Order:completed event

To make use of this event, you need to add the following snippet to your code:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('order:completed', function(event) {
    console.log('order completed:', event.detail)
  })
}
```

You'll receive the following information:

```
billingAddress: null
couponCampaign: null
currencyId: "EUR"
customerComment: ""
grandTotal: "19.21"
lineItemContainer: {ecoParticipations: Array(0), basketDiscount: {…}, totalTax: {…}, totalBeforeTax: {…}, couponLineItem: null, …}
orderId: "5D397C93-6BE3-F322-56A6-D5809AB32102"
orderNumber: "114264"
paymentData: {paymentMethod: {…}, transactionId: null, price: {…}, status: null, taxes: null, …}
shippingAddress: null
shippingData: {shippingMethod: {…}, price: {…}, taxes: Array(1)}
totalTax: "3.2"
```
