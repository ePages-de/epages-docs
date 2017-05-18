---
layout: page
hide_searchbar: true
hide_sitemap: true
key: _examples
title: Style examples
searchable: false
permalink: /examples/
---

Headlines


# Headline layer 1

## Headline layer 2

### Headline layer 3

#### Headline layer 4


Text


Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


Formatting


**bold**

*italics*

Enumerations (bulleted list)


* Item 1
* Item 2
* Item 3
    * Item 3a
    * Item 3b
    * Item 3c


Enumerations (consecutive numbering)


1. Item 1
2. Item 2
3. Item 3
    1. Item 3a
    2. Item 3b
    3. Item 3c


Links


[A link to an external page](http://jekyllrb.com/)

[A link to an internal page](page:apps-create)

[A link to a headline of an internal page](page:apps-create#get-your-credentials)

[A link to an internal api resource](page:apps-api-get-shopid-products-information)


Table


| This is       | a table       |
|---------------|---------------|
| Value 1a      | Value 1b      |
| Value 2a      | Value 3b      |
| Value 3a      | Value 3b      |


Images


{% imagecaption landingpage-banner.jpg %}
This is an image with at most 100% width
{% endimagecaption %}

{% imagecaption search.png %}
This is an image with at most 100% width
{% endimagecaption %}

{% imagecaption landingpage-banner.jpg 50% %}
This is an image with an enforced width of 50%
{% endimagecaption %}

{% imagecaption search.png 50% %}
This is an image with an enforced width of 50%
{% endimagecaption %}

{% imagecaption search.png 50% left %}
This is an image with an enforced width of 50% floating on the left
{% endimagecaption %}

{% imagecaption search.png 20% right %}
This is an image with an enforced width of 20% floating on the right
{% endimagecaption %}

<p style="clear: both">Highlights</p>


{% highlight json %}
{
  "message": "Bad Request",
  "status": 400
}
{% endhighlight %}

{% highlight scala %}
// some syntax highlighted Scala code
package com.mycompany
object Application extends App {
  println("Hello World!")
}
{% endhighlight %}

{% highlight ruby %}
# some syntax highlighted Ruby code
module MyModule
  class MyClass
    def initialize(name)
      @name = name
    end
  end
end
{% endhighlight %}


Callouts


{% callout danger This is a red callout %}
Here you can place some markdown text...
{% endcallout %}

{% callout warning This is a yellow callout %}
Here you can place some markdown text...
{% endcallout %}

{% callout success This is a green callout %}
Here you can place some markdown text...
{% endcallout %}

{% callout info This is a blue callout %}
Here you can place some markdown text...
{% endcallout %}

Emojis

[Emoji library](http://www.iemoji.com/emoji-cheat-sheet/all)

{% emoji wink %}

{% emoji smile %}

{% emoji slight_smile %}

{% emoji smirk %}
