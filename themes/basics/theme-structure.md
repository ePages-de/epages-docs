---
layout: docs
key: themes-structure
title: Theme structure
---

The `default` theme should be used as basis for your own theme and contains all required files.

To get an impression on how a theme is structured, please read the below sections. For creating or switching a theme, read further [here](page:themes-create).

# File structure and naming conventions

{% highlight text %}
my-new-theme/
    readme.md
    theme.json
    stylesheets/
        *.css
        *.less
    images/
    templates/
        layout.dust
        index.dust
        product.dust
        category.dust
{% endhighlight %}

# Template files

1. `layout.dust` Contains the main layout of each page and works as a frame for all other templates.
2. `index.dust` Contains all content of the start page.
3. `product.dust` Represents the product page.
4. `category.dust` The Template for all a (categorized) display of products.

# Stylesheets

Every theme has to provide its own stylesheet, which can be written in plain CSS or [Less][2]. All stylesheet files have to be placed within their own folder named `stylesheets`.

# Template tags

All templates are written in [Dust.js][1].

# Best practices and recommended resources

* [Dust.js tutorial][1]
* [Less CSS pre-processor][2]

[1]: https://github.com/linkedin/dustjs/wiki/Dust-Tutorial "Dust Tutorial"
[2]: http://lesscss.org/ "Less CSS"
