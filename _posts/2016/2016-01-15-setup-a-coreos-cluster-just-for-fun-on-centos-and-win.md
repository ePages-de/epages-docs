---
layout: post
title: "Setting up a CoreOS Cluster just for fun on CentOS and Windows"
date: "2015-12-12 17:17:17"
icon: diamond
categories: tech-stories
authors: ["Andreas Grohmann"]
---

If you want to play around with [CoreOS][UsingCoreOS] then this article may help you to get started.
In this article we set up a 3 Cluster CoreOS installation using vagrant and virtual box on Windows and CentOS.
On windows there are some more things to observe.

# Windows

## Prerequisits

### 1. Power Shell 3.0
First you have to install the Windows Management Framework 3.0 including the Windows PowerShell 3.0.
The standard shell will have some troubles with pathes.
- Download the latest version, e.g. from this link https://www.microsoft.com/en-us/download/details.aspx?id=34595

###  2. install cygwin
To get the rsync feature you need to install cygwin on your windows installation.
- You can download it from here https://cygwin.com/install.html

> *Make sure you activate "rsync" and "SSH" in the installation*

- add "C:\cygwin64\bin" to your windows system variable "PATH"

### 3. Virtual Box
Virtual Box is needed, download latest version from here https://www.virtualbox.org/wiki/Downloads .

### 4. vagrant
You also need to install vagrant, get the latest version from here https://www.vagrantup.com/downloads.html .

## Lets get started
### 1. clone the coreos-vagrant git repo

> *Make sure you use the GitBash for this.*

```
$ git clone https://github.com/coreos/coreos-vagrant.git
$ cd coreos-vagrant
```

### 2. start a cluster
We need to generate a unique token where etcd can find information about the nodes of the etcd cluster.
- get dicovery token from https://discovery.etcd.io/new
- edit file `user-data` replace "https://discovery.etcd.io/NEW_TOKEN" with the url you get above
```
etcd2: 
discovery: https://discovery.etcd.io/NEW_TOKEN
```

- after replacing the link it should looks like this
```
etcd2: 
discovery: https://discovery.etcd.io/0850c01e29cb6d7dcd5d4e9123311704
```

### 3. start clusters
now change to your powershell 3 and execute following commands
```
$ cd .\git-projects-github\coreos-vagrant
$ vagrant up
```
If everything works fine you should see three virtualbox windows and your shell should look like this:

{% image 2016_01_coreos_winsetup__01.jpg %}{% endimage %}

### 4. stop clusters
to stop the clusters execute following commands in your powershell 3
```
$ cd .\git-projects-github\coreos-vagrant
$ vagrant halt
```

### 5. increase cluster count
to stop the clusters execute following commands in your powershell 3
```
$ cd .\git-projects-github\coreos-vagrant
$ vagrant halt
```

### 6. remove clusters
to completely remove the clusters execute following commands in your powershell 3
```
$ cd .\git-projects-github\coreos-vagrant
$ vagrant destroy
```
<!-- Links -->
[UsingCoreOS]: https://coreos.com/using-coreos/
[CoreOSTutorial]: https://coreos.com/os/docs/latest/booting-on-vagrant.html
[CoreOSVagrantRepo]: https://github.com/coreos/coreos-vagrant
