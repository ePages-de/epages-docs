---
layout: post
title: "On the way to a Ruby SDK"
date: "2016-02-02 07:17:17"
image: /blog-header/ruby.png
categories: tech-stories
authors: ["Domingo"]
---

As a member of the ePages Tools team, I take care of the development and maintenance of internal tools.
One of my tasks is to develop an app for the ePages App & Theme Store for online merchants that was launched in December 2015.

Main targets for this app:

* create an app template for future projects
* foresee common problems that can appear during the process to build other helpers or tools that can improve the quality and readability of the code and the experience of development.

For this purpose, I decided to go for a [Ruby on Rails](http://rubyonrails.org/) application as it offers a fast development and a very understandable code.

## Communicating with the API

When I first started to communicate with the [ePages Rest API](https://developer.epages.com/), I realised that every single call required a lot of code, even when using http libraries, due to the different parameters and types of responses of each API call.
This is why I decided to extract this part to another side project and integrate it with the app later.

## Ruby SDK

The [Ruby SDK](page:apps-ruby-gem) project began as a single integration to ease the required code to build the custom calls from the API.
But based on the [ePages API documentation](https://developer.epages.com/apps/index.html), I decided to extend this tool to parse the responses to different classes with a common meaning such as products, categories or orders.
By the way, the responses that the SDK returns are more intuitive than the plain response because of the collection of methods the classes implement.
Another aspect to highlight is the syntax of the calls; very focused on the code's simplicity.

So the little side project has grown and now it is the official Ruby SDK for the ePages API.
The [GitHub repository is open-source](https://github.com/ePages-de/epages-rest-ruby) so anyone can use it to integrate ePages with any platform.

In order to use it in a Rails application, only add it to the Gemfile.

{% highlight ruby %}
gem 'epages-rest'
{% endhighlight %}

I am already working on the features for the next version.
It will include the [Sales call](https://developer.epages.com/apps/api-reference/get-shops-shopid-sales.html) and a new feature to implement concurrent calls, ideal for faster data collection.
