---
layout: page
key: themes-create
title: How to create & switch themes for now
---

# 1. Copy the `default` theme located in:

{% highlight text %}
source/themes/epages/default
{% endhighlight %}

# 2. Add a stylesheet:

There are two ways to add styles to your theme.

## Option 1

Create a file named `style.less` written in [Less][1] and put it into the `stylesheets` folder of your theme:

{% highlight text %}
my-new-theme/
  stylesheets/
    style.less
{% endhighlight %}

This file will automatically be used in your theme without having to do anything.

## Option 2

Open your theme's `theme.json` and add a `stylesheets` key which holds an array of all your `.css` files like this:

{% highlight json %}
{
  "stylesheets": [
    "stylesheets/theme.css",
    "//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
  ]
}
{% endhighlight %}

# 3. Use available template variables
You have access to several template variables to read out ecommerce specific shop data like its name and products that it's selling. The variables depend on the template you're adding so not every variable is available everywhere. The followin listing gives you an idea where you can use what: 

## within all templates

* `shop`:
    * `shopName`: Name of the shop
    * `slogan`: Slogan of the shop
    * `_self`: reference to the shop URL
    * `categories`: Array of all categories the shop has to offer

## exclusive in `index.dust`

* `startpage`
    * `products`: Products assigned to the shop's start page
        * `name`: Name of the product
        * `href`: Link to the product detail page
        * `price`: Formatted product price
        * `image`
            * `src`: Image of the product
            * `alt`: Alternative text


## exclusive in `category.dust`

* `category`:
    * `name`: Name of the category
    * `products`: Array of available products
        * `name`: Name of the product
        * `href`: Link to the product detail page
        * `price`: Formatted product price
        * `image`
            * `src`: Image of the product
            * `alt`: Alternative text
    * `subCategories`: Sub categories belonging to this category
        * `name`: Name of the sub category
        * `href`: Link to the sub categories page

## exclusively in `product.dust`

* `product`
    * `name`: Name of the product
    * `image`
        * `src`: Image of the product
        * `alt`: Alternative text 
    * `price`: Formatted product price
    * `shortDescription`: The product's short description

# 4. Define regions to be editable by the merchant (optional)

If you'd like to reserve space the merchant can use to add custom page elements you can define it like the following

{% highlight text %}
{@region name="upper-startpage-region"/}
{% endhighlight %}

This helper may be embedded in any html element that can host content. You can skip this if want your theme to exactly look like you intended it to be.

# 5. Set shop to use your new theme:

To make the AlaCarte shop use your new theme open:

{% highlight text %}
controllers/<page_type>/index.js
{% endhighlight %}


Insert the folowing line after `data.brix.pageType = 'index';`:

{% highlight text %}
data.brix.theme = '<your_theme_name>'
{% endhighlight %}

This overwrites all stored data and tells the ui-layer to use your theme for this page type.

# 6. Restart the epages-ui server

If your server is running already, just type `rs` on the command line. Second option: just restart the whole project with entering `grunt`.

[1]: http://lesscss.org/ "Less CSS"
