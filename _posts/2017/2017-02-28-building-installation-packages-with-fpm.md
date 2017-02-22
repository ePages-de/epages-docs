---
layout: post
title: "Building installation packages with FPM"
date: "2017-02-09 07:00:00"
image: blog-header/code-fpm.jpg
categories: tech-stories
authors: ["Maik", "Wolf"]
---

## Building installation packages with FPM

As one of the leading eCommerce companies ePages distributes its software for Linux based systems as .rpm and .deb packages.
Building these packages is most of the time not easy and you will have to modify an existing package to your own needs.
You have to be familiar with the Linux distribution you are working on and also with the packaging system (eg. rpm and/or deb) you are using.
As part of optimizing the release process for ePages packages we researched other ways on how to build these packages more easily.
We ended up using [FPM](https://github.com/jordansissel/fpm/wiki) for our new packaging process.

## What is FPM

FPM (Effing Package Management) was built by [Jordan Sissel](https://twitter.com/jordansissel?lang=de).
The goal of FPM is to make it easy and quick to build packages such as rpms, debs etc.
You can not only build new packages with FPM you can also edit existing packages (e.g. removing files or changing metadata and dependencies).
You can build deb, rpm and solaris etc. packages from any of the following sources:

* directory (of compiled source of some application)
* gem
* python eggs
* rpm
* node npm packages

## How to use FPM

You can easily install on your system using rubygems.

```
gem install fpm
```

After installation you can start working with FPM.
This is how you can package your own application as a rpm package.

1. Create a folder and file you want to be inside the rpm package:

    ```
    mkdir -p /build/myapp/0.0.1/
    
    touch /build/myapp/0.0.1/test_fpm.txt
    ```
2. Create rpm package using FPM:

    ```
    fpm -s dir -t rpm -n myapp -v 0.0.1 -C /build/myapp/
    ```

    A package called “myapp_0.0.1_amd64.rpm” were created.

3. Now you can install this package using:

    ```
    rpm –install myapp_0.0.1_amd64.rpm
    ```

4. Check if the file  /0.0.1/test_fpm.txt exists:

    ```
    ls /0.0.1
    ```

If your package has some dependencies you can define them by using –d (repeat it as many times as you need it)

```
fpm -s dir -t deb -n myapp -v 0.0.1 -C /build/myapp/
-d "libstdc++6" \
-d "libevent-1.4-2"
```

There are many more options and types of package you can build with FPM.
For more information please visit the github projects [page](https:/github.com/jordansissel/fpm/wiki).

### Why ePages uses FPM

ePages decided to use FPM because it is the best way to create different types of packages on one system.
In the past the creation of the rpm and deb packages was very painful.
For each package we needed an own installation to create the package.
So you have to deal with different types of OS and packaging systems.
We also had to maintain several scripts and configuration files for each system.
Now with FPM we only need on installation and can build our packages with only one script.
This makes the creation for new packages much easier and also the packaging process is now more understandable for developer and new colleagues.
