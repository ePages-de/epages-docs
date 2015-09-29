---
layout: page
key: soap-directory
title: Web service directory
---

The below tables list the latest versions of the available web services.
Unless specified otherwise, the web services are shop web services.
The **Availability** column indicates the first release or patch version of ePages in which the web service originally became available.
Read further [here](page:soap-api) to access the SOAP web services.

| Web service   |  URN |   Availability           |
|---------------|---------------|-------------------------|
| **AssignmentService** | urn://epages.de/WebService/AssignmentService/2005/01 | 5.04&nbsp;or&nbsp;higher |

* `assignProductToCatalog`: Assign products to categories.
* `getCatalogsAssignedToProduct`: Get the catalogue a product is assigned to.
* `getProductsAssignedToCatalog`: Get products assigned to a category.
* `isProductAssignedToCatalog`: Check if product is assigned to a category.
* `removeProductFromCatalog`: Remove a product from a category.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **BasketService** | urn://epages.de/WebService/BasketService/2013/11 | 6.17.0&nbsp;or&nbsp;higher |

* `addProductLineItem`: Add products to baskets.
* `create`: Create new basket.
* `delete`: Delete a list of shopping baskets.
* `deleteLineItem`: Delete a line item from the shopping basket
* `exists`: Check if a list of shopping baskets exists.
* `getInfo`: Get info on a list of shopping baskets.
* `update`: Update list of shopping baskets.
* `updateLineItem`: Update line items of shopping baskets.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
**CatalogService8** | urn://epages.de/WebService/CatalogService/2011/11 | 6.13.1&nbsp;or&nbsp;higher |

* `create`: Create new catalogues.
* `delete`: Delete list of categories.
* `exists`: Check if list of categories exists.
* `getCategories`: Get all recursive category paths as simple flat list.
* `getInfo`: Get information on a list of categories.
* `getRoot`: Get root category.
* `sortProducts`: Sort products in each category of a list of categories.
* `update`: Update a list of categories.
* `uploadImage`: Upload category related images.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **ChangeLogService** | urn://epages.de/WebService/ChangeLogService/2014/06 |   6.17.5&nbsp;or&nbsp;higher |

* `findCreatedObjects`: Find newly created objects.
* `findDeletedObjects`: Find deleted objects.
* `findUpdatedObjects`: Find updated objects.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **CrossSellingService2** | urn://epages.de/WebService/CrossSellingService/2007/01 | 5.04.11&nbsp;or&nbsp;higher|

* `create`: Insert a cross selling.
* `delete`: Delete cross selling.
* `exists`: Check if cross selling exists.
* `getInfo`: Get a cross selling.
* `update`: Update a cross selling.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **CustomerGroupService2** | urn://epages.de/WebService/CustomerGroupService/2011/03 | 6.11.3&nbsp;or&nbsp;higher |

* `create`: Create list of customer groups.
* `delete`: Delete list customer groups.
* `exists`: Check if list of groups exists.
* `getList`: Get list of customer groups.
* `update`: Update a list of customer groups.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **CustomerService5** | urn://epages.de/WebService/CustomerService/2013/01 | 6.15.4&nbsp;or&nbsp;higher |

* `create`: Create new customer.
* `delete`: Delete list of customers.
* `exists`: Check if list of customers exists.
* `find`: Find customers.
* `getInfo`: Get information on the list of customers.
* `update`: Update list of customers.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **FeaturePackService** | urn://epages.de/WebService/FeaturePackService/2005/03 | 6.16.3&nbsp;or&nbsp;higher |

*This is a provider web service.*

* `addShopType`: Add shop types to list of shop types the feature pack is available for.
* `applyToAllShop`: Update feature values and apply changes to all shops the feature is applied for.
* `applyToShop`: Apply feature pack to a shop.
* `create`: Create new feature packs.
* `delete`: Delete list of feature packs.
* `exists`: Check if a list of feature packs exists.
* `getInfo`: Get information on a list of feature packs.
* `removeFromShop`: Remove feature pack from shop.
* `removeShopType`: Remove shop types from the list of shop types the feature pack is available for.
* `update`: Update a list of feature packs.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **OrderDocumentService7** | urn://epages.de/WebService/OrderDocumentService/2011/08 | 6.11.1&nbsp;or&nbsp;higher |

* `create`: Create new order documents.
* `delete`: Delete a list of order documents.
* `exists`: Check if a list of order documents exists.
* `getCreditNotes`: Get credit notes of an order.
* `getInfo`: Get information on a list of order documents.
* `getInvoices`: Get invoices of an order.
* `getPackingSlips`: Get packing slips of an order.
* `update`: Update order documents.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **OrderService12** | urn://epages.de/WebService/OrderService/2013/04 | 6.16.0&nbsp;or&nbsp;higher |

* `create`: Create new orders.
* `delete`: Delete a list of orders.
* `exists`: Check if a list of orders exists.
* `find`: Find orders.
* `getInfo`: Get information on a list of orders.
* `update`: Update a list of orders.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **PageCacheService** | urn://epages.de/WebService/PageCacheService/2006/07 | 6.08&nbsp;or&nbsp;higher |

* `clear`: Delete all cached pages of a shop.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **PaymentMethodService** | urn://epages.de/WebService/PaymentMethodService/2008/03 | 5.04.11&nbsp;or&nbsp;higher |

* `getList`: Get the list of payment methods.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **PriceListAssignmentService** | urn://epages.de/WebService/PriceListAssignmentService/2005/01 | 5.02&nbsp;or&nbsp;higher |

