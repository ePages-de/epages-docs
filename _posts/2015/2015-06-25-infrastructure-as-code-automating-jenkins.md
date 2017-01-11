---
layout: post
title: "Infrastructure as code: automating Jenkins"
date: "2015-06-25 09:00:00"
categories: tech-stories
authors: ["Jens", "Dirk"]
---

Here at ePages we heavily rely on [Continuous Integration (CI)](http://www.martinfowler.com/articles/continuousIntegration.html) to make sure our code is always in a good shape.
[Jenkins](https://jenkins-ci.org/) is the software we use as our CI tool.
A mixed language stack mainly composed of `Java`, `JavaScript` and `Perl` spread over multiple teams brings in different build processes and toolings needed to produce the artifacts our software is composed of, e.g. `gradle`, `grunt` and `make`.
We do not run all build jobs on a single Jenkins instance, but already spread out different jobs to dedicated Jenkins servers.
Nevertheless some teams still share their build infrastructure, thus lacking independence e.g. when it comes to introducing new Jenkins plugins or other tools needed for their build process.

{% image blog/blog-jenkins-polyglot.png %}

## Jenkins configuration

Jenkins makes it very easy to introduce new functionality by installing one of the [many available plugins](https://wiki.jenkins-ci.org/display/JENKINS/Plugins).
Unfortunately not every plugin turns out to work as expected or in the worst case can potentially bring down the whole Jenkins instance.
To evaluate unknown plugins by installing them into your production CI infrastructure bears problems, since they often leave unwanted traces behind, even after uninstallation.
Even making changes to a job configuration without adding any new plugins can lead to broken build jobs, negatively affecting the productivity of whole teams.

### The solution

We were looking for ways to make it safe and easy to improve our build infrastructure.
Using version control like [GitHub](https://github.com/) for all of our source code, it was natural to treat our infrastructure the same way and be able to roll back to a previous version without any hassle.
Versioning whole images of Jenkins virtual servers didn't seem feasible and plugins like [JobConfigHistory](https://wiki.jenkins-ci.org/display/JENKINS/JobConfigHistory+Plugin) did not cover managing plugin versions as well.

### Server provisioning using Ansible and Vagrant

We started by automating the installation of Jenkins, including all required plugins.
The idea is to set up a Jenkins server from scratch by running just a single command, while still being able to use the same facilities to update the installation, e.g. with new plugins, using the same technology.
To achieve this, we decided to use [Ansible](http://www.ansible.com/home), mainly due to existing know-how.

Once the basic installation of Jenkins and its prerequisites is done, the interesting part begins: installing and configuring plugins.
The installation of additional plugins is done by utilising the [Jenkins Command Line Interpreter (CLI)](https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+CLI).
This allows us to provide plugin names and explicit versions to be installed.
The tricky part is getting the global configuration of Jenkins right.
The pragmatic solution we chose was to create the `config.xml` locally (but templated) and copy it over to Jenkins using the according Ansible task.

With the toolset described so far, the basic setup can be easily recreated any time.
And since this is so easy now, we usually test our setup scripts by installing them to local [Vagrant](https://www.vagrantup.com/) machines.
Especially for the global Jenkins configuration this is an essential step, which is even easier and faster due to Ansible's smart way of tracking installation state.
Just rerun the Ansible playbook and changes in the configuration are automatically applied; then you can be sure, that they are based on your version-managed infrastructure code!

### Job provisioning using Job DSL

Usually, Jenkins jobs are created manually using the web UI and are stored in XML configuration files.
These files are quite verbose, and are not nice to edit directly.
If you want to create a new job based on an existing one, you should do this in an automated fashion.
Here a very nice plugin comes to help: the [Job DSL Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Job+DSL+Plugin) allows the creation of jobs from simplified DSL ([Domain Specific Language](http://martinfowler.com/books/dsl.html)) descriptions, which are much nicer to read and write than the XML configuration files.
All you need to create your jobs is a single so-called _seed_ job, which (in our case) pulls the job definitions as Groovy DSL scripts from Git to generate the desired jobs.

The _seed_ job can be run whenever there are changes in the DSL scripts for the jobs, and updates the configuration of changed jobs accordingly.
Existing build metadata, like next build number files, is not touched by such an update.

### Handling of job metadata

Managing the job metadata, e.g. the `nextBuildNumber` file, the workspace and the results of the last builds, is still a tricky topic.
As these files are created or updated by the actual build executions, they are not easily recreated.
Therefore, we stick to doing some plain old backup task to save the relevant parts.
For us, these are the `nextBuildNumber` files and the `builds` directory.
All other job metadata is either not really important, like symbolic links to the last successful build directory, or will automatically be recreated with the next build, e.g. the workspace.

### Running Jenkins slaves on developer machines

Being able to run lots of build jobs in parallel is key to receiving fast feedback from our CI infrastructure.
With modern desktops and laptops there is enough idle CPU and RAM resources available in our offices most of the time, which we want to use for this purpose by running [Jenkins slaves](https://wiki.jenkins-ci.org/display/JENKINS/Step+by+step+guide+to+set+up+master+and+slave+machines).
In order not to interfere with the operating system and tools installation on each developer's machine, we create virtual images (or maybe even [Docker](https://www.docker.com/) containers in the future) containing all the components needed for a Jenkins slave to execute build jobs.
Using the [Jenkins Swarm Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) each slave registers itself at its central master, which delegates build job execution to idle slave nodes.
Each build job is configured to carry one or more _labels_, which control that they get only executed on slaves which can support these kind of jobs.
This way we can separate e.g. [Selenium](http://www.seleniumhq.org/) integration tests from unit tests.

## Outlook

We want to offer each team an easy way to setup and manage their own dedicated CI infrastructure and tweak it to their specific needs.
By spreading the load of executing build jobs to various developer's machine we can further shorten the time a team needs to wait for the [GitHub pull request builder plugin](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+pull+request+builder+plugin) to check if a pull request is safe to merge into the main development line, thus preventing stale pull requests and merge hell later.
We could also offload more slaves to e.g. [Amazon EC2](https://aws.amazon.com/ec2/), if we really need the compute power.
The process of moving our custom Jenkins installations and job configurations to this new CI infrastructure has just started and we are eager to learn how this will turn out in the future.
