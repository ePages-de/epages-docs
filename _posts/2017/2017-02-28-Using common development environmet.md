---
layout: post
title: "One environment to rule them all"
date: "2017-02-22 07:00:00"
image: blog-header/ring.jpg
categories: tech-stories
authors: ["Jordi Viladoms"]
---

One of the most popular problems that developers have to face is to work with a common development environment. At the same time, this environment has to be the same that the production one. ePages software is working into servers with centOS or debian and it makes mandatory for the developers to write the code under this environment. For sure make no sense to force all the developers to have one of those OS installed at the laptop taking into account that the most preferred OS are [macOS, ubuntu or windows](https://developer.epages.com/blog/2016/12/22/the-battle-of-the-operating-systems.html).

This scenario force us to find a solution. There are several ways to fix this problem and I'll try to explain the different options that we have and which one has been mainly chosen by Team Ocean Barcelona.

## Convert your laptop into a VM container

One of the easiest way to do it and still the most used for some developers is to use a VM like vmware or virtual box and add there the maximum resources of your laptop. Then this VM becomes the main OS of your laptop and all the tools (IDE, scripts, ...) are hosted inside. It means that in fact the laptop is hosting two operatives systems but mainly only one is used.

## Containerize the development environment

In order to do a step forward regarding the last proposal and try to don't waist resources the best option is to have the basic environment containerized. It means that everybody can get this container and work with the same environment. 

This container has to have only the basic stuff needed. In this way, we can use the tools hosted in our main OS and avoid the waist of resources since the development environment is only running the code.

This proposal presents one big problem. We have to find the way about how our tools hosted in the laptop OS can interact with the container. Fortunately almost all containers solutions have a way to do it so we only have to connect our IDE or text editor to the container and share the code with it.

## Use Docker container

The most efficient way to do it is using a Docker container. Docker already has commands to [share directories with the container](https://docs.docker.com/engine/tutorials/dockervolumes) and several plugins to connect your favorite IDE with the container. 

* [Intellij Plugin](https://plugins.jetbrains.com/idea/plugin/7724-docker-integration)
* [Eclipse Plugin](https://www.eclipse.org/community/eclipse_newsletter/2016/july/article2.php)
* [NetBeans Plugin](http://wiki.netbeans.org/Docker)

The problem of this solution is that docker is using the kernel version of your laptop OS. If the kernel is compatible with the software you are developing then you can run it into docker. Unfortunately this is not the case of ePages 6 version. So for our particular case we had to find another solution.

## Use Vagrant boxes

When you cannot containerize your solution for the kernel version problem,  we have to find solutions to create a completely new OS without using resources of you host OS. At this point, we could think to go for the first solution with a virtual machine but, as I mention above, it is a waist of resources. So, how we can have a virtual machine with any unnecessary elements and manage it comfortably?

The answer is [Vagrant](https://www.vagrantup.com). Vagrant provides a way to create and manage virtual machine images with simple commands. In addition, there are several plugins for the most popular IDE's to use this tool in a visual way.

* [Intellij Plugin](https://plugins.jetbrains.com/idea/plugin/7379-vagrant)
* [Eclipse Plugin](https://marketplace.eclipse.org/content/vagrant)
* [NetBeans Plugin](http://plugins.netbeans.org/plugin/50630/vagrant)


The power of this tool is that you only need to create a virtual box without any kind of GUI. Only a basic installation is needed to be able to connect via ssh. When you work with vagrant you can forget that behind it there is a vm working.

Also several vagrant boxes are available with pre-configured vm's. Anyway, if you need to configure any specific box for your needs you can  do it. In a nutshell, you only have to create you virtual machine. Provide specific users and private keys to allow vagrant to connect and that's it!.

This is the solution that best fit into our team. I hope that this experience also helps other teams!




