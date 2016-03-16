---
layout: page
key: apps-ruby-gem
title: Ruby SDK
---

You love to create awesome Ruby apps?
You want to create understandable and easy code?
To support you with that, we have developed the Ruby SDK.
It speeds up your development and saves valuable time that you could use to create even MORE awesome apps.

## Installation

The Ruby SDK allows to communicate with an ePages shop from the CLI or any Ruby framework.
All you need to do is get yourself a Ruby installation and run this command:

{% highlight text %}
sudo gem install epages-rest
{% endhighlight %}

To use the gem inside the Ruby interpreter you need to require it with:

{% highlight ruby %}
require 'epages-rest'
{% endhighlight %}

To integrate the gem with a Ruby framework, add it to the gemfile:

{% highlight ruby %}
gem 'epages-rest'
{% endhighlight %}

## Usage

Create a shop endpoint:
{% highlight ruby %}
shop = Epages::REST::Shop.new(shop_host, shop_name, auth_token)
{% endhighlight %}

Just use it.
{% highlight ruby %}
products = shop.products
sort_products = shop.products(sort: "name", results_per_page: 5)
{% endhighlight %}

## Examples

Check our [GitHub repository](https://github.com/ePages-de/epages-rest-ruby/tree/master/examples) for all available examples.
