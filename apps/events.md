---
layout: docs
key: events
title: Events
---

Events can be triggered when a customer executes a specific action in an ePages online shop.
This can, for example, be a customer accessing a shop's page, or adding a product to the cart.
If you have implemented an event in your application, you will be informed about related actions and can react accordingly.
Furthermore, your app will receive information related to the event, such as the current page a user is on.


{% callout info Note: %}
Please be sure to regularly check our [change log](https://developer.epages.com/apps/change-log.html) to keep track of updates and changes on properties that might affect your app.
{% endcallout %}

## Available events

In the following table, you can find all available events.
For more detailed information on a specific event, see the section [Examples](#examples).

| Event | Description |
| - |  - |
| `page:view` | Is triggered when the customer opens or reloads a page. Informs about the path of the page. |
| `product:view` | Is triggered when the customer accesses a product detail page. Informs about the respective product as well as the current state of the cart. |
| `product:click` | Is triggered when the customer selects a link to a product detail page, for example, on category pages or the search results page. Please note that the event is not triggered when the customer selects a link to a product detail page in a product slider. Informs about the respective product as well as the source of the link. |
| `wishlist:add` | Is triggered when the customer adds a product to their wishlist. Informs about the added product. |
| `category:view` | Is triggered when the customer selects a category. Informs about the respective category and included products. |
| `searchResults:view` | Is triggered when the customer accesses the search results page. The event is also triggered when the customer updates the search results page, for example, by selecting the _Show more_ button. Informs about the number of search results, the search query, and the products included in the search results. |
| `cart:view` | Is triggered when the customer accesses the cart. Informs about the current state of the cart, for example, about included items. |
| `cart:add` | Is triggered when the customer adds a product to the cart. Provides information about the current state of the cart and the added product. |
| `cart:setQuantity` | Is triggered when the quantity of a product in the cart is changed. This also includes the removal of a product. Informs about the quantity change and the affected line item. |
| `cart:update` | Is triggered when the cart is changed on the cart overview. Informs about the current state of the cart, for example, about included items. |
| `order:completed` | Is triggered when a customer who accepted all cookies reaches the order confirmation page after completing a purchase. Provides additional information about the order, such as the billing address, the order number, and the selected shipping method. |
| `shippingMethod:select` | Is triggered when a customer selects a shipping method or pickup option during checkout. Informs about the selected shipping method or pickup option. |
| `paymentMethod:select` | Is triggered when a customer selects a payment method during checkout. Informs about the selected payment method. |

## Examples

This section explains how to make use of the single events and what to expect from them.

### page:view

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('page:view', function (event) {
    console.log('page:view', {
      url: event.detail.url,
    })
  })
}
```

Here is an example response:

```
url: /about-us
```

### product:view

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('product:view', function (event) {
    console.log('product:view', {
      product: event.detail.product,
      cart: event.detail.cart,
    })
  })
}
```

Here is an example response:

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
    isStrikePriceRRP: false
    isVariationMaster: false
    isVariationProduct: false
    isVisible: true
    links: (5) [{…}, {…}, {…}, {…}, {…}]
    listPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    lowestPrice: null
    mainCategoryId: "5954B711-E377-2A90-C400-D5809AB3F62B"
    manufacturer: null
    manufacturerPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    metaDescription: ""
    name: "Homemade Cherry Jam"
    onStock: true
    outOfStock: false
    pickupPeriod: ""
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
    strikePrice: null
    title: "Homemade Cherry Jam"
    variationMaster: null
    variations: null
    vatNote: "components.productComponent.priceExclusiveVat"
    warnStock: false
    weight: null
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
    potentialBasketDiscounts: null
    productLineItems: [{…}, {…}, {…}]
    registerSessionUrl: "https://pm.epages.com/epages/apidocu.sf/?ObjectPath=/Shops/apidocu/AnonymousUsers/2/Baskets/46072&ChangeAction=PickupBasket&PickupToken=NTRjZWJmNjdhNzNlYTUzNDAxZTgyZTc4ODYwYTliMDUxMDIzNDQ2OWY2NWQ5NWRmN2Q2YmVjZjVjNzljOTQ2N18xNDgyMjI3OTE3"
    shippingAddress: null
    shippingLineItem: {lineItemPrice: {…}, shippingMethod: {…}}
    status: null
    subAmount: "76,01 €"
    taxType: "NET"
    taxes: []
    totalBasketDiscount: null
    totalNumberOfItems: 3
    _links: null
}
```

### product:click

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('product:click', function (event) {
    console.log('product:click', {
      type: event.detail.type,
      detail: event.detail.detail,
      product: event.detail.product,
      productIndex: event.detail.productIndex,
    })
  })
}
```

