---
layout: docs
key: tutorial-build-simple-webservice-client
title: How to build a simple web service client
---

# 1. How to integrate web services in your own project

Go to the [epages-soapclient repository](https://bintray.com/epages/maven/epages-soapclient/) and integrate it with your build automation tool or manually.

## 1.1 Integration with build automation tool

Include bintray to your maven repository resolution.
For gradle this might look like this:

{% highlight bash %}
repositories { maven { url 'http://jcenter.bintray.com' } }
{% endhighlight %}

Add the dependencies for the epages-soapclient for provider and shop services.
With the next call of your build task the dependencies will be automatically downloaded from bintray and integrated into your project.

{% highlight bash %}
dependencies {
    compile 'de.epages:soapclient-shop:${soapShopVersion}'
    compile ‘de.epages:soapclient-provider:${soapProviderVersion}’
{% endhighlight %}

## 1.2 Integration into an Integrated Development Environment (IDE)

Run your specified task to get the dependencies into your favourite IDE (e.g.: [eclipse](https://eclipse.org/downloads/)).

{% highlight bash %}
./gradlew eclipse
{% endhighlight %}

You can also download the jars from the bintray repository and add it manually.
Open your IDE (here: eclipse) and right-click on your project >> properties >> Java Build Path >>
Libraries.
Add the dependencies with **Add External JARs** to your java build path.

## 1.3 Import the classes into your project

Import the packages and use the services for your project.

{% highlight java %}
import de.epages.ws.pagecache.PageCacheServiceClientImpl;
import de.epages.ws.product{version}.ProductServiceClient;
{% endhighlight %}

# 2. The actual usage

## 2.1 The Authentication

Create an implementation of the interface WebServiceConfiguration with methods for your web service URL, your username and password.
Give this object to the web service client implementation you want to use or create your own one with the provided interfaces.

{% highlight java %}
PageCacheServiceClientImpl pageCacheService = new PageCacheServiceClientImpl (soapShopConfig);
{% endhighlight %}

## 2.2 Example: The PageCacheService

Use the PageCacheService to delete all cached pages of the shop.

{% highlight java %}
pageCacheServiceClient.clear();
{% endhighlight %}

## 2.3 Example: The ProductService

## 2.3.1 Product existence

Check if one or more products exists.
Create an array with strings of aliases you want to check.

{% highlight java %}
String[] productAliases = new String[1];
productAliases[0] = “fancyAlias”;
{% endhighlight %}

It’s always possible to check more than one value with one SOAP call.
Create the instance of the service and perform the actual call:

{% highlight java %}
ProductServiceClientImpl productService = new ProductServiceClientImpl(soapShopConfig);
TExists_Return[] existsReturn productService.exists(productAliases);
{% endhighlight %}

This kind of service will return an array with information, e.g. call was successful or failed, product exists or not, etc.

## 2.3.2 Product data

Get the data of one or more product(s) with the same array as before.

{% highlight java %}
ProductServiceClientImpl productService = new ProductServiceClientImpl(soapShopConfig);
TGetInfo_Return[] getInfoReturn = productService.getInfo(productAliases);
TExists_Return[] existsReturn productService.exists(productAliases);
{% endhighlight %}

It will return an array of objects form the type `TGetInfo_Return`.
You could reach the data of the product with the setter and getter methods of this object.

{% highlight java %}
getInfoReturn[0].getManufacturer();
{% endhighlight %}

## 2.3.3 Product creation

Create one or more products.
First create an object of the type `TCreate_Input` with your new data.
The values for TaxClass and alias are required and the TaxClass should exist already.

{% highlight java %}
TCreate_Input createInput = new TCreate_Input();
craeteInput.setAlias("fancyAlias");
createInput.setTaxClass("/TaxMatrixGermany/normal");
{% endhighlight %}

Create the array for the actual call.

{% highlight java %}
Tcreate_Input[] createInputs = new TCreate_input[1];
createInput[0] = createInput;
{% endhighlight %}

After that you could call the service to create the product.

{% highlight java %}
TCreate_Return[] createReturn = productService.create(createInputs);
{% endhighlight %}

{% callout info Pro tip: %}
See also the unit/integration tests of the project for more practical examples.
{% endcallout %}
