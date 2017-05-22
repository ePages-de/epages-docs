---
layout: post
title: "Continuous Documentation with Ansible"
date: "2017-03-21 06:39:20"
image: blog-header/blog-forest-park-walk-trail.png
categories: agile
authors: ["Thomas"]
---

## Introduction
In recent years there has been a [steady trend towards cloud based deployments](http://www.softwareadvice.com/buyerview/deployment-preference-report-2014/) of applications and services.  
This increases the distributed nature of the systems we develop, which in turn raises the complexity and effort
required to develop and manage (i.e. provision resources, build, test, configure, deploy and monitor) them.  
This is especially true, as during this transition phase the environment is heterogeneous and different methods of building and deploying software are combined (e.g. RPM packages and Docker containers).

At the same time, delivery cycles are expected to shorten because of the [opportunity cost of not releasing software](http://robertbaillie.blogspot.de/2014/10/the-opportunity-cost-of-delaying.html)
and the [Agile principles](http://agilemanifesto.org/principles.html) of customer collaboration and early feedback.

This post will outline how [Ansible](https://www.ansible.com/) can help in approaching these challenges.
It also includes a short discussion on the relation of Ansible to other tools supporting continuous delivery and
scalability of the development process, [Docker](https://www.docker.com/) and [Jenkins](https://jenkins.io/).

## Documentation vs. Automation
The way we think about documentation [is changing](https://devops.com/documenting-devops-agile-automation-and-continuous-documentation/).
For the documentation of application software it is generally accepted that it should be generated from code, to leave as little possibility for deviation as possible.  
In the case of "management code" this is more difficult, because the things being modelled are often heterogeneous and not as focussed in terms of their implementation as for example a REST-API or a library / module.  
The concept of [using declarative formats for automation](https://12factor.net/#introduction) can fill this gap.

## Structure of Ansible projects
As there are many sources of Ansible best practices to be found on the web, instead of writing another one, I would like to assume the viewpoint of someone reading Ansible code, rather than writing it.
Note that I am using the term "Ansible project" without implying a certain structure in terms of source code repositories.  

### Playbooks
[Playbooks](http://docs.ansible.com/ansible/playbooks.html) are the entry point when looking at an Ansible project.  
A common convention is to categorize playbooks into two kinds.

#### Deployment Playbooks
One type of playbooks would be named like `deploy-<project>.yml`.  
These are meant to execute continuously, deploying changing versions of an application.  
They would typically be executed during a CI/CD run, and a failure during that phase could be the cause for investigating the playbook in the first place.

Let's look at an example playbook (`deploy-epages-now.yml`):
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

    - role: epages-now
      tags: [ epages-now ]
{% endhighlight %}
This playbook should be fairly self-explanatory, given you know what [ePages Now](https://www.epages.com/de/now/) is.    
Looking at the pre-task, its intention seems to be to document a dependency, providing a bit more context for this playbook.  
The roles that are being assigned are `docker` (which would correctly be assumed to install Docker on the host) and `epages-now`.  
The installation of Docker in a deployment playbook is questionable, and should probably be refactored once the way of doing the deployment has stabilized (see below).
Concerning the hosts (`application-vms` in this case), the word implies a group of hosts. This could also be read as "the hosts that this playbook could run against", keeping in mind that depending on the environment, it might only be executed against a single host at a time.
This is done using the `--limit` parameter of `ansible-playbook`, which is a very common case for CI/CD jobs.  
Motivation for doing it like this is that the exact same playbooks can be used for different environments / inventories (see below).

#### Setup Playbooks
The other type of playbook would initially provision / prepare an environment to deploy an application into it.  
These playbooks would typically be named `setup-<project>.yml`.
While this type could traditionally be seen more on the IT department's side of an organization, it would also be used [to set up a development environment](https://github.com/ePages-de/mac-dev-setup) (i.e. developer laptop) for that application.  
The point of using the same technique for both of these things is that it becomes easier to manage and document differences between them in a joint effort. This continually provides value for the company, because setup times for developers are reduced.  
Using playbooks to install a development environment is a good way of incorporating new developers. Invariably occurring problems are an opportunity to familiarize with the environment and getting used to the workflow.

### Roles
While playbooks are the entry point, one will soon be looking at [Roles](http://docs.ansible.com/ansible/playbooks_roles.html), because a playbook typically contains sets of roles (that are applied to groups of hosts).  
The motivation to do it like that is to [separate the What from the How](http://wiki.c2.com/?SeparateTheWhatFromTheHow).  
When learning about a role, the best place to start is `defaults/main.yml`.  
This file is supposed to contain all variables that are being used in the role, and - as the filename implies - their default values.  
This file serves the primary purpose of documenting the role.  
When using a role written by others, these variables are meant to be used to adapt the role to specific needs.

Example `defaults/main.yml` of `epages-now` role:  
{% highlight yml %}
{% raw %}
epages_now_folder: /srv/epages/epages-now
epages_now_start_using_docker_compose: yes
epages_now_start_using_systemd: "{{ not epages_now_start_using_docker_compose }}"

epages_now_epages6_appserver_range: "10045-10048"
epages_now_web_server_port: 7000
epages_now_ssl_web_server_port: "{{ epages_now_web_server_port }}"
epages_now_url: "{{ ansible_fqdn }}"
epages_now_api_url: "{{ epages_now_url }}/api/v2"

epages_now_create_shop: yes
epages_now_shop_name: demoshop
{% endraw %}
{% endhighlight %}
At the top there is a directory, which probably refers to the host.
Since the role requires Docker (see playbook example), and there is a reference to docker-compose in the next property, one could (correctly) assume that the file being copied there could be a docker-compose definition file.
However there is also a property `epages_now_use_systemd` which is apparently mutually exclusive with `epages_now_use_docker_compose`.  

The purpose of having two different ways of starting the application could (and should) be questioned.  
In this case it suggests that the staging / production setup is still incubating and the deployment happens very similar to development mode.  
But as Agile thinking suggests this should not prevent us from [automating the deployment as early as possible](http://www.theserverside.com/tip/Try-an-Agile-deployment-strategy).

The file goes on with some more configuration of what seem to be application properties, and finally two options to create a shop with a given name when deploying.
By looking at the defaults, anyone could get a good idea about the scope of the role without looking at the [tasks](http://docs.ansible.com/ansible/playbooks_intro.html#tasks-list).  
As mentioned before, roles do not necessarily need to live in the same repository as playbooks, because Ansible supports [role dependencies](http://docs.ansible.com/ansible/playbooks_roles.html#role-dependencies).

### Variables
There is also a file `vars/main.yml` inside a role that can be used to document [variables](http://docs.ansible.com/ansible/playbooks_variables.html), but generally any role should be considered "immutable", similar to a class in OO programming. Only when it is used in a playbook will it receive its arguments.  
Assigning role variables in playbooks is a very straight forward way to document things, as it only requires to know about playbook and the scope of the involved roles.  
Other places to put variables include `group_vars/<groupname>.yml` and `host_vars/<inventory-hostname>.yml`. The latter should be avoided, because we are trying to get rid of host-specific configuration to begin with.  
Group vars could be considered acceptable, but the goal should always be to encapsulate as much behaviour as possible into roles.
Talking about hosts and groups this leads over to the next section, the inventory.

### Inventory
The [inventory](http://docs.ansible.com/ansible/intro_inventory.html) contains hosts divided into groups, and can also contain variables per group or host (discouraged, see above). When a playbook is executed using the `ansible-playbook` it usually receives the particular inventory file it should be using.  
There are several ways how different inventory files can be used, for example
having a `localhost` inventory file, which has localhost mapped to all relevant groups, and eventually roles.

The role the inventory and group variables play in terms of documenting infrastructure is to capture the differences between environments, by assigning variables that are exposed by the roles.

Example inventory file:
{% highlight yml %}
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
vm-alice.internalnetwork.epages.com
vm-bob.internalnetwork.epages.com
vm-carol.internalnetwork.epages.com

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
{% endhighlight %}
Referring to the playbook example above, we can see here, that the `application-vms` group consists of  `shared-vms` and `developer-vms`, and that there is another group `infrastructure-vms` supposedly containing development infrastructure.
Grouping `developer-vms` and `shared-vms` into `application-vms` is a way of saying that they are set up in a similar way (consisting of the same roles and using similar playbooks).  
It also makes a lot of sense to model infrastructure in the same way, that is not directly needed by the application, for example a chat server or a [SonarQube](https://www.sonarqube.org/) instance.

Of course this structure of playbooks and inventories assumes that we are dealing with "hosts" in the first place. But how relevant is this model in an environment where the primary method of deployment is through containers and hosts are being abstracted away?  
This will be discussed shortly, but first let's have a look at the purpose of Ansible in the CI/CD pipeline.

## Jenkins and Ansible
About a year ago, Jenkins received a major update, promoting the [Pipeline plugin](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin) into its core, and making the creation of  [declarative pipelines](https://jenkins.io/blog/2017/02/03/declarative-pipeline-ga/) the primary use case.  

A continuous delivery pipeline is hard to maintain, because it models a complex workflow and must constantly be adapted to changes in any of the projects it integrates. This is why the traditional approach of chaining jobs in Jenkins was considered a maintenance nightmare, and [other approaches](https://wiki.jenkins-ci.org/display/JENKINS/Job+DSL+Plugin) to configuring and maintaining jobs and sequences of jobs were developed. This lead to the decision to make "Pipeline as Code" a first class citizen.

Using Ansible in a CD pipeline helps to separate the concerns of implementing pipeline logic and (building and) deploying an application. [Executing only a single command](https://www.thoughtworks.com/radar/techniques/single-command-deploy) with as few parameters as possible minimizes the number of integration points between the pipeline and the projects that it builds.  
This has a couple of advantages:

- the pipeline becomes more declarative, which promotes understanding across teams and projects
- debuggability is improved, because the individual steps could be executed outside of the context of Jenkins
- fewer Jenkins plugins are needed
- either implementation could be changed, without affecting the other (e.g. Jenkins could be replaced with [GoCD](https://www.gocd.io/) more easily)

## Docker and Ansible
At first glance Docker and Ansible seem to be solving a similar problem in very different ways, making it questionable whether and how to use them in conjunction.  
But their scope is actually quite different.

Docker solves the very specific problem of isolating the runtime and dependencies of a process (without neglecting efficient resource usage, in theory). Containers are meant to be deployed into a homogeneous environment (i.e. running at least the Docker daemon, or possibly an orchestration platform like [Marathon](https://mesosphere.github.io/marathon/) or [Kubernetes](https://kubernetes.io/), which one could [set up using Ansible](https://github.com/kubernetes/contrib/tree/master/ansible)).

Ansible is a general purpose automation tool, that is suitable for working with heterogeneous environments consisting of different [devices](http://docs.ansible.com/ansible/bigip_pool_module.html), [networks](http://docs.ansible.com/ansible/list_of_network_modules.html), [operating systems](http://docs.ansible.com/ansible/package_module.html), [cloud providers](http://docs.ansible.com/ansible/list_of_cloud_modules.html), [methods of deployment](https://docs.ansible.com/ansible/deploy_helper_module.html) etc.

There is increasing motivation for companies of any size to transition to a homogeneous environment, in order to reduce overhead and increase the reliability of their products. But the current state of reality is, that for all but the smallest and [largest](https://www.wired.com/2015/09/google-2-billion-lines-codeand-one-place/) companies, this environment does not exist (yet)... In fact, the opposite is the case, as cloud infrastructure is being evaluated and integrated while new products and legacy system are being developed and maintained concurrently.  
And there will probably always be a Ruby application, which is hosted somewhere else and stubbornly refuses to participate in the pipeline.

But what is a concrete use case for using Docker and Ansible? Consider [docker-compose](https://docs.docker.com/compose/gettingstarted/#/step-3-define-services-in-a-compose-file). It wraps the Docker-API to provide a declarative format for defining a group of interconnected containers.  
The [docker_service module](https://docs.ansible.com/ansible/docker_service_module.html) of Ansible depends on the docker-compose Python module (on the host where `docker-compose` is being executed), and supports identical syntax. `docker-compose.yml` files can be provided either inline in a task, or as separate files.  
Other modules exist for [managing Docker images](http://docs.ansible.com/ansible/docker_image_module.html#docker-image), [Kubernetes](https://docs.ansible.com/ansible/kubernetes_module.html) or [GCE](http://docs.ansible.com/ansible/guide_gce.html) resources.  
There is also a project that works on [building docker images from Ansible playbooks](https://github.com/ansible/ansible-container) solving the issue of [using the Docker cache in the process](https://github.com/ansible/ansible-container/issues/143).
This approach has essentially the same motive as [this lengthy discussion](https://github.com/docker/docker/issues/735) which proposes adding an `INCLUDE` directive to Dockerfiles, to be able to avoid duplication and modularize them.

## Conclusion
Agile principles suggest that changeability is a key quality of competitive software. It is well understood that code readability is a [requirement for staying productive](http://www.goodreads.com/quotes/835238-indeed-the-ratio-of-time-spent-reading-versus-writing-is). Even more so as we are gravitating towards [everything-as-code](https://github.com/lreimer/everything-as-code).

Using declarative formats for automation is [a way](http://wiki.c2.com/?LiberatingConstraint) to achieve this requirement, and the proposition of Ansible is to offer simplicity and general applicability.
Refactoring of playbooks, roles, tasks and variables is easily possible, which is a requirement for maintainability.

Docker and Ansible complement each other well, as Ansible can fill the gaps in the process of managing images and containers, that invariably occur as different orchestration techniques are used.

In the case of Ansible and Bash, a similar statement could be made. An important property of Ansible roles and playbooks is that they provide the context in which they run.  
Even more importantly, Ansible promotes a workflow which does not require manually connecting to a production environment.

Still, when evaluating any software or tool, one should always be mindful why exactly you are using it, i.e. what specific problem it solves for you, and what possible alternatives are.
There obviously is no silver bullet for solving the problem of increasing complexity, and constant effort has to be invested in order to alleviate it.
