---
layout: page
title: Create a theme
category: themes
---

## 1. Copy the `default` theme located in:

{% highlight text %}
public/src/themes/
{% endhighlight %}

## 2. Add a stylesheet:

There are two ways to add styles to your theme.

### Option 1

Create a file named `style.less` written in [Less][1] and put it into the `stylesheets` folder of your theme:

{% highlight text %}
my-new-theme/
  stylesheets/
    style.less
{% endhighlight %}

### Option 2

Open your theme's `theme.json` and add all your stylesheet `.css` files like this:

{% highlight json %}
{
  "stylesheets": [
    "stylesheets/theme.css",
    "//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
  ]
}
{% endhighlight %}

## 3. Set shop to use your new theme:

To make the AlaCarte shop use your new theme open `shops/AlaCarte.json`. Change the `theme` attribute to your theme's folder name:

{% highlight json %}
{
  "theme": "my-new-theme"
}
{% endhighlight %}

## 4. Restart the epages-ui server

If your server is running already, just type `rs` on the commando line. Second option: just restart the whole project with entering `grunt`.

[1]: http://lesscss.org/ "Less CSS"
