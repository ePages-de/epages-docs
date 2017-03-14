---
layout: post
title: "One development environment to rule them all"
date: "2017-03-14 07:00:00"
image: blog-header/ring.jpg
categories: tech-stories
authors: ["Jordi"]
---

A usual problem developers are facing, is to work with a common development environment.
At the same time, this environment has to be the same as the production environment.
ePages software is working into servers with [centOS](https://www.centos.org/) or [debian](https://www.debian.org/) which makes it mandatory for the developers to write the code in this environment.
For sure, it is pointless to force all developers to have one of those OS installed, taking into account that the preferred OS are [macOS, ubuntu or windows](https://developer.epages.com/blog/2016/12/22/the-battle-of-the-operating-systems.html).

This scenario calls for finding a solution.
There are several ways to solve this, and I'll try to explain the different options that we have and which one has mainly been chosen by our development team in Barcelona.

## Convert your laptop into a VM container

One of the easiest ways to find a solution - and also the most popular one - is to use a VM like [VMware](http://www.vmware.com/) or [virtual box](https://www.virtualbox.org/) and add the maximum resources of you laptop to it.
Then, this VM becomes the main OS of your laptop and all the tools (IDE, scripts, ...) are hosted inside.
It means, that in fact the laptop is hosting two operative systems but mainly only one is used.

## Containerize the development environment

In order to do a step forward regarding the before mentioned proposal and try to not waste resources, the best option is to have the basic environment containerized.
This means that everybody can get this container and work with the same environment.

The container only needs the basic stuff.
Doing so, we can use the tools hosted in our main OS and avoid the waist of resources since it is only the development environment running the code.

But the challenge is: We need to find a way on how the hosted tools on the laptop can interact with the container.
Luckily, almost all container solutions can do so. Therefore, we only have to connect our IDE or text editor to the container and share the code.

## Use Docker containers

The most efficient way is to use a Docker container.
Docker already has commands to [share directories with the container](https://docs.docker.com/engine/tutorials/dockervolumes) and several plugins to connect your favorite IDE with the container.

* [Intellij Plugin](https://plugins.jetbrains.com/idea/plugin/7724-docker-integration)
* [Eclipse Plugin](https://www.eclipse.org/community/eclipse_newsletter/2016/july/article2.php)
* [NetBeans Plugin](http://wiki.netbeans.org/Docker)

The only challenge is that Docker uses the kernel version of your laptop OS.
Only if the kernel is compatible with the software you are developing you can run it in Docker.
Unfortunately, this is not the case for us.
So in our particular case we had to find another solution.

## Use Vagrant boxes

When you cannot containerize your solution because of the kernel version issue, we have to find solutions to create a completely new OS without using resources of you host OS.
At this point, we might think of going with the first solution with a virtual machine, but as mentioned above, it is a waste of resources.
So the question remains: How can we have a virtual machine with no unnecessary elements and manage it comfortably?

The answer is: [Vagrant](https://www.vagrantup.com).
Vagrant provides a way to create and manage virtual machine images with simple commands.
In addition, there are several plugins for the most popular IDE's to use this tool in a visual way.

* [Intellij Plugin](https://plugins.jetbrains.com/idea/plugin/7379-vagrant)
* [Eclipse Plugin](https://marketplace.eclipse.org/content/vagrant)
* [NetBeans Plugin](http://plugins.netbeans.org/plugin/50630/vagrant)

The power of this tool is that you only need to create a virtual box without any kind of GUI.
Only a basic installation is needed to be able to connect via ssh.
When you work with Vagrant, you can ignore the vm working in the background.

Also, several vagrant boxes are available with pre-configured vm's.
Anyway, if you need to configure any specific box for your needs you can do it.
In a nutshell, you only have to create a virtual machine, provide specific users, and a private key to allow Vagrant to connect. That's it!.

This is the solution that best fits into our team. I hope that this experience also helps other teams!