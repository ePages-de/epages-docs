---
layout: post
title: "Continuous documentation with Ansible"
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
This is where the concept of [using declarative formats for automation](https://12factor.net/#introduction) can fill the gap.

# Structure of Ansible projects
As there are many sources of Ansible best practices to be found on the web, instead of writing another one, I would like to assume the viewpoint of someone reading Ansible code, rather than writing it.
Note that I am using the term "Ansible project" without implying a certain structure in terms of source code repositories.  

## Playbooks
[Playbooks](http://docs.ansible.com/ansible/playbooks.html) are the entry point when looking at an Ansible project.  
Generally, there are two kinds of Playbooks.

### Setup Playbooks
One type of would initially provision / prepare an environment to deploy an application into it.  
These playbooks would typically be named `setup-<project>.yml`.  
While this type could traditionally be seen more on the IT department's side of an organization, this playbook would also be used to set up a development environment for that application.  
The point of using the same technique for both of these things is that it becomes easier to manage and document differences between them in a joint effort.

### Deployment Playbooks
The other kind of playbooks would be named `deploy-<project>.yml`.  
These are meant to execute continuously, deploying changing versions of an application.  
This type is not necessarily ran during development, but an argument could be made to do so. Instead this type of playbook would typically be executed during a CI/CD run, and a failure during that phase could be the cause for investigating the playbook in the first place.

Let's look at an example playbook (`deploy-unity.yml`):
{% highlight yml %}
---
- hosts: application-vms

  remote_user: deploy
  become: true

  pre_tasks:
    - name: Abort on missing ePages-installation
      shell: rpm -q epages
      args:
        warn: false
      register: check_epages
      failed_when: "check_epages.rc != 0"
      changed_when: false

  roles:
    - role: docker
      tags: [ docker ]

    - role: epages-unity
      tags: [ unity ]
{% endhighlight %}
This playbook should be fairly self-explanatory, given you know what "[Unity](https://www.epages.com/de/now/)" is.  
Looking at the pre-task, its intention seems to be to document a dependency, providing a bit more context for this playbook.
The roles that are being assigned are `docker` (which would correctly be assumed to install Docker on the host) and `epages-unity`.
Concerning the hosts (`centos-vms` in this case), the word implies a group of hosts. This could also be read as "the hosts that this playbook is meant to run against", with the distinction, that depending on the environment, it might only be executed against a single host at a time, using the `--limit` parameter of `ansible-playbook`.
Motivation for doing it like this is that the exact same playbooks can be used for different inventories (see below).

## Roles
While playbooks are the entry point, one will soon be looking at [Roles](http://docs.ansible.com/ansible/playbooks_roles.html), because playbooks usually should not contain single tasks, but only sets of roles (that are applied to groups of hosts).  
When learning about a role, the best place to start is usually `defaults/main.yml`.  
This file is supposed to contain all variables that are being used in the role, and - as the filename implies - their default values. This file serves the primary purpose of documenting the role.  
When using a role written by others, these are the variables that are meant to be used to adapt the role to specific needs.

Example `defaults/main.yml` of `epages-unity` role:  
{% highlight yml %}
epages_unity_folder: /srv/epages/unity
epages_unity_use_docker_compose: yes
epages_unity_use_systemd: "{{ not epages_unity_use_docker_compose }}"

epages_unity_epages6_appserver_range: "10045-10048"
epages_unity_web_server_port: 7000
epages_unity_ssl_web_server_port: "{{ epages_unity_web_server_port }}"
epages_unity_url: "{{ ansible_fqdn }}"
epages_unity_api_url: "{{ epages_unity_url }}/api/v2"

epages_unity_create_shop: yes
epages_unity_shop_name: demounity
{% endhighlight %}
At the top there is a directory, which probably refers to the host.
Since the role requires Docker (see playbook example), and there is a reference to docker-compose in the next property, one could (correctly) assume that the file being copied there could be a docker-compose definition file.
However there is also a property `epages_unity_use_systemd` which is apparently mutually exclusive with `epages_unity_use_docker_compose`.
The purpose of expressing two different ways of starting the application is to document that there is a transition. While either of the two ways should work, one or the other might be broken while development is still ongoing.  
The file goes on with some more configuration of what seem to be application properties, and finally two options to create a shop with a given name when deploying.
By looking at the defaults, someone could get a good idea about the scope of the role without looking at the tasks.  

## Variables
There is also a file `vars/main.yml` inside a role that can be used to document [variables](http://docs.ansible.com/ansible/playbooks_variables.html), but generally any role should be considered "immutable", similar to a class in OO programming. Only when it is used in a playbook will it receive its arguments. Assigning role variables in playbooks is a very good way to document things, because it is the most , as it only requires to know about the scope of the involved roles.  
Other places to put variables include `group_vars/<groupname>.yml` and `host_vars/<inventory-hostname>.yml`. The latter should be avoided, because we are trying to rid of host-specific configuration to begin with.  
Talking about hosts and groups this leads to the next section, the inventory.

## Inventory
The [inventory](http://docs.ansible.com/ansible/intro_inventory.html) contains hosts divided into groups, and can also contain variables per group or host (discouraged, see above). When a playbook is executed using the `ansible-playbook` it usually receives the particular inventory file it should be using.  
There are several ways how different inventory files can be used, for example
having a `localhost` inventory file, which has localhost mapped to all relevant groups, and eventually roles.

The role the inventory and group variables plays in terms of documenting infrastructure is to capture the differences between environments, by assigning variables that are exposed by the roles.

Example inventory file:
```
[shared-vms]
shared-05.internalnetwork.epages.com
shared-06.internalnetwork.epages.com
shared-07.internalnetwork.epages.com
shared-08.internalnetwork.epages.com
shared-09.internalnetwork.epages.com
shared-10.internalnetwork.epages.com
shared-11.internalnetwork.epages.com

[developer-vms]
vm-thirsch.internalnetwork.epages.com
vm-rteixeira.internalnetwork.epages.com
vm-ubiallas.internalnetwork.epages.com
abrandimarti-vm01.internalnetwork.epages.com

[application-vms:children]
shared-vms
developer-vms

[shared-jenkins]
shared-jenkins.internalnetwork.epages.com

[build-slaves]
shared-01.internalnetwork.epages.com
shared-02.internalnetwork.epages.com
shared-03.internalnetwork.epages.com
shared-04.internalnetwork.epages.com

[shared-tools]
shared-12.internalnetwork.epages.com

[infrastructure-vms:children]
shared-jenkins
build-slaves
shared-tools
```
Referring to the playbook example above, we can see now, that the `application-vms` group is comprised of `shared-vms` and `developer-vms`, and that there is another group `infrastructure-vms` containing development infrastructure.
Grouping `application-vms` is a way of documenting the fact that `developer-vms` and `shared-vms` can and should be set up using the same playbooks (which implies including operating-system-specific tasks).

Of course this structure of playbooks and inventories assumes that we are dealing with "hosts" in the first place. But how relevant is this model in an environment where the primary method of deployment is through containers and hosts are being abstracted away?

# Docker and Ansible
At first glance Docker and Ansible seem to be solving a similar problem in very different way, making it questionable how and if to use them in conjunction.
