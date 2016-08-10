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
| refQuantity  | object of [quantity](page:apps-data-types#quantity) | The standardised unit for the product, e.g. 1 l. |
| refPrice | object of [price](page:apps-data-types#price) | The price based upon the standardised unit. |
| formatted | string | The formatted output of the base price information, e.g. 1 l = 1.20 EUR. |
| quantity | object of [quantity](page:apps-data-types#quantity) | The quantity of the product, e.g. 500 ml. |

## cart

| Attribute | Type | Description |
| - | :-: |  - |
| cartId | string | The unique identifier of the cart. |
| billingAddress | [address](page:apps-data-types#address) | The billing address for a cart. |
| shippingAddress | [address](page:apps-data-types#address) | The shipping address for a cart. |
| lineItemContainer | [lineItemContainer](page:apps-data-types#lineitemcontainer) | Contains the line items of a cart. |
| shippingData | object of [shippingData](page:apps-data-types#shippingdata) | The shipping data of a cart or an order, i.e. short info on shipping method and price.|
| paymentData | object of [paymentData](page:apps-data-types#paymentdata) | The payment data of  a cart or an order, i.e. short info on payment method and price.|
| minimumCart | object of [minimumCart](page:apps-data-types#minimumcart) | The minimum order value of a shop. |
| pickupToken | string | For internal use only. Can be ignored. |
| checkoutURL | string | The URL that redirects the browser to the merchant’s shop in order to complete the checkout. |

## cart (create request)

| Attribute | Type | Description |
| - | :-: |  - |
| currency | string | The currency code of the price according to ISO 4217.|
| taxType | string | Indicates if the amount includes tax. Can be gross, net or none.|
| locale | string | The locale that identifies the origin of the customer.|
| lineItems | array of [productLineItem (create request)](page:apps-data-types#productlineitem-create-request)  | The product line items in the basket.|

## category

| Attribute | Type | Description |
| - | :-: |  - |
| categoryId | string | The unique identifier of the category a product is assigned to. |
| name | string | The name of the category. |
| pageTitle | string | The page title of this category. |
| description | string | The description of the category. |
| specialOffer | boolean | Indicates if this category has special offers. |
| images | array of [image](page:apps-data-types#image) | The images belonging to this category. |
| parent | [link](page:apps-data-types#link) | The link to the parent category. |
| subCategories | array of [link](page:apps-data-types#link) | A list of links to the subcategories. |
| sfUrl | string | The link to the categories in the shop’s storefront. |

## category (create request)

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the category. |
| alias | string | The unique identifier of the new category. If already in use, the system will automatically increment by number, e.g. alias1, alias2. |
| pageTitle | string | The page title of the category. |
| description | string | The description of the category. |
| navigationCaption | string | The name of the category that appears in the navigation bar. |

## category (update request)

| Attribute | Type | Description |
| - | :-: |  - |
| categoryId | string | The unique identifier of the category a product is assigned to. |
| name | string | The name of the category. |
| pageTitle | string | The page title of this category. |
| description | string | The description of the category. |

## contactInfo

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name that appears on the contact information page, e.g. Contact Us. |
| title | string | The name of the contact information page, that appears on the browser tab. |
| navigationCaption | string | The name of the contact information page that appears in the navigation bar. |
| shortDescription | string | Additional short information that can be given to e.g. better explain what's on the contact information page. |
| description | string | Additional information that can be added to the contact information page, e.g. tax identification number or bank account. |
| company | string | The name of the shop. |
| contactPerson | string | The contact person for the shop, usually the shop owner. |
| contactPersonJobTitle | string | The job title of the contact person. |
| address | string | The postal address of the shop. |
| phone | string | The phone number of the shop. |
| email | string | The email address of the shop. |

## contentPage

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name that appears on the page.|
| title | string | The name of the page, that appears on the browser tab.|
| navigationCaption | string | The name of the page, that appears in the navigation bar.|
| shortDescription | string | Additional short information that can be given to better explain what’s on the page.|
| description | string | Information on the topic of the page.|

## contentPageSummary

| Attribute | Type | Description |
| - | :-: |  - |
| contactInformation | [contentPageSummaryItem](page:apps-data-types#contentpagesummaryitem) | The shop’s contact information. |
| privacyPolicy | [contentPageSummaryItem](page:apps-data-types#contentpagesummaryitem) | The shop’s privacy policy. |
| rightsOfWithdrawal | [contentPageSummaryItem](page:apps-data-types#contentpagesummaryitem) | The shop’s rights of withdrawal. |
| termsAndConditions | [contentPageSummaryItem](page:apps-data-types#contentpagesummaryitem) | The shop’s terms and conditions. |
| shippingInformation | [contentPageSummaryItem](page:apps-data-types#contentpagesummaryitem) | The shop’s shipping conditions. |
| links | array of [link](page:apps-data-types#link) | The links to the shop's [contact information](page:apps-api-get-shops-shopid-legal-contact-information-information), [privacy policy](page:apps-api-get-shops-shopid-legal-privacy-policy-information), [rights of withdrawal](page:apps-api-get-shops-shopid-legal-rights-of-withdrawal-information), [terms and conditions](page:apps-api-get-shops-shopid-legal-terms-and-conditions-information) and [shipping conditions](page:apps-api-get-shops-shopid-legal-shipping-information-information). |

## contentPageSummaryItem

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the content page. |

## couponLineItem

| Attribute | Type | Description |
| - | :-: |  - |
| couponLineItemId | string | The unique identifier of the coupon line item. |
| lineItemPrice | object of [price](page:apps-data-types#price) | The price of the line item. |

## customAttribute

| Attribute | Type | Description |
| - | :-: |  - |
| key | string | The identifier of the custom attribute. |
| displayKey | string | The displayed name of the custom attribute. |
| singleValue | boolean | Indicates if just one feature is selected for the custom attribute.  |
| type | enum | The data type of the custom attribute. Can be *string*, *number*, *bool*, *datetime*, *time*, *url*.|
| values | array of [variationValue](page:apps-data-types#variationvalue)| The options selected for the custom attribute. |

## customer

| Attribute | Type | Description |
| - | :-: |  - |
| customerId | string | The unique identifier of the customer. |
| customerNumber | string | The number by which the merchant tracks the customer. |
| creationDate | string | The date/time the customer was created. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z` |
| billingAddress | [address](page:apps-data-types#address) | The billing address of the customer. |
| internalNote | string | Internal note for the customer done by the merchant. |
| links | array of [link](page:apps-data-types#link) | The link to the customer and their orders. |

## customer (create request)

| Attribute | Type | Description |
| - | :-: |  - |
| customerNumber | string | The number by which the merchant tracks the customer. If not provided, the customer number will be generated automatically.|
| internalNote | string | Internal note for the customer done by the merchant. |
| billingAddress | [address](page:apps-data-types#address) | The billing address of the customer. |

## deliveryWeightQuantity

| Attribute | Type | Description |
| - | :-: |  - |
| amount | number | The amount displayed as a decimal number. |
| unit | enum | The unit displayed as abbreviated unit, if available. Can be *g*, *kg*, *mg*, *oz*, *lb* or *t*. Otherwise a localised name of the unit is displayed. Can be gram(s), *kilogram(s)*, *milligram(s)*, *ounce(s)*, *pound(s)* or *ton(s)*.  |

## image

| Attribute | Type | Description |
| - | :-: |  - |
| url | string | The URL of an image. |
| classifier | string | Specifies the image. Can be *Thumbnail*, *Small*, *HotDeal*, *MediumSmall*, *Medium*, *MediumLarge*, *Large*. |

## imageInfo

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the slideshow image. |
| sizes | array of [image](page:apps-data-types#image) | The size of the images in the slideshow. |

## jsonPatch

| Attribute | Type | Description |
| - | :-: |  - |
| op | string | Patch operation to perform. |
| path | string | Contains the value that references the location where the operation is performed. |
| value | object | New value to apply.  |

## lineItemContainer

| Attribute | Type | Description |
| - | :-: |  - |
| grandTotal | object of [price](page:apps-data-types#price) | The total price including product price, shipping and tax. |
| totalBeforeTax | object of  [price](page:apps-data-types#price) | The total price including product price, shipping excluding tax. |
| totalTax | object of [price](page:apps-data-types#price) | The total amount of the tax. |
| lineItemsSubTotal | object of [price](page:apps-data-types#price) | The sum of the line item price of all line items. |
| productLineItems | array of [productLineItem](page:apps-data-types#productlineitem) | A list of line items. |
| shippingPrice | object of [price](page:apps-data-types#price) | The shipping price of the line item. |
| couponLineItem | array of [couponLineItem](page:apps-data-types#couponlineitem) | Contains the line items of a coupon. |

## link

| Attribute | Type | Description |
| - | :-: |  - |
| rel | string | The link relation that describes how the link relates to the call. |
| href | string | The URL of the related link that can be used for subsequent calls. |
| title | string | The title of the item that is linked. (optional)  |

## minimumCart

| Attribute | Type | Description |
| - | :-: |  - |
| status | boolean | Indicates if the minimum order value is exceeded. Creating an order is not possible when a cart is posted with the minimumCart status `false´. |
| code | string | Represents the selected value of the minimum order value that can be set by the merchant in the administration area of the shop. Can be one of *SumProduct*, *SumCoupon*, *SumDiscount*, *SumDelivery* or *SumPayment*. |
| amount | object of [price](page:apps-data-types#price) | The amount of the minimum value in the basket with currency and tax type. |

## newsletterCampaign

| Attribute | Type | Description |
| - | :-: |  - |
| campaignId | string | The unique identifier of the newsletter campaign. |
| language | string | The language of the newsletter campaign. |
| identifier | string | The alias of the newsletter campaign.  |
| name | string | The name of the newsletter campaign. |
| description | string | The description of the newsletter campaign. |
| numberOfSubscribers | string | The number of persons that subscribed for the newsletter campaign. |
| subject | string | The subject of the newsletter campaign chosen by the merchant.|

## newsletterSubscriber

| Attribute | Type | Description |
| - | :-: |  - |
| email | string | The email address of the subscriber. |
| name | string | The name of the subscriber. |
| subscribed | boolean | Indicates if this person is subscribed for the newsletter campaign. |

## order

| Attribute | Type | Description |
| - | :-: |  - |
| orderId | string | The unique identifier of the order. |
| orderNumber | string | The order number. |
| creationDate | string | The date/time of order placement. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z` |
| billingAddress | [address](page:apps-data-types#address) | The billing address for the order.  |
| shippingAddress | [address](page:apps-data-types#address) | The shipping address for the order.  |
| invoicedOn | string | The date/time the order was invoiced. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| partiallyPaidOn | string | The date/time a part of the order was paid. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| deliveredOn | string | The date/time the order was delivered. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| partiallyInvoicedOn | string | The date/time a part of the order was invoiced. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| pendingOn | string | The date/time the order was set to pending. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| readyForDispatchOn | string | The date/time the order was prepared for dispatching. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| partiallyDispatchedOn | string | The date/time a part of the order was dispatched. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| archivedOn | string | The date/time the order was archived. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| dispatchedOn | string | The date/time the order was dispatched. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| viewedOn | string | The date/time the order was viewed. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`   |
| customerId | string | The unique identifier of the customer.  |
| customerNumber | string | The number by which the merchant tracks the customer. |
| locale | string | The locale that identifies the origin of the customer.  |
| currencyId | string | The unique identifier of the currency used for payment.  |
| taxModel | string | The taxmodel that applies for the order, e.g. gross.  |
| grandTotal | string | The total cost of the order.  |
| totalBeforeTax | string | The total cost of the order before tax is applied.  |
| internalNote | string | Internal notes for the order done by the merchant.  |
| customerComment | string | Notes on the order from the customer. Can also be amended by the merchant in the administration. Mainly used for order and delivery notes.|
| rejectedOn | string | The date/time the order was rejected. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| inProcessOn | string | The date/time the order was put into process. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| closedOn | string | The date/time the order was closed. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| paidOn | string | The date/time the order was paid. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| returnedOn | string | The date/time the order was returned. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| shippingData | object of [shippingData](page:apps-data-types#shippingdata) | The shipping data of  a cart or an order, i.e. short info on shipping method and price.|
| paymentData | object of [paymentData](page:apps-data-types#paymentdata) | The payment data of  a cart or an order, i.e. short info on payment method and price.|
| lineItemContainer | [lineItemContainer](page:apps-data-types#lineitemcontainer) | Contains the line items of an order. Only included in [`GET`/orders/{orderId}](page:apps-api-get-shops-shopid-orders-orderid-information). |
| productLineItems | array of [productLineItem](page:apps-data-types#productlineitem) | A list of line items. Only included in [`GET`/orders/{orderId}](page:apps-api-get-shops-shopid-orders-orderid-information). |
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
| taxType | string | Indicates if the amount includes tax. Can be gross, net or none. |
| formatted | string | The amount of the price with currency unit. |
| amount | number | The amount of the price. |
| currency | string | The currency code of the price according to ISO 4217. |

## priceInfo

| Attribute | Type | Description |
| - | :-: |  - |
| quantity | object of [quantity](page:apps-data-types#quantity) | The quantity of the product the price refers to.|
| taxClass | object of [taxClassInfo](page:apps-data-types#taxclassinfo) | The tax that applies for the product.|
| price | object of [price](page:apps-data-types#price) | The price of the product.|
| depositPrice | object of [price](page:apps-data-types#price) | The deposit price for the product, e.g. bottle deposit.|
| ecoParticipationPrice | object of [price](page:apps-data-types#price) | The advance recycling fee for electric and electronic products which is only in some countries prescribed by law.|
| manufacturerPrice | object of [price](page:apps-data-types#price) | The sales price recommended by the manufacturer.|
| priceWithDeposits | object of [price](page:apps-data-types#price) | The price including all deposits, i.e. price, depositPrice and ecoParticipationPrice.|
| basePrice | object of [basePrice](page:apps-data-types#baseprice) | The price information scaled to a standardised base unit, according to the German base price regulation "Preisangabenverordnung" (PAngV), e.g. 1 l = 1.20 EUR. Is `null` if no reference amount is specified for the product.|

## product

| Attribute | Type | Description |
| - | :-: |  - |
| productId | string | The unique identifier of the product. |
| name | string | The name of the product. |
| visible | boolean | Indicates if the product is displayed in the shop. |
| shortDescription | string | The short description of the product. |
| deliveryPeriod | string | The average time of the product being delivered to the customer. By default, the delivery period is displayed in days, but this can be changed by the merchant. |
| description | string | The description of the product. |
| priceInfo | object of [priceInfo](page:apps-data-types#priceinfo) | Price information on the product. |
| forSale | boolean | Information on the sale status of the product. Indicates if the product can be added to the shopping basket. |
| specialOffer | boolean | Indicates if the product is a special offer. |
| deliveryWeight | object of [deliveryWeightQuantity](page:apps-data-types#deliveryweightquantity) | The delivery weight of the product. |
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
| stocklevel | string | Only available with the `products_write` authorisation. Indicates the stocklevel of the product. |
| links | array of [link](page:apps-data-types#link) | The links to the product and product category. |

## product (create request)

| Attribute | Type | Description |
| - | :-: |  - |
| productNumber | string | The product number (mandatory). |
| name | string | The name of the product. |
| shortDescription | string | The short description of the product. |
| description | string | The description of the product. |
| manufacturer | string | The manufacturer of the product. |
| price | number | The price of the product. |
| essentialFeatures | string | The essential features of the product. |
| energyLabelsString | string | A list of energy labels applied to this product. Can be one or two values. If two values are returned, the first value is the best energy label, the second is the second-best. |
| upc | string | The Universal Product Code of the product. |
| ean | string | The European Article Number of the product, either EAN-8 or EAN-13. |

## productLineItem

| Attribute | Type | Description |
| - | :-: |  - |
| lineItemId | string | The unique identifier of the line item. |
| sku | string | The stock keeping unit (SKU) corresponding to the line item. |
| name | string | The name of the line item. |
| productId | string | The unique identifier of the product. |
| quantity |object of [quantity](page:apps-data-types#quantity) | The quantity of the line item. |
| lineItemPrice | object of [price](page:apps-data-types#price) | The price of the line item. |
| singleItemPrice | object of  [price](page:apps-data-types#price) | The price for a single item. |
| essentialFeatures | string | The essential features of the line item. |
| images | array of [image](page:apps-data-types#image) | The image of the line item. |
| links | array of [link](page:apps-data-types#link) | The links to the product line item. |
| taxClass | object of [taxClassInfo](page:apps-data-types#taxclassinfo) | The tax that applies for the product.|
| deliveryWeight | object of [deliveryWeightQuantity](page:apps-data-types#deliveryweightquantity) | The delivery weight for the product line item.|

## productLineItem (create request)

| Attribute | Type | Description |
| - | :-: |  - |
| productId | string | The unique identifier of the product.|
| quantity | number | The product quantity of this line item displayed as a decimal number.|

## productLineItem (update request)

| Attribute | Type | Description |
| - | :-: |  - |
| quantity | number | The quantity of the product line item displayed as a decimal number.|

## productSuggest

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the product resulting from the query. |
| images | array of [image](page:apps-data-types#image) | The image of the product resulting from the query. |
| link | [link](page:apps-data-types#link) | The link to the product resulting from the query. |

## quantity

| Attribute | Type | Description |
| - | :-: |  - |
| amount | number | The amount displayed as a decimal number. |
| unit | enum | The unit displayed as abbreviated unit, if available. Can be one of *Byte*, *kByte*, *MByte*, *GByte*, *TByte*, *l*, *ml*, *ft³*, *in³*, *m³*, *yd³*, *fl oz*, *gal*, *qt*, *m*, *cm*, *ft*, *in*, *km*, *mm*, *yd*, *s*, *min*, *m²*, *cm²*, *ft²*, *in²*, *mm²* or *yd²*. Otherwise a localised name of the unit is displayed. Can be *piece(s)*, *bottle(s)*, *crate(s)*, *can(s)*, *capsule(s)*, *box(es)*, *glass(es)*, *kit(s)*, *pack(s)*, *package(s)*, *pair(s)*, *roll(s)*, *set(s)*, *sheet(s)*, *ticket(s)*, *unit(s)*, *day(s)*, *hour(s)*, *week(s)*, *month(s)*, *night(s)* or *year(s)*. |

## sales

| Attribute | Type | Description |
| - | :-: |  - |
| currency | string | The currency code according to ISO 4217. |
| totalGrossRevenue | number | The total gross revenue received from completed orders.|
| totalNetRevenue | number | The total net revenue received from completed orders.|
| unitsSold | number | The number of sold product units (only available with active filter productId). |
| totalOrders | number | The number of orders for the defined time frame. |

## salesSummary

| Attribute | Type | Description |
| - | :-: |  - |
| createdAfter | string | The date and time of orders created after this timestamp (format according to ISO 8601). |
| createdBefore | string | The date and time of orders created before this timestamp (format according to ISO 8601). |
| salesPerCurrency | array of [sales](page:apps-data-types#sales)| The sales summary grouped by currency. |

## shippingData

| Attribute | Type | Description |
| - | :-: |  - |
| shippingMethod | object of [shippingMethodInfo](page:apps-data-types#shippingmethodinfo) | Information on the shipping method chosen by the customer. |
| price | object of [price](page:apps-data-types#price) | The costs for the shipping. |

## shippingMethod

| Attribute | Type | Description |
| - | :-: |  - |
| shippingMethodId | string | The unique identifier of the shipping method. |
| name | string | The name of the shipping method chosen by the customer.|
| description | string | The description of the shipping method.|
| logo | string | The logo of the shipping method. |

## shippingMethodInfo

| Attribute | Type | Description |
| - | :-: |  - |
| id | string | The unique identifier of the shipping method. |
| name | string | The name of the shipping method chosen by the customer. |

## shopInfo

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the shop. |
| slogan | string | The slogan of the shop.|
| logoUrl | string | The URL to the logo of the shop.|
| sfUrl | string | The URL to the storefront of the shop. |
| mboUrl | string | The URL to the administration area of the shop. |

## subcategory

| Attribute | Type | Description |
| - | :-: |  - |
| categoryId | string | The unique identifier of the new category. |
| alias | string | The alternate name that uniquely identifies the category. If already in use, the system will automatically increment by number, e.g. alias1, alias2. |
| name | string | The name of the category. |
| pageTitle | string | The page title of this category. |
| description | string | The description of the category. |
| parent | object of [link](page:apps-data-types#link) | The link to the parent category. |
| sfUrl | string | The link to the categories in the shop’s storefront. |
| links | array of [link](page:apps-data-types#link) | A list of links to the products. |

## taxClassInfo

| Attribute | Type | Description |
| - | :-: |  - |
| taxClassId | string | The unique identifier of the tax class. |
| name | string | The name of the tax class. |
| percentage | number | The percentage the product is taxed with.|

## taxClass

| Attribute | Type | Description |
| - | :-: |  - |
| taxClassId | string | The unique identifier of the tax class. |
| name | string | The name of the tax class. |
| links | array of [link](page:apps-data-types#link) | A list of links to the products. |

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

## watchedProduct

| Attribute | Type | Description |
| - | :-: |  - |
| productId | string | The unique identifier of the product. |
| name | string | The name of the product. |
| productNumber | string | The product number. |
| watchers | number | The number of watchers. |
| links | array of [link](page:apps-data-types#link) | The link to the watched product. |
