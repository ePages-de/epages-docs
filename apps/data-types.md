---
layout: page
key: apps-data-types
title: Data types
---

# address

This object is used for the attributes of shippingAddress and billingAddress.

| Attribute | Type | Description |
| - | :-: |  - |
| firstName | string | The first name of the customer or supplied party.|
| lastName | string | The last name of the customer or supplied party.|
| street | string | The street name of the address. |
| zipCode | string | The zip or postal code of the address. |
| city | string | The city of the address. |
| country | string | The country of the address. |
| birthday | string | The date of birth of the customer. |
| emailAddress | string | The email address of the customer. |

# attributeSelection

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the selected product attribute, e.g. colour. |
| value | string | The assigned value of the selected product attribute, e.g. white. |

# customAttribute

| Attribute | Type | Description |
| - | :-: |  - |
| key | string | The identifier of the custom attribute. |
| displayKey | string | The displayed name of the custom attribute. |
| singleValue | boolean | `true` if just one feature is selected for the custom attribute.  |
| type | string | The data type of the custom attribute. |
| values | array of [value](page:apps-data-types#value)| The options selected for the custom attribute. |

# image

This object is used for the attributes of images.

| Attribute | Type | Description |
| - | :-: |  - |
| url | string | The URL of an image. |
| classifier | string | Specifies the image, e.g. Thumbnail or Medium. |


# lineItemContainer

| Attribute | Type | Description |
| - | :-: |  - |
| grandTotal | [Price](page:apps-data-types#price) | The total price including product price, shipping and tax. |
| totalBeforeTax | [Price](page:apps-data-types#price) | The total price including product price, shipping excluding tax. |
| totalTax | [Price](page:apps-data-types#price) | The total amount of the tax. |
| lineItemsSubTotal | [Price](page:apps-data-types#price) | The sum of the line item price of all line items. |
| productLineItems | Array of [productLineItem](page:apps-data-types#productlineitem) | A list of line items. |

# link

This object is used for the attributes of links.

| Attribute | Type | Description |
| - | :-: |  - |
| rel | string | The link relation that describes how the link relates to the call. |
| href | string | The URL of the related link that can be used for subsequent calls. |
| title | string | The title of the item that is linked. (optional)  |

# price

This object is used for the attributes of basePrice, depositPrice, ecoParticipationPrice, manufacturerPrice, grandTotal, priceWithDeposits, totalBeforeTax, totalTax and lineItemsSubTotal.

| Attribute | Type | Description |
| - | :-: |  - |
| taxType | string | Indicates if the amount includes tax, e.g. gross. |
| formatted | string | The amount of the price with currency unit. |
| amount | number | The amount of the price. |
| currency | string | The currency code of the price according to ISO 4217. |

# priceInfo

| Attribute | Type | Description |
| - | :-: |  - |
| quantity | [quantity](page:apps-data-types#quantity) | The quantity of the product this price refers to.|
| price | [price](page:apps-data-types#price) | The price of the product.|

# product

This object is used for the attributes of product.

| Attribute | Type | Description |
| - | :-: |  - |
| productId | string | The unique identifier of the product. |
| name | string | The name of the product. |
| shortDescription | string | Categorises the image, e.g. Thumbnail or Medium. |
| description | string | Categorises the image, e.g. Thumbnail or Medium. |
| images | array of [image](page:apps-data-types#image) | Specifies the image, e.g. Thumbnail or Medium. |

# productLineItem

| Attribute | Type | Description |
| - | :-: |  - |
| lineItemId | string | The unique identifier of the line item. |
| sku | string | The stock keeping unit (SKU) corresponding to the line item. |
| name | string | The name of the line item. |
| productId | string | The unique identifier of the product. |
| quantity | [quantity](page:apps-data-types#quantity) | The quantity of the line item. |
| lineItemPrice | [price](page:apps-data-types#price) | The price of the line item. |
| singleItemPrice | [price](page:apps-data-types#price) | The price for a single item. |
| images | array of [image](page:apps-data-types#image) | The image of the line item. |
| links | array of [link](page:apps-data-types#link) | The links to the product line item. |

# quantity

This object is used for the attributes of deliveryWeight and quantity.

| Attribute | Type | Description |
| - | :-: |  - |
| amount | integer | The amount displayed as a numeric value. |
| unit | string | The unit displayed as abbreviated SI unit, if available. Otherwise a localised name if the unit is displayed, e.g. piece(s).  |

# slide

| Attribute | Type | Description |
| - | :-: |  - |
| sizes | array of [image](page:apps-data-types#image) | The size of the images in the slideshow. |

# value

| Attribute | Type | Description |
| - | :-: |  - |
| value | string | The key of an attribute, e.g. 004. |
| displayValue | string | The displayed name of the attribute, e.g. XtraLarge. |

# variation

| Attribute | Type | Description |
| - | :-: |  - |
| link | [link](page:apps-data-types#link)| The link to the product variation. |
| attributeSelection | array of [attributeSelection](page:apps-data-types#attributeselection) | The attribute of the selected product variation. |

# variationAttribute

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the variation attribute. |
| displayName | string | The displayed name of the variation attribute. |
| values | array of [value](page:apps-data-types#value) | The values of the variation attribute.  |