Here is an example response:

```
detail: "Cherry Jam"
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
    isStrikePriceRRP: false
    isVariationMaster: false
    isVariationProduct: false
    isVisible: true
    links: (5) [{…}, {…}, {…}, {…}, {…}]
    listPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    lowestPrice: null
    mainCategoryId: "5954B711-E377-2A90-C400-D5809AB3F62B"
    manufacturer: null
    manufacturerPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    metaDescription: ""
    name: "Homemade Cherry Jam"
    onStock: true
    outOfStock: false
    pickupPeriod: ""
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
    strikePrice: null
    title: "Homemade Cherry Jam"
    variationMaster: null
    variations: null
    vatNote: "components.productComponent.priceExclusiveVat"
    warnStock: false
    weight: null
}
productIndex: 1
type: "search"
```

### wishlist:add

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('wishlist:add', function (event) {
    console.log('wishlist:add', {
      locale: event.detail.locale,
      productId: event.detail.product.productId,
      quantity: event.detail.product.quantity,
    })
  })
}
```

Here is an example response:

```
locale: "en_GB"
productId: "5C3F2C7C-F3FD-C400-7A06-D5809AB3608D"
quantity: 1
```

### category:view

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('category:view', function (event) {
    console.log('category:view', {
      category: event.detail.category,
      products: event.detail.products,
    })
  })
}
```
Here is an example response:

```
category: {
  categoryId: "5AD608E0-22C3-0009-F213-D5823AB36AC8"
  content: {id: "4e230bbd-2a8a-4941-8c43-3de323d40a9e", pageId: "208eb23a-3f83-4e7e-a890-87d5de254af7", themeId: "a42ec23f-59f2-41b5-bf35-a99b8ccd0663", 
  createdAt: "2018-04-17T14:48:29.000Z"
  ep6path: "/Shops/Categories/Jam"
  ep6pathMD5: null
  guid: "5AD608E0-22C3-0009-F213-D58093346AC8"
  id: "208eb3ba-3f83-4e7e-a890-87d5de223af7"
  isVisible: true
  visibleInNavigation: true
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
}
products: Array (2) {
  0: {
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
    isStrikePriceRRP: false
    isVariationMaster: false
    isVariationProduct: false
    isVisible: true
    links: (5) [{…}, {…}, {…}, {…}, {…}]
    listPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    lowestPrice: null
    mainCategoryId: "5954B711-E377-2A90-C400-D5809AB3F62B"
    manufacturer: null
    manufacturerPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    metaDescription: ""
    name: "Homemade Cherry Jam"
    onStock: true
    outOfStock: false
    pickupPeriod: ""
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
    strikePrice: null
    title: "Homemade Cherry Jam"
    variationMaster: null
    variations: null
    vatNote: "components.productComponent.priceExclusiveVat"
    warnStock: false
    weight: null
  }
  1: {
    availabilityText: "Available"
    available: true
    basePrice: {refQuantity: {…}, refPrice: {…}, formatted: "1 m³ = €0,11", quantity: {…}}
    bulkPrices: null
    conditionMicrodata: "NewCondition"
    customAttributes: [{…}]
    deliveryPeriod: "1-3"
    deliveryPeriodUnit: "DAYS"
    description: null
    energyLabel: null
    energyLabelSourceFile: null
    gtin: 7501054230107
    hasCrossSelling: false
    hasStockLevel: true
    hasVariations: false
    href: "/p/homemade-strawberry-jam"
    image: null
    isStrikePriceRRP: false
    isVariationMaster: false
    isVariationProduct: false
    isVisible: true
    links: (5) [{…}, {…}, {…}, {…}, {…}]
    listPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    lowestPrice: null
    mainCategoryId: "5954B711-E377-2A90-C400-D5809AB3F62B"
    manufacturer: null
    manufacturerPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    metaDescription: ""
    name: "Homemade Strawberry Jam"
    onStock: true
    outOfStock: false
    pickupPeriod: ""
    price: {taxType: "NET", formatted: "€36,00", amount: 36, currency: "EUR"}
    productDataSheet: null
    productId: "6054B706-E701-F357-A52D-D5809AB3F606"
    productVariationSelection: null
    productVariationValues: ""
    sku: "1090"
    slideshow: [{…}, {…}, {…}, {…}]
    slug: "homemade-strawberry-jam"
    stockLevelClass: "in"
    stockLevelMicrodata: "InStock"
    strikePrice: null
    title: "Homemade Strawberry Jam"
    variationMaster: null
    variations: null
    vatNote: "components.productComponent.priceExclusiveVat"
    warnStock: false
    weight: null
  } 
  length: 2
}
```