* `getQuantityDiscounts`: Get information on a product's quantity discounts.
* `getScalePrices`: Get information on a product's scale prices.
* `getValueDiscounts`: Get information about a product's value discounts.
* `setQuantityDiscounts`: Update product's quantity discounts.
* `setScalePrices`: Update product's scale prices.
* `setValueDiscounts`: Update product's value discounts.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **PriceListService2** | urn://epages.de/WebService/PriceListService/2010/08 | 5.10.2&nbsp;or&nbsp;higher |

* `create`: Create new price lists.
* `delete`: Delete a list of price lists.
* `exists`: Check if a list of price lists exist.
* `getInfo`: Get information on a list of price lists.
* `update`: Update a list of price lists.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **ProductBundleService** | urn://epages.de/WebService/ProductBundleService/2007/07 | 6.10.2&nbsp;or&nbsp;higher |

* `create`: Assign a product to a product bundle.
* `delete`: Remove a product from a product bundle.
* `exists`: Check if a product is assigned to a product bundle.
* `getInfo`: Get bundled products assigned to a product bundle.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **ProductService12** | urn://epages.de/WebService/ProductService/2014/04 | 6.15.2&nbsp;or&nbsp;higher |

* `create`: Create new products.
* `delete`: Delete a list of products.
* `exists`: Check if a list of products exist.
* `find`: Find products.
* `getInfo`: Get information on a list of products.
* `update`: Update a list of products.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **ProductTypeService** | urn://epages.de/WebService/ProductTypeService/2007/11 | 5.04.18&nbsp;or&nbsp;higher |

* `create`: Create new product types.
* `createPreDefAttribute`: Create a list of predefined attributes.
* `createProductAttribute`: Create a list of product attributes.
* `delete`: Delete a list of product types.
* `deletePreDefAttribute`: Delete a list of predefined attributes.
* `deleteProductAttribute`: Delete a list of product attributes.
* `exists`: Check if a list of product types exist.
* `existsPreDefAttribute`: Check if a list of predefined attributes exist.
* `existsProductAttribute`: Check if a list of product attributes exist.
* `getAllInfo`: Get information on all product types.
* `getAllPreDefAttributesInfo`: Get information on all predefined attributes of a product attribute.
* `getAllProductAttributesInfo`: Get information on all product attributes of a product type.
* `getBaseProductType`: Get the base product type.
* `getInfo`: Get information on a list of product types.
* `getPreDefAttributeInfo`: Get information on a list of predefined attributes.
* `getProductAttributeInfo`: Get information on a list of product attributes.
* `update`: Update a list of product types.
* `updatePreDefAttribute`: Update a list of predefined attributes.
* `updateProductAttribute`: Update a list of product attributes.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **ShippingMethodService2** | urn://epages.de/WebService/ShippingMethodService/2012/07 | 6.14.1&nbsp;or&nbsp;higher |

* `getList`: Get the list of shipping methods.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **ShopConfigService8** | urn://epages.de/WebService/ShopConfigService/2015/07 | 6.17.29&nbsp;or&nbsp;higher |

*This is a provider web service.*

* `create`: Creates a new shop with a given shop type and imports default data.
* `delete`: Deletes a shop from the store database.
* `deleteShopRef`: Deletes a shop reference from the site database.
* `exists`: Returns true if the shop alias exists for the provider.
* `getAllInfo`: Returns information on all existing shops from the site database.
* `getInfo`: Returns information on an existing shop from the site database.
* `setSecondaryDomains`: Set secondary domain names for a shop.
* `update`: Updates an existing shop in the site and store database.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **ShopCountService** | urn://epages.de/WebService/ShopCountService/2006/08 | 6.16.3&nbsp;or&nbsp;higher |

*This is a provider web service.*

* `getAllCounts`: Returns the number of shops of a provider from all databases. Deleted shops and internal test shops are not included.
* `getCount`: Returns the number of shops of a provider, filtered by shop type, database and flags.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **ShopTransferService** | urn://epages.de/WebService/ShopTransferService/2012/09 | 6.14.3&nbsp;or&nbsp;higher |

*This is a provider web service.*

* `getStatus`: Get information on a running web service session.
* `startExport`: Start shop export.
* `startImport`: Start shop import.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **SimpleProvisioningService4** | urn://epages.de/WebService/SimpleProvisioningService/2015/07 | 6.17.29&nbsp;or&nbsp;higher |

*This is a provider web service.*

* `create`: Creates a new shop with a given shop type and imports default data.
* `exists`: Returns true if the shop alias exists for the provider.
* `getInfo`: Returns information on an existing shop from the site database.
* `markForDeletion`: Marks a shop for deletion.
* `rename`: Change the alias of an existing shop.
* `update`: Updates an existing shop in the site and store database.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **TaxAreaService** | urn://epages.de/WebService/TaxAreaService/2006/07 | 5.04&nbsp;or&nbsp;higher |

* `getList`: Get the list of tax areas.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **TaxClassService** | urn://epages.de/WebService/TaxClassService/2006/07 | 5.04&nbsp;or&nbsp;higher |

* `getList`: Get the list of tax classes.

| Web service   |  URN  |  Availability           |
|---------------|---------------|-------------------------|
| **UserService6** | urn://epages.de/WebService/UserService/2011/11 | 6.11.3&nbsp;or&nbsp;higher |

* `create`: Create new users.
* `delete`: Delete a list of users.
* `exists`: Check if a list of users exist.
* `find`: Find customers.
* `getInfo`: Get information on a list of users.
* `sendPassword`: Send a user a link to enter a new password.
* `update`: Update a list of users.
