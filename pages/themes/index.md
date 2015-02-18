---
layout: page
key: themes
title: Themes in a nutshell
---

The `default` theme should work as a base for your own theme and contains all required files.

# File structure & naming conventions

{% highlight text %}
my-new-theme/
  readme.md
  theme.json
  regions.json

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
4. `category.dust` The Template for all category pages.

# Stylesheets

Every theme has to provide its own stylesheet, wich can be written in plain CSS or [Less][less]. All stylesheet files have to be placed within their own folder named `stylesheets`.

# Template tags

All templates are written in [Dust.js][dust].

# Best practices & recommended resources

* [Dust.js tutorial][dust]
* [Less CSS pre-processor][less]

[dust]: https://github.com/linkedin/dustjs/wiki/Dust-Tutorial "Dust Tutorial"
[less]: http://lesscss.org/ "Less CSS"
