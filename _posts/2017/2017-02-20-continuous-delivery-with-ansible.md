---
layout: post
title: "Continuous delivery with Ansible"
date: "2017-02-20 06:39:20"
image: blog-header/heartbeat.jpg
categories: tech-stories agile
authors: ["Thomas H."]
---

# Introduction
In recent years there has been a [steady trend towards cloud based deployments](http://www.softwareadvice.com/buyerview/deployment-preference-report-2014/) of applications and services.  
This increases the distributed nature of the systems we develop, which in turn raises the complexity and effort
required to develop and manage (i.e. provision resources, build, test, configure, deploy and monitor) them.  
This is especially true, as during this transition phase the environment is heterogeneous and different methods of building and deploying software are combined (e.g. RPM packages and Docker containers).

At the same time, delivery cycles are expected to shorten because of the [opportunity cost of not releasing software](http://robertbaillie.blogspot.de/2014/10/the-opportunity-cost-of-delaying.html)
and the [Agile principles](http://agilemanifesto.org/principles.html) of customer collaboration and early feedback.

This post will outline how [Ansible](https://www.ansible.com/) can help in approaching these challenges.
It also includes a short discussion on the relation of Ansible to other tools supporting continuous delivery and
scalability of the development process, specifically [Docker](https://www.docker.com/) and [Jenkins](https://jenkins.io/).

# Documentation vs. Automation
The way we think about documentation [is changing](https://devops.com/documenting-devops-agile-automation-and-continuous-documentation/).  
For the documentation of application software it is generally well understood that it should be generated from code, to leave as little possibility for deviation as possible.  
In the case of "management code" this is more difficult, because the things being modelled are often heterogeneous and not as focussed in terms of their implementation as for example a REST-API or a library / module.
This is where the concept of [using declarative formats for automation](https://12factor.net/#introduction) can provide much value.

# Structure of Ansible projects
Note that I am using the term "Ansible project" without implying a certain structure in terms of source code repositories.

## Playbooks
[Playbooks](http://docs.ansible.com/ansible/playbooks.html) are the entry point when looking at an Ansible project.  
Generally, there are two kinds of Playbooks.

### Setup Playbooks
One type of would initially provision / prepare an environment to deploy an application into it.  
These playbooks would typically be named `setup-<project>.yml`.  
While this type could traditionally be seen more on the IT department's side of an organization, this playbook would also be used to set up a development environment for that application.  
The point of using the same technique for both of these things is, that it was easier to manage the differences between them in a joint effort.

### Deployment Playbooks
The other kind of playbooks would be named `deploy-<project>.yml`.  
These are meant to execute continuously, deploying changing versions of an application.  
This type is not necessarily ran during development, but there could be an argument of doing so, which will be discussed below.

## Roles
While playbooks are the entry point, one will soon be looking at [Roles](http://docs.ansible.com/ansible/playbooks_roles.html), because playbooks usually should not contain single tasks, but only sets of roles (that are applied to groups of hosts).  
When learning about a role, the best place to start is usually `defaults/main.yml`.  
This file is supposed to contain all variables that are being used in the role, and - as the filename implies - their default values. This file serves the primary purpose of documenting the role.  
When using a role written by others, these are the variables that are meant to be used to adapt the role to specific needs.

Example `defaults/main.yml`:  
{% highlight yml %}
epages_install_via_install_script: yes
epages_version: # undefined means taking default from install-epages.sh
epages_repo_url: http://www.epages.com/repo/epages

epages_install_from_git: yes
epages_cartridges_github_account: ePages-de
epages_cartridges_github_branch: develop
epages_additional_cartridges:
  - Event

epages_appserver_ports: "10045-10048"
epages_solr_autocommit_maxtime: 1000
{% endhighlight %}

Looking at this file the reader should have a good idea that this role takes repository and version parameters, and can be configured to install the application from a script or via Git, and both are happening by default.  
It also accepts a list of additional cartridges to be installed, probably during the Git phase.  
There are certainly more things that could, and will be, included here over time, and of course the question remains why both installation methods are performed.  
However the point of this example is to show that by looking at the defaults, someone could get a good idea about the scope of the role without even looking at the tasks.  

## Variables
There is also a file `vars/main.yml` inside a role that can be used to document [variables](http://docs.ansible.com/ansible/playbooks_variables.html), but generally any role should be considered "immutable", similar to a class in OO programming. Only when it is used in a playbook will it receive its arguments. Assigning role variables in playbooks is a very good way to document things, when you know the scope of the involved roles.  
Other places to put variables include `group_vars/<groupname>.yml` and `host_vars/<inventory-hostname>.yml`. The latter should be avoided, because we are trying to rid of host-specific configuration in the first place.  
Talking about hosts and groups this leads to the next section, the inventory.

## Inventory
The [inventory](http://docs.ansible.com/ansible/intro_inventory.html) contains hosts divided into groups, and can also contain variables per group or host (discouraged, see above). When a playbook is executed using the `ansible-playbook` it usually receives the particular inventory file it should be using.  
There are several ways how different inventory files can be used, for example
having a `localhost` inventory file, which has localhost mapped to all relevant groups, and eventually roles.

The role the inventory and group variables plays in terms of documenting infrastructure is to capture the differences between environments, by assigning variables that are exposed by the roles.  

Of course this structure assumes that we are dealing with "hosts" in the first place. But how relevant is this model in an environment where the primary method of deployment is through containers and hosts are being abstracted away?

# Docker and Ansible
At first glance Docker and Ansible seem to be solving a similar problem in very different way, making it questionable how and if to use them in conjunction.
