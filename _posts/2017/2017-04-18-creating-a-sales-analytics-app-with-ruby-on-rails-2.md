---
layout: post
title: "Creating a Sales Analytics App: issue solving"
date: "2017-04-18 07:00:00"
image: blog-header/rails-train-path-straight.jpg
categories: tech-stories
authors: ["Unai M."]
---

Last month, I wrote a post about [how and why we started with our Sales Analytics app](https://developer.epages.com/blog/2017/03/02/creating-a-sales-analytics-app-with-ruby-on-rails.html).
In this post, I'd like to talk about some issues we encountered on our way and how we solved them.

## About our - slightly - bumpy development road

### The issue with the graphs...

As mentioned in my previous post, [D3](https://d3js.org/) is a really powerful engine to do all sorts of graphs but is by no means simple.
This and the fact that we (backend, frontend, and design) had separated tasks for the graphs, created issues whenever we needed to change anything.
The nice thing is that we work really close together and we are used to help each other, so in the end it turned out to be a really enriching experience for the whole team.

### ...and API call limits

The data the we use to display on the graphs and tables through the app obviously come from merchant shops.
Currently, the [ePages REST API](https://developer.epages.com/apps) has a rate limit of 6000 calls per hour and although at the very beginning this seemed more than enough, it turned out to be an issue we had to find a solution for.

Even from the start, it was clear for us that we had to persist the data in our own database; not only because of having limits on retrieving data but also we wanted to give the merchant extra value.
For this, we needed to do some heavy calculations with data, so we couldn't rely on external systems.

Our first approach was to add all the products, customers and orders to our database.
For this, we were using [sidekiq](http://sidekiq.org/) to send the syncing tasks to the background.
Sidekiq is fast and really customizable, but even with all the flexibility on the world, if the data isn't there, it can't be used.

At the time of writing this, it seems obvious that shops aren't made of two demo customers and three orders with one product each.
But when we where starting the project, this was our test data and this answer to the synchronization challenge seemed to be, at least, not a bad one.
But it turned out, it wasn't.

When we got some real data and we were left with a white graph for the first couple of hours (remember the hourly rate limit) it became clear that our answer wasn't the solution.
So we went for the pragmatical solution to only get the date we really needed.

The bad thing about getting the data at the moment is that you have to persist it and do the calculations **and** also show something on the screen.
So, with this mentality still on mind, we decided to fetch the orders first.
This way, we only retrieve the customers and products we need, if required.
We save database space, API calls and we show the data in a chronological order, so the merchant can at least, even in the worst scenarios, see the latest data.

So for now, the app checks every hour if there are any new orders to download the latest data or just schedules to check for that the next hour.
As the main use case for the app is to being able to check and get reports and analysis closer in time, we decided to not get data older than two years.

### Encryption?!

Another of our challenges was related to encryption.
By default, [Rails](http://rubyonrails.org/) encrypts passwords and we were already encrypting the `access_token`. But we got the request to also encrypt the email addresses.
The challenge with this was, that the simple and easy user management library [`Devise`](https://github.com/plataformatec/devise) that we were using doesn't support that.
Changing to username for the log in process was the first thing it came into our minds.

This is probably the easiest solution but also, one that changed how the app worked.
Now the merchants needed to think about a username and then, remember it.
Our goal was to make the app the most accessible as possible and adding fields to remember login data was not the way to do it.

Something else that came to our minds was to *just* adapt the login system to use encrypted emails.
At that moment we didn't fully realize what was the scope of that task we were creating. The easy and simple Devise was about to become a pain all over the app in ways that we couldn't even dream of figuring it out.

I started creating two methods to auto-encrypt and auto-decrypt any database field via Ruby Magic (AKA Metaprogramming).
Doing so, we were able to add encryption easily where required.
But then Devise said **no**.
As it makes sense on an email field, the library turns that field into lowercase and as we where encrypting the email field and overwriting it, it turned `randomEncryptedStringForEmail` into `randomencryptedstringforemail`, which is not the same when decrypting it.

After some hours of not understanding anything, I realized the lowercase issue and opted to create another field on the database for the merchant to store the encrypted value, so Devise couldn't lowercase it.
With that, we had to change it everywhere, backend code and UI code, but to be honest, with `find and replace` this happened to be an easy task.

It wasn't until later when we saw the beast we created.
The email field was used for **everything** (both in Devise and in the app) that had to do with the user.
We not only had to update the email or password and restore it, but change it all over the core.
As this kind of platforms usually have the user model in the middle, because all data for one specific user have to be displayed, we basically rewrote all or at least most of the sessions and password code.
That affected also to other parts of the Devise library, such as `reset_tokens` or `last_update` dates, which required even more core rewriting.

## Hosting the app

Now that we have dealt with all the issues on the app, here comes the hosting debate.
Our team has experience on both [Heroku](https://www.heroku.com) and [AWS](https://aws.amazon.com) deployment so those are the main contenders.

Following the philosophy on fast delivery, we started with Heroku, which allows us to deploy on one console command and to add some useful plugins like [Papertrail](https://papertrailapp.com) to store and search the logfiles or [New Relic](https://newrelic.com/) to check the application performance. So this was something really critical to decide on the host.

If we end up with lots of traffic and big RAM usage, we may change to AWS so we can have a machine more suited to our needs.
The downside of this scenario is that we will have to set up everything by ourselves, the machine, the deployment process and so on.
Lucky for us, we have [Capistrano](http://capistranorb.com/), a tool written on Ruby (but available for other languages also) for remote server automation and deployment.

[Docker](https://www.docker.com) is another option for us on the deployment side of the things to do when not choosing Heroku.
We also have experience on it and in the case we needed support, our colleagues at ePages are experienced on [Docker](https://developer.epages.com/blog/2016/07/05/containerdays-hamburg.html) and [Kubernetes](https://developer.epages.com/blog/2016/08/09/how-to-setup-a-ha-kubernetes-cluster-etcd-cluster-with-ssl.html). So we know, that we are more than covered on those subjects.

Only time will tell which option is going to work for us and maybe another [blog](https://developer.epages.com/blog/) post will come on that.

Thanks for reading.
