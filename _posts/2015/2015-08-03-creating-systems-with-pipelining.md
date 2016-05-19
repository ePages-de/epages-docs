---
layout: post
title: "Creating systems with pipelining"
date: "2015-08-03"
image: blog-header/pipelines.jpg
categories: tech-stories
authors: ["Carsten", "Karsten"]
---

If we talk about [pipelining](https://en.wikipedia.org/wiki/Pipeline_(software)) at ePages, we understand it as an automatic workflow.
We are integrating many steps using different tools to reach a specific goal: creating a simple way to provide a highly specialised system.

This system can be used for development purposes, external or even live deployment.
The setup used here is a combination of different software and tools.
One of them is [vmware](http://www.vmware.com/) with [vCenter](https://www.vmware.com/products/vcenter-server) and some [ESXi](https://www.vmware.com/products/vsphere/features/esxi-hypervisor) servers to offer and manage systems in a virtual environment.
Another tool we use is called [i-doit](http://www.i-doit.org/) and is used for creation and documentation of inventories and network related information.
As you may have read in a previous [post](https://developer.epages.com/blog/2015/06/25/infrastructure-as-code.html) we often use [Jenkins](https://jenkins-ci.org/) for [Continuous Integration](http://www.martinfowler.com/articles/continuousIntegration.html), so it's one of our favourite tools to automate processes.
The key of an automated OS install is the combination of [iPXE](http://ipxe.org/) and kickstart isos, for example preseed values for [Debian](https://wiki.debian.org/DebianInstaller/Preseed) or [Centos/RHEL](http://www.centos.org/docs/4/html/rhel-sag-en-4/s1-kickstart2-file.html).
Last but not least when it comes to system specialisation [Linux](https://www.linux.com/) itself should be mentioned.
To speak with the different interfaces, programming languages like [`Perl`](https://www.perl.org/) and [`Python`](https://www.python.org/) or scripting languages like [`PHP`](https://secure.php.net/) and [`bash`](http://www.gnu.org/software/bash/) are used.

{% image blog/blog-pipeline-tools.png %}

The basic idea is simple. First thing we need is a system.

## The system

This is fairly simple, due to the [vSphere Cloud Plugin](https://wiki.jenkins-ci.org/display/JENKINS/vSphere+Cloud+Plugin) for Jenkins, it is easy to construct a job, building a basic virtual machine from a template.
These templates are predefined with a set of CPU, RAM, disc space as well as an iPXE kickstart iso file that is specifically OS mounted.
If it's needed, you can create and run an additional job changing the values of the machine before the install starts.
Managing the network environment is a little bit more challenging.
In the simplest case a development system should be created, so the system needs an IP with internet access and an R/DNS entry.
Here we killed two birds with one stone.
By using i-doit we provide at first the information about the new system to our documentation system via REST API and in the second step calculate the next free ip in our network.
The system is documented and we have all information we need to create a [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol) and [DNS](https://en.wikipedia.org/wiki/Domain_Name_System) entry.
Using the API of i-doit the DHCP and DNS configuration files were generated, tested and deployed to our DHCP and DNS Servers.

## Installation process

Now we can start the virtual machine with our kickstart script installing the predefined OS.
The kickstart script uses iPXE boot, loads the configuration and installs the system.
The open source boot firmware iPXE allows us to boot an iso file over the network and supports dynamic or static IP configuration depending on your network.
For example for networks without DHCP you can hard code a static IP for an installation and change the network configuration after the initial installation has been done.
The loaded ISO files are preseed values for the specified OS that include all information the installation process process needs to install the OS.
At the moment Centos 6/7 and Debian 7/8 are supported from our side.
After the installation, we have a first simple not very specialised system that could now be used.
Some magic Jenkins jobs do the trick and specialise the system now.

## Specialisation

Here you can explore your creativity.
Many jobs are available: from [security related configurations](https://www.linode.com/docs/security/securing-your-server) over installing of different software to installing our full ePages to a system with a specific version or project specific configurations.
In our situation it depends on the use case. For example internal development systems have other security related configurations than external systems, or test and live systems can have project specific configurations depending on what our customers need.

## The pipeline

Here is a simplified picture of the whole pipeline.
The full process lasts about 10 to 15 minutes but depends on the specific configuration you choose.

{% image blog/blog-pipeline-jenkins.png %}

In the future we'd like to use the existing build pipelines to create distributed systems with our and other software.
