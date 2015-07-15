---
layout: post
title: "creating systems with pipelining"
date: "2015-09-xx"
icon: wrench
tags: pipelines, virtual mashines, development systems
categories: Application Management
authors: ["Carsten", "Karsten"]
---

Today I will introduce some special topic to our readers, called [pipelining](https://en.wikipedia.org/wiki/Pipeline_(software)). When we at ePages speak about pipelining, we understand it as an automatic workflow, integrating many steps using different tools to reach a specific goal. The goal we had was to create a simple way to provide a highly specialized system. This system can be for development, external or even live.
The setup used here is a combination of different software and tools. One of them is [vmware](http://www.vmware.com/) with [vCenter](https://www.vmware.com/products/vcenter-server) and some [ESXi](https://www.vmware.com/products/vsphere/features/esxi-hypervisor) servers to offer and manage systems in a virtual environment. 
Another tool we use is called [i-doit](http://www.i-doit.org/) and is used for creation and documentation of inventories and network related information.
As you may read in a previous [post](https://developer.epages.com/blog/2015/06/25/infrastructure-as-code.html) we often use [Jenkins](https://jenkins-ci.org/) for [Continuous Integration](http://www.martinfowler.com/articles/continuousIntegration.html), so it's one of our favourite tools to automate processes. 
The key of an automated OS install is the combination of [iPXE](http://ipxe.org/) and kickstart isos, for example preseeds for [Debian](https://wiki.debian.org/DebianInstaller/Preseed) or [Centos/RHEL](http://www.centos.org/docs/4/html/rhel-sag-en-4/s1-kickstart2-file.html).
Last but not least when it comes to system specialization [Linux](https://www.linux.com/) itself should be mentioned :P.
To speak with the different interfaces, programming languages like [`Perl`](https://www.perl.org/) and [`Python`](https://www.python.org/) or scripting languages like [`PHP`](https://secure.php.net/) and [`bash`](http://www.gnu.org/software/bash/) are used. 

{% image blog-pipeline-tools.png %} {% endimage %}

# The pipeline

The basic idea is simple. First off we need a system. 

## The system

This is fairly simple, due to the [vSphere Cloud Plugin](https://wiki.jenkins-ci.org/display/JENKINS/vSphere+Cloud+Plugin) for Jenkins, it is easy to construct a job building a basic virtual machine from a template. 
These templates are predefined with a set of CPU,RAM and Disc space and an OS specific mounted iPXE kickstart iso file. If it's needed, you can create and run an additional job changing the values of the machine before the install starts.
A bit more challenging is to manage the network environment. In the simplest case a development system should be created, so the system needs an IP with internet access and an R/DNS entry. 
Here we killed two birds with one stone. By using i-doit we provide at first the information about the new system to our documentation system via REST API and in the second step calculate the next free ip in our network. 
Now we have the system documented and we have all information we need to create a [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol) and [DNS](https://en.wikipedia.org/wiki/Domain_Name_System) entry. Using the API of i-doit the DHCP and DNS configuration files were generated, tested and deployed to our DHCP and DNS Servers.

## Installation process

Now we can start the virtual machine with our kickstart script installing the predefined OS. The kickstart script uses iPXE boot and loads the configuration and installs the system.
The open source boot firmware iPXE allows us to boot an iso file over the network and allows dynamic or static IP configuration depending on your network. For example for networks without DHCP you can hard code a static ip for an installation and change the network configuration after the initial install is done. The loaded ISO files are preseeds for the specified os that include all information the install process needs to install the OS.
At the moment Centos 6/7 and Debian 7/8 are supported from our side. After the installation, we have a first simple not very specialized system that could now be used. Now some magic Jenkins jobs do the trick and specialize the system.

## Specialization 

From here on you can let your creativity run free. Here are many jobs available from [security related configurations](https://www.linode.com/docs/security/securing-your-server) over installing of different software to installing our full ePages to a system with a specific version or project specific configurations. 
In our situation it depends on the use case. For example internal development systems have other security related configurations then external systems, or
test and live systems can have project specific configurations depending on what our custermers need.

## Big Picture

Here is a simplified picture of the whole pipeline. The full process lasts about 10 to 15 minutes but depends on the specific configuration you choose.

{% image blog-pipeline-Jenkins.png %} {% endimage %}

In the Future we want to use the existing build pipeline's to create distributed systems with our and other software.

