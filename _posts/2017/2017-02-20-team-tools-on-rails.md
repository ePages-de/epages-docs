---
layout: post
title: "Team Tools on Rails"
date: "2017-02-20 07:00:00"
image: blog-header/hamburg-port-rails.jpg
categories: tech-stories
authors: ["Unai M."]
---

One of the languages that we use the most on the ePages Tools Team is [Ruby](https://www.ruby-lang.org). We love the syntax, the simplicity and the big and active community around it. Some time ago, [we wrote about our SDK](https://developer.epages.com/blog/2016/02/02/on-the-way-to-a-ruby-sdk.html) for the ePages shops and lots of things have changed since then. We've kept developing it to support more operations, like data pagination and also to keep on with the releases of our colleagues from the [API development team](https://developer.epages.com/apps).

## Status of the sdk

We are preparing a release Soon&#8482; containing lots of model changes, in order to make the use of [the gem](https://github.com/ePages-de/epages-rest-ruby) even easier. For example, to get the customers of our shop, we used to have to do

{% highlight ruby %}
  epages_shop.customers
  [<Epages::Customer:0x0000>, <Epages::Customer:0x0001>, ..., <Epages::Customer:0x0041>]
{% endhighlight %}

and then, iterate the array with all the customers. But now, you can use other parameters that the API provides as `page` or `results_per_page`. So you can do things like

{% highlight ruby %}
  epages_shop.customers
  <Epages::CustomersResponse:0x0000
    @items = [<Epages::Customer:0x0000>, <Epages::Customer:0x0001>, ..., <Epages::Customer:0x0009>],
    @page = 1,
    @results = 42,
    @results_per_page = 10>
{% endhighlight %}

or with some parameters

{% highlight ruby %}
  epages_shop.customers({ page: 2, results_per_page: 10 })
  <Epages::CustomersResponse:0x0000
    @items = [<Epages::Customer:0x0010>, <Epages::Customer:0x0011>, ..., <Epages::Customer:0x0019>],
    @page = 2,
    @results = 42,
    @results_per_page = 10>
{% endhighlight %}

so you have more control on the call and it gets easier to do batch operations. We also fixed some bugs and updated some dependencies.

Testing things in the console was fun, but we needed a real life scenario to check that the gem was working correctly and to find missing features. Lucky for us, we had a task perfect for this situation, `"Create an Statistics App for the ePages Appstore"`.

## The new app in Rails

One of the things that I like the most about working at ePages is that we have lots of colleagues willing to help us. We had mockups, designs and texts for the whole webapp, so we've been focused on programing.

For simplicity we mimicked more or less the API models and added a bit of Rails Magic so it's even easier to use.

{% image blog/blog-sales-app-model.png auto center %}

After that we created all the sections of the App: Dashboard, Sales, Products and Customers. All these parts are bounded to two dates (The start date and end date) so the merchant can get even more useful data faster.

The main purpose of Dashboard was to have all the basic information about your shop in a glance, so we decided to include a graph of sales, the amount of sales and orders, as well as the top products and last orders.

Then we included three charts on the Sales section, the first is the same as in the Dashboard, the second one represents the orders on the selected time frame and the last is the revenue per order, the calculation between the first two graphs. We also added the option to export the data to an `xlsx` file so the Merchant doesn't need and internet connection to review the sales.

The Customers section is a simple table including all the merchant customers ordered via number of orders or the total amount spent. Above the table we can see all the customers for the timeframe and if we had any returning ones.

The last part are the Products. In this view, we have the products ordered via revenue or amount of units sold. Here we implemented the functionality of having more insights on the product. When clicking on one, you can see the extra data or cross selling products, this is, what other items have shared orders with. This allows the Merchant maybe realize on connections (or disconnections) between products in an easy and fast way.

Both Customers and Products sections have the option to download the data on a `csv`. Other basic functionalities like changing you email address or password and 'Forgot my password' are also included in the App.

{% imagebasic blog/blog-sales-app-dashboard.png %} image {% endimagebasic %}

## Some decisions we made

In every project you have to make some decisions on what tech you use. We decided to use [Rails](http://rubyonrails.org/) in part because we love it, but also to use our [own developed library](https://github.com/ePages-de/epages-rest-ruby). On the charts side there are lots of options to choose, but we went with [D3](https://d3js.org/), an open source, very powerful and very customizable option. The main reason of this pick was purely educational. I love learning new stuff, libraries, languages, paradigms, you name it; and I already used [Highcharts](http://www.highcharts.com/), [Google charts](https://developers.google.com/chart/) and [Chart.js](http://www.chartjs.org/), plus I was really curious about it and my team let me decide {% emoji smiley %}.

[Devise](https://github.com/plataformatec/devise) was our option for user management. This gem is easy and simple, so it was perfect to deliver fast (even though in the end everything became more complicated). For this simplicity reason we choose [Slim](http://slim-lang.com/), [Sass](http://sass-lang.com/) and [CoffeeScript](http://coffeescript.org/).

## Issues on the development process

As I wrote earlier, D3 is a really powerful engine to do all sorts of graphs but by no means simple. This and the fact that we (backend, frontend and design) had separated tasks for the graphs created issues whenever we needed to change anything. The nice thing is that we work really close together and we are used to help each other, so in the end has turned out to be a really enriching experience for the whole team.

The data the we use to display on the graphs and tables through the App, comes obviously from each Merchants shop. Currently the API has a rate limit of 6000 calls per hour and though at the very beginning this seemed more than enough, it turned out to be a issue for with we had to find a solution.

Even from the start, it was clear for us that we had to persist the data in our own database; not only because of having limits on retrieving data but also we wanted to give the Merchant extra value. For this, we needed to do some heavy calculations with data, so we couldn't rely external systems.

Our first approach was to add all the products, customers and orders to our database. For this we were using [sidekiq](http://sidekiq.org/) to send to the background the syncing tasks. Sidekiq is fast and really customizable, but even with all the flexibility on the world, if the data isn't there, it can't be used.

At the time of writing this, it seems obvious that stores aren't made of two demo customers and three orders with one product each. But when we where starting the project, that was our test data and this answer to the synchronization problem seemed to be, at least, a not bad one. Turns out, it wasn't.

When we got some real data and we were left with a white graph for the first couple of hours (remember the hourly rate limit) it became clear that our answer wasn't the solution. So we turned to the pragmatical solutions, only getting the data we needed.

The bad thing about getting the data at the moment is that you have to persist it and do the calculations **and** also show something on the screen. So, with this mentality still on mind, we decided to fetch the orders first. This way we only retrieve the customers and products we need, if needed. We save database space, API calls and we show the data in a chronological order, so the merchant can at least, even in the worst scenarios, see the latest data.

So for now, the app checks every hour if there are any new orders to download the latest data or just schedule itself to check for that the next hour. We also decided that we were only going to get data not older that two years, so we don't get overloaded with old data and because the main use case for the app is to be able to check and get reports and analysis closer in time data, so it's more relevant.

Our last issue was with encryption. Rails by default encrypts passwords and we were already encrypting the access_token, but we got the request to encrypt the email addresses also. The problem with this is that the library we were using to user management, the easy and simple Devise, didn't support that. Changing to username for the log in process was the first thing it came into our minds.

This is probably the easiest solution but also, one that changed how the app worked. Now the merchants needed to think about a username and the, remember it. Our goal was to make the App the most accessible as possible and adding extra fields to remember was not the way to do it.

The other answer that came to my mind was *just* to adapt the log in system to use encrypted emails. At that moment we didn't fully realize what was the scope of that task we were creating, the easy and simple Devise was about to become a pain all over the App in ways that we couldn't even dream of figuring it out.

I started creating two methods for auto-encrypt and auto-decrypt any database field via Ruby Magic (AKA Metaprogramming). This way we could add encryption easily where needed. But then Devise said **no**. As it makes sense on an email field, the library turns that field into lowercase and as we where encrypting the email field and overwriting it, it turned `randomEncryptedStringForEmail` into `randomencryptedstringforemail`, which is not the same when decrypting it.

After some hours of not understanding anything, I realized the lowercase issue and opted to create another field on the database for the merchant to store the encrypted value, so Devise couldn't lowercase it. With that, we had to change it everywhere, backend code and UI code, but to be honest, with `find and replace` happened to be an easy task.

It wasn't until later when we saw the beast we created. The email field was used for **everything** (Both in Devise and in our App) that had to do with the User. Not only to update the email, update the password or restore password, but all over the core. As this kind of platforms usually have the User model in the middle, because you need to display all the data regarding to one specific user, we basically rewrote the all or at least most of the sessions and password code. That affected also to other parts of the Devise library as `reset_tokens` or `last_update` dates, which required even more core rewriting.

## Hosting the App

Now that we have dealt with all the issues on the app, comes the hosting debate. Our team has experience on both [Heroku](https://www.heroku.com) and [AWS](https://aws.amazon.com) deployment so those are the main contenders.

Following the philosophy on fast delivery, we started with Heroku, which allows us to deploy on one console command and to add some useful plugins like [Papertrail](https://papertrailapp.com) to store and search the logfiles or [New Relic](https://newrelic.com/) to check the application performance, something really critical to decide the host.

If we end up with lots of traffic and big RAM usage, we may change to AWS so we can have a machine more suited to our needs. The downside of this scenario is that we will have to set up everything by ourselves, the machine, the deployment process and so on. Lucky for us, we have [Capistrano](http://capistranorb.com/), a tool written on Ruby (but available for other languages also) for remote server automation and deployment.

[Docker](https://www.docker.com) is another option for us on the deployment side of the things to do when not choosing Heroku. We also have experience on it and in the case we needed support, our colleagues on ePages are [experienced](https://developer.epages.com/blog/2016/07/05/containerdays-hamburg.html) on both [Docker](https://developer.epages.com/blog/2016/11/28/xp-days-germany-2016.html) and [Kubernetes](https://developer.epages.com/blog/2016/08/09/how-to-setup-a-ha-kubernetes-cluster-etcd-cluster-with-ssl.html), so we know that we are more than covered on those subjects.

Only time will tell which option is going to work for us and maybe another [blog](https://developer.epages.com/blog/) post will come on that, but for now, Team Tools will be focusing on other projects.

Thanks for reading.
