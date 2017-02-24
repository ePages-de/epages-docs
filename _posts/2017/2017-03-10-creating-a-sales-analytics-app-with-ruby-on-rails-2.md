---
layout: post
title: "Team Tools on Rails 2"
date: "2017-03-10 07:00:00"
image: blog-header/hamburg-port-rails.jpg
categories: tech-stories
authors: ["Unai M."]
---

A couple of days ago we started writing about how and why we started our Sales analytics app. Today we want to talk about some issues we encountered in our way and how we solved them.

## Issues on the development process

As I wrote in our previous post, D3 is a really powerful engine to do all sorts of graphs but by no means simple. This and the fact that we (backend, frontend and design) had separated tasks for the graphs created issues whenever we needed to change anything. The nice thing is that we work really close together and we are used to help each other, so in the end has turned out to be a really enriching experience for the whole team.

The data the we use to display on the graphs and tables through the App, comes obviously from each Merchants shop. Currently the API has a rate limit of 6000 calls per hour and though at the very beginning this seemed more than enough, it turned out to be a issue for with we had to find a solution.

Even from the start, it was clear for us that we had to persist the data in our own database; not only because of having limits on retrieving data but also we wanted to give the Merchant extra value. For this, we needed to do some heavy calculations with data, so we couldn't rely external systems.

Our first approach was to add all the products, customers and orders to our database. For this we were using [sidekiq](http://sidekiq.org/) to send to the background the syncing tasks. Sidekiq is fast and really customizable, but even with all the flexibility on the world, if the data isn't there, it can't be used.

At the time of writing this, it seems obvious that stores aren't made of two demo customers and three orders with one product each. But when we where starting the project, that was our test data and this answer to the synchronization problem seemed to be, at least, not a bad one. Turns out, it wasn't.

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
