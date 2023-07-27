---
layout: docs
key: apps-data-types
title: Data types
---

## additionalData

This object represents the attribute structure for PayPal PLUS. The structure for other external payments might differ.

| Attribute | Type | Description |
| - | - |  - |
| InvoiceBankName  | string | The name of the bank that holds the bank account to which the invoice is due. |
| InvoiceAmount  | number | The invoice amount displayed as a decimal number. |
| InvoiceAccountHolderName  | string | The name of the bank account holder to whom the invoice is due. |
| InvoiceIBAN  | string | The International Bank Account Number of the bank account to which the invoice is due. |
| InvoiceReferenceNumber  | string | The unique reference code that is assigned to the invoice. |
| InvoiceCurrency  | string | The currency code of the invoice amount. Expressed according to ISO 4217. |
| InvoicePaymentDueDate  | string | The due date of the invoice. Expressed according to ISO 8601. Example: `2020-11-04T08:42:49.000Z`|
| InvoiceBIC  | string | The Bank Identifier Code of the bank that holds the account to which the invoice is due. |

## additionalInformation

ePages Now only!

| Attribute | Type | Description |
| - | - |  - |
| bulkPriceInfo | array of [bulkPriceInfo](page:apps-data-types#bulkpriceinfo) | Information on bulk pricing for the product. |

## address

This object is used for the attributes of shippingAddress and billingAddress.

| Attribute | Type | Description |
| - | - |  - |
| company | string | The customer's company.|
| salutation | string | The customer's salutation, e.g. Mr or Mrs.|
| title | string | The customer's academic title, e.g. professor or PhD.|
| firstName | string | The customer's first name.|
| lastName | string | The customer's last name.|
| street | string | The street name of the customer's address. |
| streetDetails | string | An additional field for the street address.|
| zipCode | string | The zip or postal code of the address. |
| city | string | The name of the city. |
| state | string | The name of the state.|
| country | string | The name of the country. |
| vatId | string | The Id of the VAT.|
| birthday | string | The customer's date of birth. |
| emailAddress | string | The customer's primary email address. This email address will be used by the merchant if the customer does not have a user account. |
| addressExtension | string | Further address details of the customer.  |
| bankAccountHolder | string | The name of the bank account holder. |
| bankAccountNumber | string | The bank account number. |
| bankName | string | The name of the bank that holds the bank account. |
| bankSortCode | string | The bank identifier code. |
| businessEmailAddress | string | The customer's business email address. |
| businessPhoneNumber | string | The customer's business phone number. |
| department | string | The department of the company associated with the customer's address. |
| displayName | string | Specifies the name to display for the customer name. |
| doorCode | string | The door code associated with the customer's address.  |
| faxNumber | string | The customer's fax number. |
| fiscalCode | string | The customer's fiscal code. |
| gender | string | The customer's gender. Can be either *MALE* or *FEMALE*. |
| jobTitle | string | The customer's job title. |
| middleName | string | The customer's middle name. |
| mobilePhoneNumber | string | The customer's mobile phone number. |
| phoneNumber | string | The customer's landline number. |
| privateEmailAddress | string | The customer's private email address. |
| privatePhoneNumber | string | The customer's private phone number |
| websiteUrl | string | The customer's website URL.  |

## attributeProductType

ePages Now only!

| Attribute | Type | Description |
| - | - |  - |
| name | string | The name for the attribute. |
| preDefAttribute | boolean | Indicates if the attribute has predefined values. |
| values | [attributeSelection](page:apps-data-types#attributeselection) | The values of the selected attribute for the product type. |
| visible | boolean | Indicates if the attribute is displayed in the shop. |

## attributeRange

| Attribute | Type | Description |
| - | - |  - |
| min  | string | The minimum range of the filter applied. |
| max  | string | The maximum range of the filter applied. |

## attributeSelection

| Attribute | Type | Description |
| - | - |  - |
| name | string | The name of the selected product attribute, e.g. colour. |
| value | string | The assigned value of the selected product attribute, e.g. white. |

## basePrice

| Attribute | Type | Description |
| - | - |  - |
| refQuantity  | object of [quantity](page:apps-data-types#quantity) | The standardised unit for the product, e.g. 1 l. |
| refPrice | object of [price](page:apps-data-types#price) | The price based upon the standardised unit. |
| formatted | string | The formatted output of the base price information, e.g. 1 l = 1.20 EUR. |
| quantity | object of [quantity](page:apps-data-types#quantity) | The quantity of the product, e.g. 500 ml. |

## bulkPriceInfo

ePages Now only!

| Attribute | Type | Description |
| - | - |  - |
| quantity | object of [quantity](page:apps-data-types#quantity) | The quantity of the product the price refers to.|
| price | object of [price](page:apps-data-types#price) | The price of the product.|
| basePrice | object of [basePrice](page:apps-data-types#baseprice) | The price information scaled to a standardised base unit, according to the German base price regulation "Preisangabenverordnung" (PAngV), e.g. 1 l = 1.20 EUR. Is `null` if no reference amount is specified for the product.|
| priceSavings | object of [priceSavings](page:apps-data-types#pricesavings) | Information on the discount the customer benefits from due to the merchant's settings for customer-specific prices. |

## customerSpecificPriceInfo

ePages Now only!

| Attribute | Type | Description |
| - | - |  - |
| customerGroup | string | The name of the customer group. |
| customerGroupId | string | The unique identifier of the customer group. |
| priceInfo | array of [bulkPriceInfo](page:apps-data-types#bulkpriceinfo) | Information on customer specific bulk pricing for the product. |

## cart

| Attribute | Type | Description |
| - | - |  - |
| cartId | string | The unique identifier of the cart. |
| billingAddress | [address](page:apps-data-types#address) | The billing address for a cart. |
| shippingAddress | [address](page:apps-data-types#address) | The shipping address for a cart. |
| lineItemContainer | [lineItemContainer](page:apps-data-types#lineitemcontainer) | Contains the line items of a cart. |
| shippingData | object of [shippingData](page:apps-data-types#shippingdata) | The shipping data of a cart or an order, i.e. short info on shipping method and price.|
| paymentData | object of [paymentData](page:apps-data-types#paymentdata) | The payment data of  a cart or an order, i.e. short info on payment method and price.|
| minimumCart | object of [minimumCart](page:apps-data-types#minimumcart) | The minimum order value of a shop. |
| pickupToken | string | For internal use only. Can be ignored. |
| creationDate | string | The date/time the cart was created. Expressed according to ISO 8601. Example: `2018-12-17T21:07:29Z` |
| checkoutUrl | string | The URL that redirects the browser to the merchant's shop in order to complete the checkout. |
| registerSessionUrl | string | The URL that redirects the browser to the merchant's shop in order to register a session. |
| cartValidation | object of [cartValidation](page:apps-data-types#cartvalidation) | The list of all validations with regard to the cart. |
| potentialBasketDiscounts | object of [potentialBasketDiscounts](page:apps-data-types#potentialbasketdiscounts) | The list of all potential overall discounts for orders in the shop. The included discounts can be of type *absolute* or *percent*.|
| status | string | The status of the cart. If all line items were added successfully, it is *Complete*. Otherwise, it is *PartiallyComplete*. Only included in [`POST`/carts](page:apps-api-post-shopid-carts-information) if the attribute *forceCreate* is `true` and in [`POST`/carts/{cartId}/multi-line-items](page:apps-api-post-shopid-carts-cartid-multi-line-items-information). |

## cart (create request)

| Attribute | Type | Description |
| - | - |  - |
| currency | string | The currency code of the price according to ISO 4217.|
| taxType | string | Indicates if the amount includes tax. Can be *GROSS*, *NET* or *NONE*.|
| locale | string | The locale that identifies the origin of the customer.|
| lineItems | array of [productLineItem (create request)](page:apps-data-types#productlineitem-create-request)  | The product line items in the cart.|
| forceCreate | boolean | Creates a cart if at least one of several line items can be added to the cart successfully. (optional)|

## cartValidation

| Attribute | Type | Description |
| - | - |  - |
| possibleShippingMethods | string[] | The shipping methods that are valid for the current set of products included in the cart. |

## category

| Attribute | Type | Description |
| - | - |  - |
| categoryId | string | The unique identifier of the category a product is assigned to. |
| name | string | The name of the category. |
| visible | boolean | Indicates if the category is displayed in the shop. |
| visibleInNavigation | boolean | Indicates if the category is displayed in the shop navigation. |
| alias | string | The unique identifier of the category.|
| pageTitle | string | The page title of this category. |
| description | string | The description of the category. |
| specialOffer | boolean | Indicates if this category has special offers. |
| images | array of [image](page:apps-data-types#image) | The images belonging to this category. |
| parent | [link](page:apps-data-types#link) | The link to the parent category. |
| subCategories | array of [link](page:apps-data-types#link) | A list of links to the subcategories. |
| navigationCaption | string | The name of the category page that appears in the navigation bar. |
| sfUrl | string | The link to the categories in the shop's storefront. |
| facetedSearchShowFacetsOnCategory | boolean | Indicates if the search field is displayed on category pages. |
| facetedSearchCategoryStartDepth | number | The category level for displaying the search field on category pages. The search field is displayed on the indicated level and all sub levels. |

## category (create request)

| Attribute | Type | Description |
| - | - |  - |
| name | string | The name of the category. |
| alias | string | The unique identifier of the new category. If already in use, the system will automatically increment by number, e.g. alias1, alias2. |
| pageTitle | string | The page title of the category. |
| description | string | The description of the category. |
| navigationCaption | string | The name of the category that appears in the navigation bar. |

## category (update request)

| Attribute | Type | Description |
| - | - |  - |
| categoryId | string | The unique identifier of the category a product is assigned to. |
| name | string | The name of the category. |
| alias | string | The unique identifier of the category.|
| pageTitle | string | The page title of this category. |
| description | string | The description of the category. |
| navigationCaption | string | The name of the category page that appears in the navigation bar. |
| visible | boolean | Indicates if the category is displayed in the shop. |
| visibleInNavigation | boolean | Indicates if the category is displayed in the shop navigation. |

## contactInfo

| Attribute | Type | Description |
| - | - |  - |
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
| - | - |  - |
| name | string | The name that appears on the page.|
| title | string | The name of the page, that appears on the browser tab.|
| navigationCaption | string | The name of the page, that appears in the navigation bar.|
| shortDescription | string | Additional short information that can be given to better explain what's on the page.|
| description | string | Information on the topic of the page.|

## contentPageSummary

| Attribute | Type | Description |
| - | - |  - |
| contactInformation | [contentPageSummaryItem](page:apps-data-types#contentpagesummaryitem) | The shop's contact information. |
| privacyPolicy | [contentPageSummaryItem](page:apps-data-types#contentpagesummaryitem) | The shop's privacy policy. |
| rightsOfWithdrawal | [contentPageSummaryItem](page:apps-data-types#contentpagesummaryitem) | The shop's rights of withdrawal. |
| termsAndConditions | [contentPageSummaryItem](page:apps-data-types#contentpagesummaryitem) | The shop's terms and conditions. |
| shippingInformation | [contentPageSummaryItem](page:apps-data-types#contentpagesummaryitem) | The shop's shipping conditions. |
| links | array of [link](page:apps-data-types#link) | The links to the shop's [contact information](page:apps-api-get-shopid-legal-contact-information-information), [privacy policy](page:apps-api-get-shopid-legal-privacy-policy-information), [rights of withdrawal](page:apps-api-get-shopid-legal-rights-of-withdrawal-information), [terms and conditions](page:apps-api-get-shopid-legal-terms-and-conditions-information) and [shipping conditions](page:apps-api-get-shopid-legal-shipping-information-information). |

## contentPageSummaryItem

| Attribute | Type | Description |
| - | - |  - |
| name | string | The name of the content page. |

## countries

| Attribute | Type | Description |
| - | - |  - |
| nativeName | string | The endonym(s) for the country. |
| countryIsDefault | boolean | Indicates if the country is the default country for the shop. |
| code3 | string | The country code according to ISO 3166-1 Alpha code 3. |
| code2 | string | The country code according to ISO 3166-1 Alpha code 2. |
| englishName | string | The country name in English. |
| countryIsEU | boolean | Indicates if the country is a member country of the European Union (EU). |
| countryID | string | The country ID according to ISO 3166-1 Numeric code. |

## couponCampaign (create request)

| Attribute | Type | Description |
| - | - |  - |
| identifier | string | The alias of the coupon campaign. |
| name | string | The name of the coupon campaign. |
| currency | string | The currency code according to ISO 4217. |
| minimumOrderValue | string | The minimum order value of the coupon campaign, if customers are required to purchase at least a minimum amount to being able to redeem a coupon. |
| type | object of [valueType](page:apps-data-types#valuetype) | The type of the coupon campaign. Can be one of *FIX*, *PERCENT*, or *SHIPPING*. |

## couponCampaign

| Attribute | Type | Description |
| - | - |  - |
| campaignId | string | The unique identifier of the coupon campaign. |
| identifier | string | The alias of the coupon campaign. |
| name | string | The name of the coupon campaign. |
| currency | string | The currency code according to ISO 4217. |
| type | object of [valueType](page:apps-data-types#valuetype) | The type of the coupon campaign. Can be one of *FIX*, *PERCENT*, or *SHIPPING*. |
| minimumOrderValue | object of [price](page:apps-data-types#price) | The minimum order value of the coupon campaign, if customers are required to purchase at least a minimum amount to being able to redeem a coupon. |
| links | array of [link](page:apps-data-types#link) | The link to the exact coupon campaign. |

## couponLineItem

| Attribute | Type | Description |
| - | - |  - |
| couponLineItemId | string | The unique identifier of the coupon line item. |
| couponCampaignId | string | The unique identifier of the campaign the coupon belongs to. |
| lineItemPrice | object of [price](page:apps-data-types#price) | The price of the line item (`singleItemPrice` multiplied by `quantity`). |
| validationErrors | array of error strings | The error that occurred when redeeming a coupon for this cart. Can be one of *LineItemsSubTotalTooSmall*, *CouponIsInvalidated*, *ValidCouponCountReached*, *CouponNotEffective*, *PaymentMethodMisMatch*, *ShippingMethodMisMatch*, *ProductMisMatch*.

## crossselling

| Attribute | Type | Description |
| - | - |  - |
| manualCrossSellingTitle | string | The headline displayed for all crossselling products. Can be edited by the merchant in the administration area. |
| embedded | object of [productsPaged](page:apps-data-types#productspaged) | The complete product object with the list of all crossselling products. |
| links | array of [link](page:apps-data-types#link) | The references the crossselling product is linked to. |

## customAttribute

| Attribute | Type | Description |
| - | - |  - |
| key | string | The identifier of the custom attribute. |
| displayKey | string | The displayed name of the custom attribute. |
| singleValue | boolean | Indicates if just one feature is selected for the custom attribute.  |
| type | string | The data type of the custom attribute. Can be *string*, *number*, *bool*, *datetime*, *time*, *url*.|
| values | array of [variationValue](page:apps-data-types#variationvalue)| The options selected for the custom attribute. |

## customer

| Attribute | Type | Description |
| - | - |  - |
| customerId | string | The unique identifier of the customer. |
| customerNumber | string | The number by which the merchant tracks the customer. |
| creationDate | string | The date/time the customer was created. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z` |
| billingAddress | [address](page:apps-data-types#address) | The billing address of the customer. |
| internalNote | string | Internal note for the customer done by the merchant. |
| links | array of [link](page:apps-data-types#link) | The link to the customer and their orders. |

## customer (create request)

| Attribute | Type | Description |
| - | - |  - |
| customerNumber | string | The number by which the merchant tracks the customer. If provided, the customer number must be unique. If not provided, the customer number will be generated automatically.|
| internalNote | string | Internal note for the customer done by the merchant. |
| billingAddress | [address](page:apps-data-types#address) | The billing address of the customer (mandatory). |

## deliveryWeightQuantity

| Attribute | Type | Description |
| - | - |  - |
| amount | number | The amount displayed as a decimal number. |
| unit | string | The abbreviation of the delivery weight unit. Can be *g*, *kg*, *mg*, *oz*, *lb* or *t*.  |

## depositLineItem

| Attribute | Type | Description |
| - | - |  - |
| name | string | The name of the line item. |
| lineItemPrice | object of [price](page:apps-data-types#price) | The price of the line item (`singleItemPrice` multiplied by `quantity`). |
| lineItemProductGuid | string | The identifier of the related product line item. A deposit is always bound to a product.|

## facet

| Attribute | Type | Description |
| - | - |  - |
| attributeName | string | The name of the filter. Can be *ListPrice*, *Manufacturer*, *CategoryID*, or any other attribute created by the merchant.  |
| attributeType | string | The type of the filter. Is *Standard* for *Manufacturer*, *CategoryID*, or *ListPrice*. Is *PreDefString* for any other attribute created by the merchant. |
| values | array of [filterValues](page:apps-data-types#filtervalues) | The values to refine the search. |

## filter

| Attribute | Type | Description |
| - | - |  - |
| attributeValue  | string | The value of the facet. |
| attributeRange  | object of [attributeRange](page:apps-data-types#attributerange) | The minimum and maximum range of the filter applied. |
| fieldName  | string | The alias of the filter.  |

## filterValues

| Attribute | Type | Description |
| - | - |  - |
| matches | string | The number of objects that match the specified filter criteria. |
| name | string | The localized name of the attribute. |
| filter | object of [filter](page:apps-data-types#filter) | The available filter with name and value or name and range that is used for filtering. |
| selectedValue | string | The search term(s) used for filtering.  |

## image

| Attribute | Type | Description |
| - | - |  - |
| url | string | The URL of an image. |
| isZoomEnabled | boolean | Indicates if the zoom is enabled for a product image. Can be `true` or `false`. |
| classifier | string | Specifies the image. Can be *Thumbnail*, *Small*, *HotDeal*, *MediumSmall*, *Medium*, *MediumLarge*, *Large*. |
| width | string | The width of the image in pixels. |
| height | string | The height of the image in pixels. |
| fileSize | string | The size of the image in bytes. |

## imageInfo

| Attribute | Type | Description |
| - | - |  - |
| name | string | The name of the slideshow image. |
| sizes | array of [image](page:apps-data-types#image) | The size of the images in the slideshow. |

## jsonPatch

| Attribute | Type | Description |
| - | - |  - |
| op | string | Patch operation to perform. |
| path | string | Contains the value that references the location where the operation is performed. |
| value | object | New value to apply.  |

## lineItem

| Attribute | Type | Description |
| - | - |  - |
| name | string | The name of the line item. |
| lineItemPrice | object of [price](page:apps-data-types#price) | The price of the line item (`singleItemPrice` multiplied by `quantity`). |

## lineItemContainer

| Attribute | Type | Description |
| - | - |  - |
| grandTotal | object of [price](page:apps-data-types#price) | The total price including product price, shipping and tax. |
| totalBeforeTax | object of  [price](page:apps-data-types#price) | The total price including product price, shipping excluding tax. |
| totalTax | object of [price](page:apps-data-types#price) | The total amount of the tax. |
| lineItemsSubTotal | object of [price](page:apps-data-types#price) | The sum of the line item price of all line items. |
| productLineItems | array of [productLineItem](page:apps-data-types#productlineitem) | A list of line items. |
| shippingPrice | object of [price](page:apps-data-types#price) | The shipping price of the line item. |
| couponLineItem | object of [couponLineItem](page:apps-data-types#couponlineitem) | Contains the line items of a coupon. |
| deposits | array of [depositLineItem](page:apps-data-types#depositlineitem)  | The deposits that apply for the order. |
| ecoParticipations | array of [lineItem](page:apps-data-types#lineitem) | The recycling fees included in the order.  |
| shippingOptions | array of [lineItem](page:apps-data-types#lineitem) | The costs for the specific delivery options, such as greeting cards. |
| basketDiscount | object of [lineItem](page:apps-data-types#lineitem) | The overall discount for the order. |

## link

| Attribute | Type | Description |
| - | - |  - |
| rel | string | The link relation that describes how the link relates to the call. |
| href | string | The URL of the related link that can be used for subsequent calls. |
| title | string | The title of the item that is linked. (optional)  |

## minimumCart

| Attribute | Type | Description |
| - | - |  - |
| status | boolean | Indicates if the minimum order value is exceeded. Creating an order is not possible when a cart is posted with the minimumCart status `false`. |
| code | string | Represents the selected value of the minimum order value that can be set by the merchant in the administration area of the shop. Can be one of *SumProduct*, *SumCoupon*, *SumDiscount*, *SumDelivery* or *SumPayment*. |
| amount | object of [price](page:apps-data-types#price) | The amount of the minimum value in the cart with currency and tax type. |

## newsletterCampaign

| Attribute | Type | Description |
| - | - |  - |
| campaignId | string | The unique identifier of the newsletter campaign. |
| language | string | The language of the newsletter campaign. |
| identifier | string | The alias of the newsletter campaign.  |
| name | string | The name of the newsletter campaign. |
| description | string | The description of the newsletter campaign. |
| numberOfSubscribers | string | The number of persons that subscribed for the newsletter campaign. |
| subject | string | The subject of the newsletter campaign chosen by the merchant.|

## newsletterSubscriber

| Attribute | Type | Description |
| - | - |  - |
| email | string | The email address of the subscriber. |
| name | string | The name of the subscriber. |
| subscribed | boolean | Indicates if this person is subscribed for the newsletter campaign. |

## order

| Attribute | Type | Description |
| - | - |  - |
| orderId | string | The unique identifier of the order. |
| documentType | string | The type of the order document. Can be `Invoice` or `CreditNote`. |
| documentNumber | string | The number of the order document. |
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
| taxModel | string | The tax model that applies for the order, e.g. *GROSS*.  |
| grandTotal | number | The total cost of the order.  |
| totalBeforeTax | number | The total cost of the order before tax is applied.  |
| totalTax | number | The total amount of the tax. |
| customerComment | string | Notes on the order from the customer. Can also be amended by the merchant in the administration. Mainly used for order and delivery notes.|
| internalNote | string | Internal notes for the order done by the merchant.  |
| rejectedOn | string | The date/time the order was rejected. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| inProcessOn | string | The date/time the order was put into process. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| closedOn | string | The date/time the order was closed. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| paidOn | string | The date/time the order was paid. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| returnedOn | string | The date/time the order was returned. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`  |
| shippingData | object of [shippingData](page:apps-data-types#shippingdata) | The shipping data of a cart or an order, i.e. short info on shipping method and price.|
| paymentData | object of [paymentData](page:apps-data-types#paymentdata) | The payment data of a cart or an order, i.e. short info on payment method and price.|
| lineItemContainer | [lineItemContainer](page:apps-data-types#lineitemcontainer) | Contains the line items of an order. Only included in [`GET`/orders/{orderId}](page:apps-api-get-shopid-orders-orderid-information). |
| shippingPrice | object of [price](page:apps-data-types#price) | The shipping price for the order.  |
| links | array of [link](page:apps-data-types#link) | The links to the products of the order. |

## orderDocument

| Attribute | Type | Description |
| - | - |  - |
| orderId | string | The unique identifier of the order. |
| documentType | string | The type of the order document. Can be `Invoice` or `CreditNote`. |
| documentNumber | string | The number of the order document. |
| issueDate | string | The date/time specified on the document. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z`. Note that this date/time is in UTC and has to be converted to the timezone of the issuer (merchant) to match the date on the document. |
| creationDate | string | The date/time of document creation. Expressed according to ISO 8601. Example: `2015-11-04T08:42:49.000Z` |
| address | [address](page:apps-data-types#address) | The billing address for the order.  |
| lineItemContainer | [lineItemContainer](page:apps-data-types#lineitemcontainer) | Contains the line items of an order. |
| documentPdf | string | A base64 encoded string (without new line characters) that is provided in the order checkout language. |
| links | array of [link](page:apps-data-types#link) | The links to the products of the order. |

## paymentData

| Attribute | Type | Description |
| - | - |  - |
| paymentMethod | object of [paymentMethodInfo](page:apps-data-types#paymentmethodinfo) | Information on the payment type chosen by the customer. |
| transactionId | string | The unique identifier of the payment transaction provided by the payment provider. |
| price | object of [price](page:apps-data-types#price) | The costs or the discount for the payment method. |
| status | string | Indicates the status of the payment. Can be either *CANCELED*, *FAILED* or null. |
| taxes | array of [taxInfo](page:apps-data-types#taxinfo) | Information on the taxes for the payment. |

## paymentMethodInfo

| Attribute | Type | Description |
| - | - |  - |
| id | string | The unique identifier of the payment method. |
| name | string | The name of the payment method chosen by the customer. |
| providerName | string | The name of the payment provider that executes the payment. |
| additionalData | object of [additionalData](page:apps-data-types#additionaldata) | Additional information required for the payment that can be given to e.g. determine the `invoiceIBAN`. |

## percent

This object is used for the attributes of potentialBasketDiscounts.

| Attribute | Type | Description |
| - | - |  - |
| percentage | number | The number amount of the percentage. |
| formatted | string | The number amount of the percentage with the percentage sign. |

## potentialBasketDiscounts

| Attribute | Type | Description |
| - | - |  - |
| absolute | object of [price](page:apps-data-types#price) | The potential absolute overall discount for orders in the shop. |
| minimumAmount | object of [price](page:apps-data-types#price) | The minimum basket amount of the overall discount, if customers are required to purchase at least a minimum amount to being able to receive the discount. |
| percent | object of [percent](page:apps-data-types#percent) | The potential percentage overall discount for orders in the shop. |

## price

This object is used for the attributes of basePrice, depositPrice, ecoParticipationPrice, manufacturerPrice, grandTotal, priceWithDeposits, shippingMethod, totalBeforeTax, totalTax and lineItemsSubTotal.

| Attribute | Type | Description |
| - | - |  - |
| taxType | string | Indicates if the amount includes tax. Can be *GROSS*, *NET* or *NONE*. |
| formatted | string | The amount of the price with currency unit. |
| amount | number | The amount of the price. |
| currency | string | The currency code of the price according to ISO 4217. |

## priceInfo

| Attribute | Type | Description |
| - | - |  - |
| quantity | object of [quantity](page:apps-data-types#quantity) | The quantity of the product the price refers to.|
| taxClass | object of [taxClassInfo](page:apps-data-types#taxclassinfo) | The tax that applies for the product.|
| price | object of [price](page:apps-data-types#price) | The price of the product.|
| depositPrice | object of [price](page:apps-data-types#price) | The deposit price for the product, e.g. bottle deposit.|
| ecoParticipationPrice | object of [price](page:apps-data-types#price) | The advance recycling fee for electric and electronic products which is only in some countries prescribed by law.|
| manufacturerPrice | object of [price](page:apps-data-types#price) | The sales price recommended by the manufacturer.|
| priceWithDeposits | object of [price](page:apps-data-types#price) | The price including all deposits, i.e. price, depositPrice and ecoParticipationPrice.|
| lowestPrice | object of [price](page:apps-data-types#price) | The price of the cheapest variation of a product. Only available if the `productVariationType` is *master*, and a price for at least one variation is available. |
| highestPrice | object of [price](page:apps-data-types#price) | The price of the most expensive variation of a product. Only available if the `productVariationType` is *master*, and a price for at least one variation is available. |
| basePrice | object of [basePrice](page:apps-data-types#baseprice) | The price information scaled to a standardised base unit, according to the German base price regulation "Preisangabenverordnung" (PAngV), e.g. 1 l = 1.20 EUR. Is `null` if no reference amount is specified for the product.|

## priceSavings

| Attribute | Type | Description |
| - | - |  - |
| percent  | object of [percent](page:apps-data-types#percent) | The percentage discount on the regular bulk price the customer benefits from due to the merchant's settings for customer-specific prices. |
| regularBulkPrice | object of [price](page:apps-data-types#price) | The regular bulk price for the product. |

## product

| Attribute | Type | Description |
| - | - |  - |
| productId | string | The unique identifier of the product. |
| name | string | The name of the product. |
| visible | boolean | Indicates if the product is displayed in the shop.|
| shortDescription | string | The short description of the product. |
| deliveryPeriod | string | The average time of the product being delivered to the customer. By default, the delivery period is displayed in days, but this can be changed by the merchant. |
| description | string | The description of the product. |
| title | string | The page title of the product page. |
| priceInfo | object of [priceInfo](page:apps-data-types#priceinfo) | Price information on the product. |
| bulkPriceInfo | array of [bulkPriceInfo](page:apps-data-types#bulkpriceinfo) | Information on bulk pricing for the product. |
| customerSpecificPriceInfo | array of [customerSpecificPriceInfo](page:apps-data-types#customerspecificpriceinfo) | Information on customer specific pricing for the product. |
| forSale | boolean | Information on the sale status of the product. Indicates if the product can be added to the cart. |
| specialOffer | boolean | Indicates if the product is a special offer. |
| deliveryWeight | object of [deliveryWeightQuantity](page:apps-data-types#deliveryweightquantity) | The delivery weight of the product. |
| shippingMethodsRestrictedTo | array of [link](page:apps-data-types#link) | Information on possible shipping method restrictions, e.g. express delivery only. Can be `null` if no restrictions exist. |
| availabilityText | string | Additional custom information on the product's stock level or the delivery period. |
| availability | string | The availability of the product. Can be one of *OnStock*, *WarnStock*, *OutStock*. |
| energyLabelsMaxEfficiencyString | string | The highest possible efficiency class of an uploaded energy label. |
| energyLabelsString | string | A list of energy labels applied to this product. Can be one value or a range with two values. |
| energyLabelSourceFile | string | A URL with an image or PDF file containing the energy label image supplied by the manufacturer. |
| productDataSheet | string | An image or PDF file containing a data sheet with technical information on the product. Has to be available if the product has an energy label. |
| sfUrl | string | The link to the storefront URL of the product. |
| productNumber | string | The product number. |
| isProductNumberVisible | boolean | Indicates if the product number is displayed in the storefront. |
| isNew | boolean | Indicates if the product is displayed as new in the storefront. |
| isManufacturerPriceRRP | boolean | Indicates if the manufacturer price is marked as RRP. |
| isShippingLinkVisible | boolean | Indicates if a shipping cost reference that links to the shop's payment & shipping page is displayed together with the product price in the storefront. |
| productImage | string | The name of the product image. |
| images | array of [image](page:apps-data-types#image) | The images belonging to the product. |
| manufacturer | string | The manufacturer of the product. |
| upc | string | The Universal Product Code of the product. |
| ean | string | The European Article Number of the product, either EAN-8 or EAN-13. |
| essentialFeatures | string | The essential features of the product. |
| searchKeywords | array of strings | The search terms for the product determined by the merchant in the administration.  |
| manufacturerProductNumber | string | The unique manufacturer identifier of the product. Used to identify and classify a product.  |
| productLength | number| The length of the product in mm. |
| productWidth | number | The width of the product in mm.  |
| productHeight | number | The height of the product in mm.  |
| stocklevel | number | Indicates the stock level of the product. |
| minStocklevel | number | Indicates the minimum stock level of the product. Available if the field *Minimum stock level* is used in the administration area of a shop. Only available with the `products_write` authorisation. |
| links | array of [link](page:apps-data-types#link) | The links to the product and product category. |
| productVariationType | string | The type of the variation product. Can be one of *master*, *regular* or *variation*. |
| productVariationMasterId | string | The unique identifier of the variation product. Null if the `productVariationType` is *master* or *regular*. |
| productVariationMasterName | string | The name of the variation product. Null if the `productVariationType` is *master* or *regular*. |
| productVariationSelection | array of [variationIdentifier](page:apps-data-types#variationidentifier) | The selection of the variation product. Only available if `productVariationType` is *variation*. |
| videos | array of [video](page:apps-data-types#video) | The videos belonging to the product. |
| isCustomizable | boolean | Indicates if the product is customizable in the storefront. |
| customizableTextLength | number | The maximum length of the custom text the customer can enter for a product in the storefront. |
| customizableHeadlineText | string | The headline for the customization text field in the storefront. |

## product (create request)

| Attribute | Type | Description |
| - | - |  - |
| productNumber | string | The product number (mandatory). |
| name | string | The name of the product. |
| shortDescription | string | The short description of the product. |
| description | string | The description of the product. |
| manufacturer | string | The manufacturer of the product. |
| price | number | The price of the product. |
| essentialFeatures | string | The essential features of the product. |
| upc | string | The Universal Product Code of the product. |
| ean | string | The European Article Number of the product, either EAN-8 or EAN-13. |
| deliveryPeriod | string | The average time of the product being delivered to the customer. By default, the delivery period is displayed in days, but this can be changed by the merchant. |
| searchKeywords | array of string | The search terms for the product determined by the merchant in the administration. |
| visible | boolean | Indicates if the product is displayed in the shop. |
| taxClassId | string | The unique identifier of the tax class. |
| stocklevel | number | Indicates the stock level of the product. |
| depositPrice | number | The deposit price for the product, e.g. bottle deposit.|
| manufacturerPrice | number | The sales price recommended by the manufacturer.|
| deliveryWeight | object of [deliveryWeightQuantity](page:apps-data-types#deliveryweightquantity)| The delivery weight of the product.|

## productLineItem

| Attribute | Type | Description |
| - | - |  - |
| lineItemId | string | The unique identifier of the line item. |
| sku | string | The stock keeping unit (SKU) corresponding to the line item. |
| name | string | The name of the line item. |
| productId | string | The unique identifier of the product. |
| quantity |object of [quantity](page:apps-data-types#quantity) | The quantity of the line item. |
| lineItemPrice | object of [price](page:apps-data-types#price) | The price of the line item (`singleItemPrice` multiplied by `quantity`). |
| singleItemPrice | object of  [price](page:apps-data-types#price) | The price of a single product line item. |
| lineItemCouponDiscount | object of [price](page:apps-data-types#price) | The discount of a coupon that is only applied to the specific line item. |
| images | array of [image](page:apps-data-types#image) | The image of the line item. |
| additionalInformation | object of  [additionalInformation](page:apps-data-types#additionalinformation) | Additional information about the product line item, for example, information on bulk pricing. |
| links | array of [link](page:apps-data-types#link) | The links to the product line item. |
| variationString | string | The description of the selected variation. |
| essentialFeatures | string | The essential features of the line item. |
| taxClass | object of [taxClassInfo](page:apps-data-types#taxclassinfo) | The tax that applies for the product. |
| deliveryWeight | object of [deliveryWeightQuantity](page:apps-data-types#deliveryweightquantity)| The delivery weight of the product line item. |
| energyLabelsString | string | A list of energy labels applied to this product. Can be one value or a range with two values. |
| energyLabelsMaxEfficiencyString | string | The highest possible efficiency class of an uploaded energy label. |
| energyLabelSourceFile | string | A URL with an image or PDF file containing the energy label image supplied by the manufacturer. |
| productDataSheetSourceFile | string | A URL with an image or PDF file containing a data sheet with technical information on the product. |

## productLineItem (create request)

| Attribute | Type | Description |
| - | - |  - |
| productId | string | The unique identifier of the product.|
| quantity | number | The product quantity of this line item displayed as a decimal number.|

## productLineItem (update request)

| Attribute | Type | Description |
| - | - |  - |
| quantity | number | The quantity of the product line item displayed as a decimal number.|

## productLineItemPrice (update request)

| Attribute | Type | Description |
| - | - |  - |
| singleItemPrice | number | The price of a single product line item.|

## productsPaged

| Attribute | Type | Description |
| - | - |  - |
| results | string | The number of products in total. |
| page | string | The page number on which the products appear. |
| resultsPerPage | string | The number of products returned per page. |
| items | object of [product](page:apps-data-types#product) | The list of all products. |

## productSearch

| Attribute | Type | Description |
| - | - |  - |
| productId | string | The unique identifier of the product. |
| name | string | The name of the product. |
| visible | boolean | Indicates if the product is displayed in the shop. |
| shortDescription | string | The short description of the product. |
| deliveryPeriod | string | The average time of the product being delivered to the customer. By default, the delivery period is displayed in days, but this can be changed by the merchant. |
| description | string | The description of the product. |
| title | string | The page title of the product page. |
| priceInfo | object of [priceInfo](page:apps-data-types#priceinfo) | Price information on the product. |
| forSale | boolean | Information on the sale status of the product. Indicates if the product can be added to the cart. |
| specialOffer | boolean | Indicates if the product is a special offer. |
| deliveryWeight | object of [deliveryWeightQuantity](page:apps-data-types#deliveryweightquantity) | The delivery weight of the product. |
| shippingMethodsRestrictedTo | array of [link](page:apps-data-types#link) | Information on possible shipping method restrictions, e.g. express delivery only. Can be `null` if no restrictions exist. |
| availabilityText | string | Additional custom information on the product's stock level or the delivery period. |
| availability | string | The availability of the product. Can be one of *OnStock*, *WarnStock*, *OutStock*. |
| energyLabelsMaxEfficiencyString | string | The highest possible efficiency class of an uploaded energy label. |
| energyLabelsString | string | A list of energy labels applied to this product. Can be one value or a range with two values. |
| energyLabelSourceFile | string | A URL with an image or PDF file containing the energy label image supplied by the manufacturer. |
| productDataSheet | string | An image or PDF file containing a data sheet with technical information on the product. Has to be available if the product has an energy label. |
| sfUrl | string | The link to storefront URL of the product. |
| productNumber | string | The product number. |
| isProductNumberVisible | boolean | Indicates if the product number is displayed in the storefront. |
| isManufacturerPriceRRP | boolean | Indicates if the manufacturer price is marked as RRP. |
| isShippingLinkVisible | boolean | Indicates if a shipping cost reference that links to the shop's payment & shipping page is displayed together with the product price in the storefront. | 
| isNew | boolean | Indicates if the product is displayed as new in the storefront. |
| productImage | string | The name of the product image. |
| images | array of [image](page:apps-data-types#image) | The images belonging to the product. |
| manufacturer | string | The manufacturer of the product. |
| upc | string | The Universal Product Code of the product. |
| ean | string | The European Article Number of the product, either EAN-8 or EAN-13. |
| essentialFeatures | string | The essential features of the product. |
| searchKeywords | array of strings | The search terms for the product determined by the merchant in the administration.  |
| manufacturerProductNumber | string | The unique manufacturer identifier of the product. Used to identify and classify a product.  |
| productLength | number| The length of the product in mm. |
| productWidth | number | The width of the product in mm.  |
| productHeight | number | The height of the product in mm.  |
| stocklevel | number | Indicates the stock level of the product. |
| minStocklevel | number | Indicates the minimum stock level of the product. Available if the field *Minimum stock level* is used in the administration area of a shop. Only available with the `products_write` authorisation. |
| links | array of [link](page:apps-data-types#link) | The links to the product and product category. |
| productVariationType | string | The type of the variation product. Can be one of *master*, *regular* or *variation*. |
| productVariationMasterId | string | The unique identifier of the variation product. Null if the `productVariationType` is *master* or *regular*. |
| productVariationMasterName | string | The name of the variation product. Null if the `productVariationType` is *master* or *regular*. |
| productVariationSelection | array of [variationIdentifier](page:apps-data-types#variationidentifier) | The selection of the variation product. Only available if `productVariationType` is *variation*. |
| videos | array of [video](page:apps-data-types#video) | The videos belonging to the product. |
| isCustomizable | boolean | Indicates if the product is customizable in the storefront. |
| customizableTextLength | number | The maximum length of the custom text the customer can enter for a product in the storefront. |
| customizableHeadlineText | string | The headline for the customization text field in the storefront. |
| query | string | The search query. |
| fallbackQuery | string | The fallback used if the original query did not produce any results. |
| facets | array of [facet](page:apps-data-types#facet) | The refined search filter options. |

## productSearch (create request)

| Attribute | Type | Description |
| - | - |  - |
| query | string | The search term for the search request. |
| sortBy | string | Sorts the search results by the applied search filter. Can be one of *RELEVANCE*, *NAME_ASC*, *NAME_DESC*, *ALIAS_ASC*, *ALIAS_DESC*, *POSITION*, *POSITION_ASC*, *POSITION_DESC*, *PRICE_ASC*, *PRICE_DESC*, or *CUSTOMER_RATING*. |
| attributeFilters | array of [filter](page:apps-data-types#filter) | The attributes to be filtered with the search request. |

## productSuggest

| Attribute | Type | Description |
| - | - |  - |
| name | string | The name of the product resulting from the query. |
| images | array of [image](page:apps-data-types#image) | The image of the product resulting from the query. |
| link | [link](page:apps-data-types#link) | The link to the product resulting from the query. |

## productType

ePages Now only!

| Attribute | Type | Description |
| - | :-: |  - |
| productTypeId | string | The unique identifier of the product type. |
| name | string | The name of the product type. |
| alias | string | The alias for the product type.  |
| attributes | [attributeProducttype](page:apps-data-types#attributeproducttype) | The attributes of the selected product type. |

## productType (create request)

ePages Now only!

| Attribute | Type | Description |
| - | :-: |  - |
| name | string | The name of the product type. |
| alias | string | The alias for the product type.  |
| attributes | [attributeProducttype](page:apps-data-types#attributeproducttype) | The attributes of the selected product type. |

## quantity

| Attribute | Type | Description |
| - | - |  - |
| amount | number | The amount displayed as a decimal number. |
| unit | string | The unit displayed as abbreviated unit, if available. Can be one of *Byte*, *kByte*, *MByte*, *GByte*, *TByte*, *l*, *ml*, *ft³*, *in³*, *m³*, *yd³*, *fl oz*, *gal*, *qt*, *m*, *cm*, *ft*, *in*, *km*, *mm*, *yd*, *s*, *min*, *m²*, *cm²*, *ft²*, *in²*, *mm²* or *yd²*. Otherwise a localised name of the unit is displayed. Can be *piece(s)*, *bottle(s)*, *crate(s)*, *can(s)*, *capsule(s)*, *box(es)*, *glass(es)*, *kit(s)*, *pack(s)*, *package(s)*, *pair(s)*, *roll(s)*, *set(s)*, *sheet(s)*, *ticket(s)*, *unit(s)*, *day(s)*, *hour(s)*, *week(s)*, *month(s)*, *night(s)* or *year(s)*. |

## sales

| Attribute | Type | Description |
| - | - |  - |
| currency | string | The currency code according to ISO 4217. |
| totalGrossRevenue | number | The total gross revenue received from completed orders.|
| totalNetRevenue | number | The total net revenue received from completed orders.|
| unitsSold | number | The number of sold product units (only available with active filter productId). |
| totalOrders | number | The number of orders for the defined time frame. |

## salesSummary

| Attribute | Type | Description |
| - | - |  - |
| createdAfter | string | The date/time of orders created after this timestamp. Expressed according to ISO 8601. Example: `2017-02-04T08:42:49.000Z` |
| createdBefore | string | The date/time of orders created before this timestamp. Expressed according to ISO 8601. Example: `2017-02-04T08:42:49.000Z` |
| salesPerCurrency | array of [sales](page:apps-data-types#sales)| The sales summary grouped by currency. |

## scriptTag

| Attribute | Type | Description |
| - | - |  - |
| scriptTagId | string | The unique identifier of the script tag. |
| scriptUrl | string | The URL of the script. Has to start with `https`. If the URL ends with `worker.js`, the script tag will be registered as a `ServiceWorker`. |
| scriptType | string | The type of the script. |
| createdOn | string | The date/time the script tag was created. Expressed according to ISO 8601. Example: `2017-02-04T08:42:49.000Z` |
| updatedOn | string | The date/time the script tag was last updated. Expressed according to ISO 8601. Example: `2017-03-05T10:51:31.000Z` |
| links | array of [link](page:apps-data-types#link)| The link to the script tag. |

## scriptTag (create request)

| Attribute | Type | Description |
| - | - |  - |
| scriptUrl | string | The URL of the script. Has to start with `https`. If the URL ends with `worker.js`, the script tag will be registered as a `ServiceWorker`. |

## shippingData

| Attribute | Type | Description |
| - | - |  - |
| shippingMethod | object of [shippingMethodInfo](page:apps-data-types#shippingmethodinfo) | Information on the shipping method chosen by the customer. |
| price | object of [price](page:apps-data-types#price) | The costs for the shipping. |
| taxes | array of [taxInfo](page:apps-data-types#taxinfo) | Information on the taxes for the shipping. |

## shippingMethod

| Attribute | Type | Description |
| - | - |  - |
| shippingMethodId | string | The unique identifier of the shipping method. |
| name | string | The name of the shipping method.|
| description | string | The description of the shipping method.|
| logo | string | The logo of the shipping method. |
| price | object of [price](page:apps-data-types#price) | The costs for the shipping. If the costs for the shipping can differ, for example for weight-based shipping methods, the minimum costs will be returned. |

## shippingMethodInfo

| Attribute | Type | Description |
| - | - |  - |
| id | string | The unique identifier of the shipping method. |
| name | string | The name of the shipping method. |

## shopInfo

| Attribute | Type | Description |
| - | - |  - |
| name | string | The name of the shop. |
| email | string | The email address of the merchant. |
| slogan | string | The slogan of the shop.|
| logoUrl | string | The URL to the logo of the shop.|
| sfUrl | string | The URL to the storefront of the shop. |
| mboUrl | string | The URL to the administration area of the shop. |
| isInEU | boolean | Indicates if the shop is located in the EU. |
| countryCode2 | string | The country code according to ISO 3166-1 Alpha code 2. |

## simplePriceInfo

| Attribute | Type | Description |
| - | - |  - |
| quantity | object of [quantity](page:apps-data-types#quantity) | The quantity of the product the price refers to.|
| price | object of [price](page:apps-data-types#price) | The price of the product.|

## subcategory

| Attribute | Type | Description |
| - | - |  - |
| categoryId | string | The unique identifier of the new category. |
| alias | string | The alternate name that uniquely identifies the category. If already in use, the system will automatically increment by number, e.g. alias1, alias2. |
| name | string | The name of the category. |
| pageTitle | string | The page title of this category. |
| description | string | The description of the category. |
| parent | object of [link](page:apps-data-types#link) | The link to the parent category. |
| sfUrl | string | The link to the categories in the shop's storefront. |
| links | array of [link](page:apps-data-types#link) | A list of links to the products. |

## taxClassInfo

| Attribute | Type | Description |
| - | - |  - |
| taxClassId | string | The unique identifier of the tax class. |
| name | string | The name of the tax class. |
| percentage | number | The percentage the product is taxed with.|

## taxClass

| Attribute | Type | Description |
| - | - |  - |
| taxClassId | string | The unique identifier of the tax class. |
| name | string | The name of the tax class. |
| links | array of [link](page:apps-data-types#link) | A list of links to the products. |

## taxInfo

| Attribute | Type | Description |
| - | - |  - |
| taxClass | object of [taxClassInfo](page:apps-data-types#taxclassinfo) | The information on the tax class. |
| price | object of [price](page:apps-data-types#price) | The amount of the charged tax. |

## taxModel

| Attribute | Type | Description |
| - | - |  - |
| model | string | The tax model of the shop. Can be *GROSS* (taxes included) or *NET* (taxes excluded). |
| displayTaxes | boolean | Indicates if a tax notification message for product prices has to be displayed in the shop, e.g. if the `tax model` is *GROSS* and the `displayTaxes` is *true*, a message has to be displayed in the shop that the prices include taxes. |
| noTaxesMessage | string | If `displayTaxes` is *false* this message is displayed for product prices. Used if VAT does not need to be declared as the invoicer is a small-sized business according to §19 UStG (German VAT law). |
| deliveryThresholdIsActive | boolean | Indicates if the delivery threshold is exceeded in the shop. |
| countryCode2 | string | The country code of the shop according to ISO 3166-1 Alpha code 2. |

## updatedProducts

| Attribute | Type | Description |
| - | - |  - |
| item | object of [product](page:apps-data-types#product) | The data of the product. |
| lastUpdated | string | The date/time the product was last updated. Expressed according to ISO 8601. Example: `2016-02-25T08:49:31Z`|

## valueType

| Attribute | Type | Description |
| - | - |  - |
| name | string| The name of the coupon value type. |
| waiveShippingCosts | boolean | Indicates if shipping costs are included. |

## variation

| Attribute | Type | Description |
| - | - |  - |
| link | [link](page:apps-data-types#link)| The link to the product variation. |
| attributeSelection | array of [attributeSelection](page:apps-data-types#attributeselection) | The attribute of the selected product variation. |

## variation (create request)

| Attribute | Type | Description |
| - | - |  - |
| productType | string | The unique name of the product type. |
| visibleAfterCreation | boolean | Indicates if the new product variations are displayed in the shop after creation. |
| variationAttributes | array of [variationAttribute (create request)](page:apps-data-types#variationattribute-create-request) | The attributes used for creating product variations. |

## variationAttribute

| Attribute | Type | Description |
| - | - |  - |
| name | string | The name of the variation attribute. |
| displayName | string | The displayed name of the variation attribute. |
| values | array of [variationValue](page:apps-data-types#variationvalue) | The values of the variation attribute.  |

## variationAttribute (create request)

| Attribute | Type | Description |
| - | - |  - |
| name | string | The name of the variation attribute. |
| defaultForExistingProducts | string | The default value that gets assigned to existing product variations. |
| values | array of [variationValue (create request)](page:apps-data-types#variationvalue-create-request) | The values of the variation attribute.  |

## variationIdentifier

| Attribute | Type | Description |
| - | - |  - |
| name | string | The name of the selected product variation. |
| displayName | string | The localized displayed name of the selected product variation. |
| value | string | The key of an attribute, e.g. NeonPurple.  |
| displayValue | string | The localized displayed name of the attribute, e.g. Neon Purple. |

## variationValue

| Attribute | Type | Description |
| - | - |  - |
| value | string | The key of an attribute, e.g. NeonPurple. |
| displayValue | string | The localized displayed name of the attribute, e.g. Neon Purple. |

## variationValue (create request)

| Attribute | Type | Description |
| - | - |  - |
| value | string | The assigned value of the variation attribute, e.g. neon purple. |

## video

| Attribute | Type | Description |
| - | - |  - |
| type | string | The provider of a video. |
| source | string | Specifies the video source. Depending on the provider this can be the video id or video URL. |

## watchedProduct

| Attribute | Type | Description |
| - | - |  - |
| productId | string | The unique identifier of the product. |
| name | string | The name of the product. |
| productNumber | string | The product number. |
| watchers | number | The number of watchers. |
| links | array of [link](page:apps-data-types#link) | The link to the watched product. |
