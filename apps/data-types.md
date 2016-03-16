---
layout: page
key: apps-data-types
title: Data types
---

## address

This object is used for the attributes of shippingAddress and billingAddress.

| Attribute | Type | Description |
| - | :-: |  - |
| company | string | The company of the person associated with the address.|
| salutation | string | The salutation of the customer, e.g. Mr or Mrs.|
| title | string | The academic title of the customer, e.g. professor or PhD.|
| firstName | string | The first name of the person associated with the address.|
| lastName | string | The last name of the person associated with the address.|
| street | string | The street name of the address. |
| streetDetails | string | An additional field for the street address.|
| zipCode | string | The zip or postal code of the address. |
| city | string | The name of the city. |
| state | string | The name of the state.|
| country | string | The name of the country. |
| vatId | string | The Id of the VAT.|
| birthday | string | The date of birth of the person associated with the address. |
| emailAddress | string | The email address of the person associated with the address. |

## attributeSelection

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the selected product attribute, e.g. colour. |
| value | string | The assigned value of the selected product attribute, e.g. white. |

## basePrice

| Attribute | Type | Description |
| - | :-: |  - |
| refQuantity  | [quantity](page:apps-data-types#quantity) | The standardised unit for the product, e.g. 1 l. |
| refPrice | object of [price](page:apps-data-types#price) | The price based upon the standardised unit. |
| formatted | string | The formatted output of the base price information, e.g. 1 l = 1.20 EUR. |
| quantity | [quantity](page:apps-data-types#quantity) | The quantity of the product, e.g. 500 ml. |

## cart

| Attribute | Type | Description |
| - | :-: |  - |
| cartid | string | The unique identifier of the cart. |
| billingAddress | [address](page:apps-data-types#address) | The billing address for a cart. |
| shippingAddress | [address](page:apps-data-types#address) | The shipping address for a cart. |
| lineItemContainer | [lineItemContainer](page:apps-data-types#lineitemcontainer) | Contains the line items of a cart. |
| minCartValue | object of [price](page:apps-data-types#price) | The minimum order value of a shop. |
| checkoutURL | string | The URL that redirects the browser to the merchant’s shop in order to complete the checkout. |

## category

| Attribute | Type | Description |
| - | :-: |  - |
| categoryId | string | The unique identifier of the category a product is assigned to. |
| name | string | The name of the category. |
| pageTitle | string | The title of this category. |
| description | string | The description of the category. |
| specialOffer | boolean | Special offers of this category. |
| images | array of [image](page:apps-data-types#image) | The images belonging to this category. |
| parent | [link](page:apps-data-types#link) | The link to the parent category. |
| subCategories | array of [link](page:apps-data-types#link) | A list of links to the subcategories. |
| sfUrl | string | The link to the categories in the shop’s storefront. |

## contentPageSummary

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the content page. |

## customer

| Attribute | Type | Description |
| - | :-: |  - |
| customerId | string | The unique identifier of the customer. |
| customerNumber | string | The number by which the merchant tracks the customer. |
| creationDate | string | The date/time the customer was created. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z` |
| billingAddress | [address](page:apps-data-types#address) | The billing address of the customer. |
| internalNote | string | Internal note for the customer done by the merchant. |
| links | array of [link](page:apps-data-types#link) | The link to the customer and their orders. |

## customAttribute

| Attribute | Type | Description |
| - | :-: |  - |
| key | string | The identifier of the custom attribute. |
| displayKey | string | The displayed name of the custom attribute. |
| singleValue | boolean | Indicates if just one feature is selected for the custom attribute.  |
| type | enum | The data type of the custom attribute. Can be *string*, *number*, *bool*, *datetime*, *time*, *url*.|
| values | array of [variationValue](page:apps-data-types#variationvalue)| The options selected for the custom attribute. |

## image

This object is used for the attributes of images.

| Attribute | Type | Description |
| - | :-: |  - |
| url | string | The URL of an image. |
| classifier | string | Specifies the image. Can be *Thumbnail*, *Small*, *HotDeal*, *MediumSmall*, *Medium*, *MediumLarge*, *Large*. |

## imageInformation

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the slideshow image. |
| sizes | array of [image](page:apps-data-types#image) | The size of the images in the slideshow. |

## lineItemContainer

| Attribute | Type | Description |
| - | :-: |  - |
| grandTotal | object of [price](page:apps-data-types#price) | The total price including product price, shipping and tax. |
| totalBeforeTax | object of  [price](page:apps-data-types#price) | The total price including product price, shipping excluding tax. |
| totalTax | object of [price](page:apps-data-types#price) | The total amount of the tax. |
| lineItemsSubTotal | object of [price](page:apps-data-types#price) | The sum of the line item price of all line items. |
| productLineItems | array of [productLineItem](page:apps-data-types#productlineitem) | A list of line items. |
| shippingPrice | object of [price](page:apps-data-types#price) | The shipping price of the line item. |

## link

This object is used for the attributes of links.

| Attribute | Type | Description |
| - | :-: |  - |
| rel | string | The link relation that describes how the link relates to the call. |
| href | string | The URL of the related link that can be used for subsequent calls. |
| title | string | The title of the item that is linked. (optional)  |

## order

| Attribute | Type | Description |
| - | :-: |  - |
| orderId | string | The unique identifier of the order. |
| orderNumber | string | The order number. |
| creationDate | string | The date/time of order placement. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z` |
| billingAddress | [address](page:apps-data-types#address) | The billing address for the order.  |
| shippingAddress | [address](page:apps-data-types#address) | The shipping address for the order.  |
| invoicedOn | string | The date/time the order was invoiced. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| delievereOn | string | The date/time the order was delivered. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| pendingOn | string | The date/time the order was set to pending. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| archivedOn | string | The date/time the order was archived. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| dispatchedOn | string | The date/time the order was dispatched. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| viewedOn | string | The date/time the order was viewed. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| customerId | string | The unique identifier of the customer.  |
| locale | string | The locale that identifies the origin of the customer.  |
| currencyId | string | The unique identifier of the currency used for payment.  |
| taxModel | string | The taxmodel that applies for the order, e.g. gross.  |
| grandTotal | string | The total cost of the order.  |
| totalBeforeTax | string | The total cost of the order before tax is applied.  |
| internalNote | string | Internal notes for the order done by the merchant.  |
| customerComment | string | Notes on the order from the customer. Can also be amended by the merchant in the administration.  |
| rejectedOn | string | The date/time the order was rejected. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| closedOn | string | The date/time the order was closed. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| paidOn | string | The date/time the order was paid. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| returnedOn | string | The date/time the order was returned. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| shippingData | object of [shippingData](page:apps-data-types#shippingdata) | The shipping data of the order, i.e. short info on shipping method and price.|
| paymentData | object of [paymentData](page:apps-data-types#paymentdata) | The payment data of the order, i.e. short info on payment method and price.|
| lineItemContainer | [lineItemContainer](page:apps-data-types#lineitemcontainer) | Contains the line items of an order.  |
| productLineItems | array of [productLineItem](page:apps-data-types#productlineitem) | A list of line items.  |
| shippingPrice | object of [price](page:apps-data-types#price) | The shipping price for the order.  |
| links | array of [link](page:apps-data-types#link) | The links to the products of the order. |

## paymentData

| Attribute | Type | Description |
| - | :-: |  - |
| paymentMethod | object of [paymentMethodInfo](page:apps-data-types#paymentmethodinfo) | Information on the payment type chosen by the customer. |
| price | object of [price](page:apps-data-types#price) | The costs for the payment method. |

## paymentMethodInfo

| Attribute | Type | Description |
| - | :-: |  - |
| id | string | The unique identifier of the payment method. |
| name | string | The name of the payment method chosen by the customer. |

## price

This object is used for the attributes of basePrice, depositPrice, ecoParticipationPrice, manufacturerPrice, grandTotal, priceWithDeposits, totalBeforeTax, totalTax and lineItemsSubTotal.

| Attribute | Type | Description |
| - | :-: |  - |
| taxType | string | Indicates if the amount includes tax, e.g. gross. |
| formatted | string | The amount of the price with currency unit. |
| amount | number | The amount of the price. |
| currency | string | The currency code of the price according to ISO 4217. |

## priceInfo

| Attribute | Type | Description |
| - | :-: |  - |
| quantity | [quantity](page:apps-data-types#quantity) | The quantity of the product the price refers to.|
| price | object of [price](page:apps-data-types#price) | The price of the product.|
| depositPrice | object of [price](page:apps-data-types#price) | The deposit price for the product, e.g. bottle deposit.|
| ecoParticipationPrice |object of [price](page:apps-data-types#price) | The advance recycling fee for electric and electronic products which is only in some countries prescribed by law.|
| manufacturerPrice | object of [price](page:apps-data-types#price) | The sales price recommended by the manufacturer.|
| priceWithDeposits | object of [price](page:apps-data-types#price) | The price including all deposits, i.e. price, depositPrice and ecoParticipationPrice.|
| basePrice | [basePrice](page:apps-data-types#baseprice) | The price information scaled to a standardised base unit, according to the German base price regulation "Preisangabenverordnung" (PAngV), e.g. 1 l = 1.20 EUR. Is `null` if no reference amount is specified for the product.|

## product

This object is used for the attributes of product.

| Attribute | Type | Description |
| - | :-: |  - |
| productId | string | The unique identifier of the product. |
| name | string | The name of the product. |
| shortDescription | string | Categorises the image, e.g. Thumbnail or Medium. |
| description | string | Categorises the image, e.g. Thumbnail or Medium. |
| priceInfo | object of [priceInfo](page:apps-data-types#priceinfo) | Price information on the product. |
| forSale | boolean | Information on the sale status of the product. Indicates if the product can be added to the shopping basket. |
| specialOffer | boolean | Indicates if the product is a special offer. |
| deliveryWeight | [quantity](page:apps-data-types#quantity) | The delivery weight of the product. |
| shippingMethodsRestrictedTo | array of [link](page:apps-data-types#link) | Information on possible shipping method restrictions, e.g. express delivery only. Can be `null` if no restrictions exist. |
| availabilityText | string | Additional custom information on the product's stock level or the delivery period. |
| availability | enum | The availability of the product. Can be one of *OnStock*, *WarnStock*, *OutStock*. |
| energyLabelsString | string | A list of energy labels applied to this product. Can be one or two values. If two values are returned, the first value is the best energy label, the second is the second-best. |
| energyLabelSourceFile | string | An image or PDF file containing the energy label image supplied by the manufacturer. |
| productDataSheet | string | An image or PDF file containing a datasheet with technical information on the product. Has to be available if the product has an energy label. |
| sfUrl | string | The link to storefront URL of the product. |
| productNumber | string | The product number. |
| productImage | string | The name of the product image. |
| manufacturer | string | The manufacturer of the product. |
| upc | string | The Universal Product Code of the product. |
| ean | string | The European Article Number of the product, either EAN-8 or EAN-13. |
| essentialFeatures | string | The essential features of the product. |
| searchKeywords | array of strings | The search terms for the product determined by the merchant in the administration.  |
| links | array of [link](page:apps-data-types#link) | The links to the product and product category. |

## productLineItem

| Attribute | Type | Description |
| - | :-: |  - |
| lineItemId | string | The unique identifier of the line item. |
| sku | string | The stock keeping unit (SKU) corresponding to the line item. |
| name | string | The name of the line item. |
| productId | string | The unique identifier of the product. |
| quantity | [quantity](page:apps-data-types#quantity) | The quantity of the line item. |
| lineItemPrice | object of [price](page:apps-data-types#price) | The price of the line item. |
| singleItemPrice | object of  [price](page:apps-data-types#price) | The price for a single item. |
| essentialFeatures | string | The essential features of the line item. |
| images | array of [image](page:apps-data-types#image) | The image of the line item. |
| links | array of [link](page:apps-data-types#link) | The links to the product line item. |

## productSuggest

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the product resulting from the query. |
| images | array of [image](page:apps-data-types#image) | The image of the product resulting from the query. |
| link | [link](page:apps-data-types#link) | The link to the product resulting from the query. |

## quantity

This object is used for the attributes of deliveryWeight and quantity.

| Attribute | Type | Description |
| - | :-: |  - |
| amount | decimal | The amount displayed as a numeric value. |
| unit | string | The unit displayed as abbreviated SI unit, if available. Otherwise a localised name if the unit is displayed, e.g. piece(s).  |

## sales

| Attribute | Type | Description |
| - | :-: |  - |
| currency | string | The currency code according to ISO 4217. |
| totalGrossRevenue | number | The total gross revenue received from completed orders.|
| totalNetRevenue | number | The total net revenue received from completed orders.|
| unitsSold | number | The number of sold product units (only available with active filter productId). |
| totalOrders | number | The number of orders for the defined time frame. |

## shippingData

| Attribute | Type | Description |
| - | :-: |  - |
| shippingMethod | object of [shippingMethodInfo](page:apps-data-types#shippingmethodinfo) | Information on the shipping method chosen by the customer. |
| price | object of [price](page:apps-data-types#price) | The costs for the shipping. |

## shippingMethodInfo

| Attribute | Type | Description |
| - | :-: |  - |
| id | string | The unique identifier of the shipping method. |
| name | string | The name of the shipping method chosen by the customer. |

## shippingMethod

| Attribute | Type | Description |
| - | :-: |  - |
| shippingMethodId | string | The unique identifier of the shipping method. |
| name | string | The name of the shipping method chosen by the customer.|
| description | string | The description of the shipping method.|
| logo | string | The logo of the shipping method. |

## shopInformation

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the shop. |
| slogan | string | The slogan of the shop.|
| logoUrl | string | The URL to the logo of the shop.|
| sfUrl | string | The URL to the storefront of the shop. |
| mboUrl | string | The URL to the administration area of the shop. |

## updatedProducts

| Attribute | Type | Description |
| - | :-: |  - |
| item | object of [product](page:apps-data-types#product) | The data of the product. |
| lastUpdated | string | The date/time the product was last updated. Expressed according to ISO 8601. Example: `2016-02-25T08:49:31Z`|

## variation

| Attribute | Type | Description |
| - | :-: |  - |
| link | [link](page:apps-data-types#link)| The link to the product variation. |
| attributeSelection | array of [attributeSelection](page:apps-data-types#attributeselection) | The attribute of the selected product variation. |

## variationAttribute

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the variation attribute. |
| displayName | string | The displayed name of the variation attribute. |
| values | array of [variationValue](page:apps-data-types#variationvalue) | The values of the variation attribute.  |

## variationValue

| Attribute | Type | Description |
| - | :-: |  - |
| value | string | The key of an attribute, e.g. 004. |
| displayValue | string | The displayed name of the attribute, e.g. XtraLarge. |
