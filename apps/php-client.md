---
layout: page
key: apps-php-client
title: PHP SDK
---

Would you like to create PHP apps easily?
You'd like to use a nice framework that makes the full REST communication on its own?
To support you with that, we made the first steps towards a basic PHP framework.

## Installation

* Check for the latest [release](https://github.com/ePages-de/epages-rest-php).
* Download the latest version of the available **.phar** file and copy it to a folder within your PHP project, e.g. /libraries.
* To use the client you need to require it with:

{% highlight php %}
require_once(PathToPharFile)
{% endhighlight %}

* Then set the variables for `$HOST`, `$SHOP`, `$AUTHTOKEN` and `$ISSSL`.

## Usage

Create a shop endpoint:

{% highlight php %}
$shop = new ep6\Shop($HOST, $SHOP, $AUTHTOKEN, $ISSSL);
{% endhighlight %}

Just use it.

{% highlight php %}
$productFilter = new ep6\ProductFilter();
$productFilter->setLocale("de_DE");
$productFilter->setCurrency("EUR");
$productFilter->setSort("name");
$productFilter->setResultsPerPage(100);
$products = $productFilter->getProducts();
{% endhighlight %}

## Examples

Check our [GitHub repository](https://github.com/ePages-de/epages-rest-php/tree/master/examples) for all examples currently available.
