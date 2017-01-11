---
layout: post
title: "Follow-up: Automating Jenkins"
date: "2015-10-22 09:00:00"
categories: tech-stories
authors: ["Dirk"]
---

Some weeks ago, we published [Infrastructure as Code: automating Jenkins](https://developer.epages.com/blog/2015/06/25/infrastructure-as-code-automating-jenkins.html).
In that post, we described some open ends, which still needed to be solved in order to satisfy our expectations.
In this follow-up post, I will explain how we advanced on our way to have a fully automated continuous integration server, this time coming pretty close to an *[immutable server](http://martinfowler.com/bliki/ImmutableServer.html)*.

## Remaining shortcomings

The main challenge we had earlier was the central configuration of the Jenkins master, which is extended by lots of plugins.
As a workaround, we created the full `config.xml` in advance and just copied it over to Jenkins.
In addition, we were pretty unhappy with not being able to avoid local modifications, which were still leaving permanent traces behind, even when being overwritten by a new run of [Ansible](http://www.ansible.com/).

## Introducing Docker

{% image blog/blog-docker-logo-h.png %}

So, let's get started on our journey towards immutable Jenkins master!
The main step to achieve this goal was our decision to build our further steps on [Docker](https://www.docker.com/).
With the very sophisticated official [Jenkins image](https://hub.docker.com/_/jenkins/) available at [Docker Hub](https://hub.docker.com/), we found an excellent starting point.
The image already provides out-of-the-box support for installing additional plugins by providing a list of plugins and versions, which we previously did in a much more complicated way using Jenkins CLI.

In addition, the Docker image hinted us to the solution of the configuration problem: Groovy init hooks.
With these scripts, which utilise the internal API of Jenkins itself and also the plugins, we were able to kick out the precreated `config.xml`.
As an example, here is a code snippet that creates an account:

{% highlight groovy %}
import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

def hudsonRealm = instance.getSecurityRealm()

def user = hudsonRealm.createAccount("admin", "password")
user.setFullName("Admin")
user.save()
{% endhighlight %}

As you can easily imagine, these scripts add tremendous flexibility to the way of configuring Jenkins, especially when combining the possibilities of Groovy with the dynamic generation of
these scripts through templates from Ansible.

## Immutability

To get a truly immutable server, there are two things left: Once again, the handling of job metadata, which needs to be persisted, and the Jenkins Web UI, which still allows changing the configuration,
although these changes will be overwritten with the next run of Ansible.

The job metadata problem is easily solved using a standard Docker feature: volumes.
We are intentionally not mounting the whole `jenkins_home` folder as a persistent volume, but only the reallly important subfolders `jobs` and `nodes`, which contain the actual metadata.
As already described in the earlier post, we only backup a small fraction of the files in these folders, as for example the `jobs` folder also contains the workspace,
which can be created whenever needed by just checking out from version control.

The problem of possible modifications through the web UI can be solved using the [Matrix Authorization Strategy Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Matrix+Authorization+Strategy+Plugin).
Utilising this plugin, we create only one real admin user, which has a (unknown) random password, and other users, which are only allowed to trigger builds.
In doing so, the only way to change the configuration of the server is to create a new version of the Docker container with Ansible.
Furthermore, jobs can also only be created or modified by the [Job DSL Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Job+DSL+Plugin).

## Outlook

Regarding the general setup of the Jenkins master, we are now more or less where we want to be.
There's still room for improvement, but the main challenges that lie ahead of us are more in the area of getting our build slaves automated the way we want,
and running all of our build jobs in an appropriate environment.
In the end, this is typical everyday CI maintenance, which we won't be able to get rid of completely even with full automation... {% emoji wink %}
