---
layout: post
title: "Setting up a Development Environment for Ruby (on Rails)"
date: "2015-10-28 13:02:00"
icon: ship
categories: tech-stories
authors: ["Declan Moran"]
---

[Ruby]: https://www.ruby-lang.org/en/
[Rails]: http://rubyonrails.org/
[ruby websiste]: https://www.ruby-lang.org/en/documentation/installation/

[Rvm]: https://rvm.io/rvm

[rbenv]: https://github.com/sstephenson/rbenv
[shims]: https://github.com/sstephenson/rbenv/#understanding-shims
[ruby-build]: https://github.com/sstephenson/ruby-build

[chruby]: https://github.com/postmodern/chruby
[ruby-install]: https://github.com/postmodern/ruby-install

There are confusingly many ways to install and setup [Ruby][Ruby] and [Rails][Rails]. And many competing tools exist that claim to make the process easier.
So how is one to choose the best tools for the job and get up and running with Ruby and/on Rails development as cleanly and painlessly as possible? The information below applies 
specificylly to setting up ruby/rails on a linux development machine, but most of it should be equally applicable to other systems like Windows and MacOsX.

# The alternatives

 **1. Use the version that comes with the OS (package manager).**

This is the quickest and easiest way to get up and running. If you're using Linux then you probably already have Ruby installed, or can easily do so via your package manager (yast, aptitude, yum etc).
However you're stuck with the version that comes with your os, which may update ruby when it sees fit. Conversely any tampering you do with the installed version could negatively impact your systems.

 **2. Download and install from source code**

This requires setting up your machine for (c) development, and is probably the most time consuming and troublesome. In partiucular Ruby likes to install itself globally by default which may interfere with other
programs or operating system components on your machine, which may break if you modify the global (os) version.

 **3. Use specialised (Ruby) Management Tools**

This is theoretically the ideal solution and one would expect a single tool (or set of tools) to be standard. However there's a surprisigly large and diverse collection to choose from.
For a detailed list see [here][ruby websiste]. Basically however the main contenders are

- [Rvm][Rvm] 

An all-in-one tool for both installing a particular version of ruby and making one of those installed **active**. It's one of the original tools and has (too) many features. Using it can be quite complicated 
and error prone. If you have no compelling reason to use it they you probably should use one of the more modern and streamlined tools available nowadays (eg chruby ..see below)

- [rbenv][rbenv] + [ruby-build]

Many ruby developers adopted rbenv in lieu of Rvm when in came out, as a means of switching the currently active ruby version. Its leaner and cleaner. The complementary plugin ruby-build can be used to instal a 
particular version of ruby. However it still has some drawbacks such as its use of [shims] and the need to call "rehash" each time a new version of ruby is installed. This is a lot better than Rvm but things could be even
simpler and cleaner. Thats where chruby comes in.

- [chruby][chruby] + [ruby-install][ruby-install]

The simplest and most lighweight ruby version manager of the bunch is chruby (weighing in at just 90 lines of code), for activating a particular ruby version. Its designed to work with ruby-install when one wants to install a new ruby version.
However I dont recommend ruby-install (or any other ruby tool for that matter) for installing ruby if you want to do rails development...read on.

# So which (combination) should I choose?

I recommend a combination of 2 and 3 above.

*Build Ruby itself from source:* You can install ruby fine with a tool like Rvm or ruby-install. However subsequently installing rails (as a gem) requires access to source files like ruby.h
If you install these via your OS (package manager) then you risk a version mismatch which may cause errors during install time (or worse..runtime). So you need these source files anyways and the best 
way to get them is to download the source for ruby.


 # create dir below first manually as user "declan" otherwise they will automatically get created belonging to root
 
{% highlight text %}

> cd ~/declan/Downloads/ruby-2.2.3

> ./configure --prefix=/home/declan/dev/web_framework/rails/ruby/2.2.3/

> make

> sudo make install

{% endhighlight %}



## Dockerising

First step towards this goal: _dockerise_ our services.
We had to provide some kind of instructions, that turns a given base image into an image that contains everything needed, to run the given service.
With regards to Docker, this is a file called `Dockerfile` that we added to all of our individual projects.
For our frontend project, it looks somewhat like the following example:

{% highlight text %}
FROM node:0.12.3

ADD . /build
WORKDIR /build

RUN npm install
RUN npm run build

CMD ["node", "index.js"]
{% endhighlight %}

The four main steps here are:

1. Start from the `node:0.12.3` base image from the [offical Docker Hub][docker-hub].
2. Add the current directory (which is the project folder containing our frontend project source code) to the container.
3. Install all of our node dependencies and then run the build script.
4. Define what it means to run this image (in our case just run `node index.js`).

Such a `Dockerfile` can be run with the `docker build .` command provided by the Docker CLI tool.
The outcome is a complete binary image, that one can deploy to any machine running Docker.
No need to worry about missing files or similar well known problems.

## Image management

One can deploy custom Docker images to the official Docker Hub for free as long as these images don't need to be private.
Since we are still in the evaluation phase we decided to run our own Docker registry for now, where we can deploy the generated binary images while keeping them private.
Whenever we push to our repositories, create a pull request or create a tag, our continuous integration system fetches the sources, start the Docker build and deploy the result to our Docker registry.
As a result, we developers can just use these fully prepared images from the registry and start them on our own machines.

## Orchestration

The last step is to compose the individual service containers together.
In our example, we start a container running MySQL.
This container receives a custom IP address which we have to pass into the container running our Java backend service. Also the frontend service needs to be configured to be able to find the Java backend service.

The [Docker Compose][docker-compose] tool allows to specify how to orchestrate different services into a complete running system.
For that purpose we have another source code repository that basically just contains a single `docker-compose.yml` file that looks somewhat like this:

{% highlight yaml %}
frontend:
  image: docker.company.com/project/frontend:0.5.4
  links:
    - "backend:backend"
  ports:
    - "8080"

backend:
  image: docker.company.com/project/backend:0.9.8
  links:
    - "mysql:mysql"

mysql:
  image: mysql:5.6
  environment:
    MYSQL_DATABASE: project
{% endhighlight %}

The file defines our three services, the frontend, the backend and the database.
The Docker image to be used is defined for every service as well as the links, i.e. the frontend needs the backend and the backend needs the database.
The frontend's container port `8080` gets exposed.

That's it.
A developer just needs this single YAML file and then has to run `docker-compose up`.
Docker will take care of downloading the images if needed, starting the containers and linking them together.
The developer gets to see the live standard output of all three services mixed into a single stream.

## Conclusion

It is quite a long way to get an existing system into Docker containers.
But the way is well worth it.
We did not just solve the problem that arised from having a central staging machine, but we also found a few bugs, that were unnoticed due to the fact, that all the addresses were fixed before.
Using Docker, the services receive new IP addresses on every (re)start.
So we were pretty much forced to really think about what network services we expose and what network services we need to consume in order to make the system run.

[docker]: https://www.docker.com/
[docker-hub]: https://hub.docker.com/
[docker-compose]: https://docs.docker.com/compose/
[lxc]: https://linuxcontainers.org/lxc/introduction/
[nodejs]: https://nodejs.org/
[java]: https://java.com/
[mysql]: https://www.mysql.com/