### searchResults:view

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('searchResults:view', function (event) {
    console.log('searchResults:view', {
      products: event.detail.products,
      query: event.detail.query,
    })
  })
}
```

Here is an example response:

```
products: Array(2) {
  0: {
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
    isStrikePriceRRP: false
    isVariationMaster: false
    isVariationProduct: false
    isVisible: true
    links: (5) [{…}, {…}, {…}, {…}, {…}]
    listPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    lowestPrice: null
    mainCategoryId: "5954B711-E377-2A90-C400-D5809AB3F62B"
    manufacturer: null
    manufacturerPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    metaDescription: ""
    name: "Homemade Cherry Jam"
    onStock: true
    outOfStock: false
    pickupPeriod: ""
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
    strikePrice: null
    title: "Homemade Cherry Jam"
    variationMaster: null
    variations: null
    vatNote: "components.productComponent.priceExclusiveVat"
    warnStock: false
    weight: null
  }
  1: {
    availabilityText: "Available"
    available: true
    basePrice: {refQuantity: {…}, refPrice: {…}, formatted: "1 m³ = €0,11", quantity: {…}}
    bulkPrices: null
    conditionMicrodata: "NewCondition"
    customAttributes: [{…}]
    deliveryPeriod: "1-3"
    deliveryPeriodUnit: "DAYS"
    description: null
    energyLabel: null
    energyLabelSourceFile: null
    gtin: 7501054230107
    hasCrossSelling: false
    hasStockLevel: true
    hasVariations: false
    href: "/p/homemade-strawberry-jam"
    image: null
    isStrikePriceRRP: false
    isVariationMaster: false
    isVariationProduct: false
    isVisible: true
    links: (5) [{…}, {…}, {…}, {…}, {…}]
    listPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    lowestPrice: null
    mainCategoryId: "5954B711-E377-2A90-C400-D5809AB3F62B"
    manufacturer: null
    manufacturerPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    metaDescription: ""
    name: "Homemade Strawberry Jam"
    onStock: true
    outOfStock: false
    pickupPeriod: ""
    price: {taxType: "NET", formatted: "€36,00", amount: 36, currency: "EUR"}
    productDataSheet: null
    productId: "6054B706-E701-F357-A52D-D5809AB3F606"
    productVariationSelection: null
    productVariationValues: ""
    sku: "1090"
    slideshow: [{…}, {…}, {…}, {…}]
    slug: "homemade-strawberry-jam"
    stockLevelClass: "in"
    stockLevelMicrodata: "InStock"
    strikePrice: null
    title: "Homemade Strawberry Jam"
    variationMaster: null
    variations: null
    vatNote: "components.productComponent.priceExclusiveVat"
    warnStock: false
    weight: null
  } 
  length: 2
}
query: {
  q: "Jam"
  token: "ZjM3M2Q2YmY4jkFjYWRlZTIzZTBlYzQwMDU4MjYzZjYwNDNhZGY0NWM1N2JiNjZhMGI0YWNlNWFkYzU4ZTQ3OF8xNTQzOTM5MjIx"
}
```

### cart:view

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('cart:view', function (event) {
    console.log('cart:view', {
      cart: event.detail.cart,
    })
  })
}
```

Here is an example response:

```
cart: {
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
  potentialBasketDiscounts: null
  productLineItems: [{…}, {…}, {…}]
  registerSessionUrl: "https://pm.epages.com/epages/apidocu.sf/?ObjectPath=/Shops/apidocu/AnonymousUsers/2/Baskets/46072&ChangeAction=PickupBasket&PickupToken=NTRjZWJmNjdhNzNlYTUzNDAxZTgyZTc4ODYwYTliMDUxMDIzNDQ2OWY2NWQ5NWRmN2Q2YmVjZjVjNzljOTQ2N18xNDgyMjI3OTE3"
  shippingAddress: null
  shippingLineItem: {lineItemPrice: {…}, shippingMethod: {…}}
  status: null
  subAmount: "76,01 €"
  taxType: "NET"
  taxes: []
  totalBasketDiscount: null
  totalNumberOfItems: 3
  _links: null
}
```

