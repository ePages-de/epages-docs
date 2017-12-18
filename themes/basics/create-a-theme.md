---
layout: docs
key: themes-create
title: Create or switch a theme
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

This file will then be automatically used in your theme.

## Option 2

Open your theme's `theme.json` and add a `stylesheets` key, which includes an array of all your `.css` files like this:

{% highlight json %}
{
  "stylesheets": [
    "stylesheets/theme.css",
    "//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
  ]
}
{% endhighlight %}

# 3. Use available template variables
You have access to several template variables to access ecommerce specific shop data like e.g. name or products. The variables depend on the template you're adding, i.e. not every variable is available everywhere. The following list gives an idea of where to use what:

## All templates

* `shop`:
    * `shopName`: Name of the shop
    * `slogan`: Slogan of the shop
    * `_self`: reference to the shop URL
    * `categories`: Array of all shop categories

## Exclusively in `index.dust`

* `startpage`
    * `products`: Products assigned to the shop's start page
        * `name`: Name of the product
        * `href`: Link to the product detail page
        * `price`: Formatted product price
        * `image`
            * `src`: Image of the product
            * `alt`: Alternative text


## Exclusively in `category.dust`

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
        * `name`: Name of the subcategory
        * `href`: Link to the subcategory page

## Exclusively in `product.dust`

* `product`
    * `name`: Name of the product
    * `image`
        * `src`: Image of the product
        * `alt`: Alternative text
    * `price`: Formatted product price
    * `shortDescription`: The product's short description

# 4. Define regions to be editable by the merchant (optional)

If you'd like to provide extra space, the merchant can use to add custom page element, proceed as follows:

{% highlight text %}
{@region name="upper-startpage-region"/}
{% endhighlight %}

This helper may be embedded in any html element that can host content. You can skip this step, if you want your theme to be changed.

# 5. Set shop to use your new theme:

To make the AlaCarte shop use your new theme open:

{% highlight text %}
controllers/<page_type>/index.js
{% endhighlight %}


Insert the folowing line after `data.brix.pageType = 'index';`:

{% highlight text %}
data.brix.theme = '<your_theme_name>'
{% endhighlight %}

This overwrites all stored data and makes the ui-layer use your theme for this page type.

# 6. Restart the epages-ui server

If your server is running already, just type `rs` in the command line or restart the complete project with entering `grunt`.

[1]: http://lesscss.org/ "Less CSS"
