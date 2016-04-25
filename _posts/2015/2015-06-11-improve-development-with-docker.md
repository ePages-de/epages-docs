---
layout: post
title: "Improving the development workflow with Docker"
date: "2015-06-11 10:51:25"
image: blog-header/container.jpg
categories: tech-stories
authors: ["Christian"]
---

At the moment [Docker][docker] is one of the hottest topics for devops as well as for developers.
In a nutshell, one can describe Docker as [Linux containers][lxc] with some extra convenience.
Docker can be classified somewhere in between fully fledged virtual machines and a simple file system virtualisation with chroot.
Since it is not yet clear, if Docker will find it's way into our production deployment, this post only concentrates on how our development workflow benefits from Docker.

## The challenge

A simplified version of our current project is the following: We are developing a [NodeJS][nodejs]-based application that uses a [Java][java]-based backend for storing data which itself uses a [MySQL][mysql] database.
Pretty standard stuff.
So far we deployed the backend service via continuous deployment to a central staging machine and this address was hard coded into our frontend project.
It worked, but could still be improved: Backend changes that were not backwards compatible unnecessarily blocked our frontend developers and forced them, to adapt to these changes before continuing other work.

## The solution

To improve this, we decided to use Docker to make starting everything on our local machine easier.

### Dockerising

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

### Image management

One can deploy custom Docker images to the official Docker Hub for free as long as these images don't need to be private.
Since we are still in the evaluation phase we decided to run our own Docker registry for now, where we can deploy the generated binary images while keeping them private.
Whenever we push to our repositories, create a pull request or create a tag, our continuous integration system fetches the sources, start the Docker build and deploy the result to our Docker registry.
As a result, we developers can just use these fully prepared images from the registry and start them on our own machines.

### Orchestration

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

### Conclusion

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