### cart:add

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('cart:add', function (event) {
    console.log('cart:add', {
      cart: event.detail.cart,
      product: event.detail.product,
      quantity: event.detail.quantity,
    })
  })
}
```

Here is an example response:

```
cart: {
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
    potentialBasketDiscounts: null
    productLineItems: [{…}, {…}, {…}]
    registerSessionUrl: "https://pm.epages.com/epages/apidocu.sf/?ObjectPath=/Shops/apidocu/AnonymousUsers/2/Baskets/46072&ChangeAction=PickupBasket&PickupToken=NTRjZWJmNjdhNzNlYTUzNDAxZTgyZTc4ODYwYTliMDUxMDIzNDQ2OWY2NWQ5NWRmN2Q2YmVjZjVjNzljOTQ2N18xNDgyMjI3OTE3"
    shippingAddress: null
    shippingLineItem: {lineItemPrice: {…}, shippingMethod: {…}}
    status: null
    subAmount: "76,01 €"
    taxType: "NET"
    taxes: []
    totalBasketDiscount: null
    totalNumberOfItems: 3
    _links: null
}
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
    isStrikePriceRRP: false
    isVariationMaster: false
    isVariationProduct: false
    isVisible: true
    links: (5) [{…}, {…}, {…}, {…}, {…}]
    listPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    lowestPrice: null
    mainCategoryId: "5954B711-E377-2A90-C400-D5809AB3F62B"
    manufacturer: null
    manufacturerPrice: null // deprecated, use strikePrice and isStrikePriceRRP instead
    metaDescription: ""
    name: "Homemade Cherry Jam"
    onStock: true
    outOfStock: false
    pickupPeriod: ""
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
    strikePrice: null
    title: "Homemade Cherry Jam"
    variationMaster: null
    variations: null
    vatNote: "components.productComponent.priceExclusiveVat"
    warnStock: false
    weight: null
}
quantity: 1
```

### cart:setQuantity

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('cart:setQuantity',function(event) {
    console.log('cart:setQuantity', {
      lineItem: event.detail.lineItem,
      quantity: event.detail.quantity,
      quantityDelta: event.detail.quantityDelta,
    })
  })
}
```

Here is an example response:

```
lineItem: {
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

### cart:update

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('cart:update',function(event) {
    console.log('cart:update', {
      cart: event.detail.cart,
    })
  })
}
```

Here is an example response:

```
cart: {
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
  potentialBasketDiscounts: null
  productLineItems: [{…}, {…}, {…}]
  registerSessionUrl: "https://pm.epages.com/epages/apidocu.sf/?ObjectPath=/Shops/apidocu/AnonymousUsers/2/Baskets/46072&ChangeAction=PickupBasket&PickupToken=NTRjZWJmNjdhNzNlYTUzNDAxZTgyZTc4ODYwYTliMDUxMDIzNDQ2OWY2NWQ5NWRmN2Q2YmVjZjVjNzljOTQ2N18xNDgyMjI3OTE3"
  shippingAddress: null
  shippingLineItem: {lineItemPrice: {…}, shippingMethod: {…}}
  status: null
  subAmount: "76,01 €"
  taxType: "NET"
  taxes: []
  totalBasketDiscount: null
  totalNumberOfItems: 3
  _links: null
}
```

### order:completed

{% callout info Note: %}
Please note that your app will only receive this event if the customer accepted all cookies in the cookie notice.
{% endcallout %}

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('order:completed', function (event) {
    console.log('order:completed', {
      order: event.detail,
    })
  })
}
```

Here is an example response:

```
order: {
  billingAddress: null
  couponCampaign: null
  currencyId: "EUR"
  grandTotal: "19.21"
  lineItemContainer: {ecoParticipations: Array(0), basketDiscount: {…}, totalTax: {…}, totalBeforeTax: {…}, couponLineItem: null, …}
  orderId: "5D397C93-6BE3-F322-56A6-D5809AB32102"
  orderNumber: "114264"
  paymentData: {paymentMethod: {…}, transactionId: null, price: {…}, status: null, taxes: null, …}
  shippingAddress: null
  shippingData: {shippingMethod: {…}, price: {…}, taxes: Array(1)}
  totalTax: "3.2"
}
```

### shippingMethod:select

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('shippingMethod:select', function (event) {
    console.log('shippingMethod:select', {
      shippingMethod: event.detail.shippingMethod,
    })
  })
}
```

Here is an example response:

```
shippingMethod: {
  _id: "631E19A1-AD54-518D-B836-AC120004711F",
  name: "Standardzustellung",
  lineItemPrice: {"currency": "EUR", "taxType": "GROSS", "amount": 7, "formatted": "7,00 €"}}
```

### paymentMethod:select

To get more information about this event, you can use the following snippet:

```js
if (window.eComEventTarget) {
  window.eComEventTarget.addEventListener('paymentMethod:select', function (event) {
    console.log('paymentMethod:select', {
      paymentMethod: event.detail.paymentMethod,
    })
  })
}
```

Here is an example response:

```
paymentMethod: {
  _id: "631E19A2-4D4E-CD42-641A-AC120004718A",
  name: "Vorkasse",
  lineItemPrice: {"currency": "EUR", "taxType": "GROSS", "amount": 3.2, "formatted": "3,20 €"}}
```
