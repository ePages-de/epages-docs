---
layout: post
title: "The Continuous Delivery Pipeline of our Microservices Architecture"
date: "2017-05-30 07:00:00"
image: blog-header/microservices-pipeline-1.jpg
categories: tech-stories
authors: ["Benjamin and Nicole"]
---

In this blog post series we explain one of the foundation pillars of the ePages next generation E-Commerce platform, the The Continuous Delivery Pipeline (CDP) of our new Microservices Architecture.

We prepared 3 posts to answer the 4 most important questions that show how to continuously deliver new microservices, feature updates and bug fixes to our customers within less time than the average lunch break.
To deploy in under 45 minutes and with highest confidence and without quality compromises we need to apply several advanced techniques for building a solid and high-performance continuous delivery pipeline that is capable of handling all our demands with ease.

- Part 1: Design of the continuous delivery pipeline
- Part 2: Versioning of microservices
- Part 3: Handling failures in the continuous delivery pipeline

## Part 1: Design of the continuous delivery pipeline

**Question:** How did we design our continuous delivery pipeline in detail so that we support our microservices architecture?

**Answer:** In former times a Continuous Delivery Pipeline (CDP) was set up by using the UI of a CI/CD tool like Jenkins and various virtual machines as test environments.
With the help of tools like Puppet (https://puppet.com/) and vSphere (http://www.vmware.com/de/products/vsphere.html) virtual machines were integrated to Jenkins as nodes to distribute different Jenkins Jobs onto.
A CDP was a concatenation of several jobs producing a job chain, which were manually set up using the WebUI of Jenkins.

With the concept infrastructure-as-code the setup of a CDP changed completely to an automated process.
Using Jenkins DSLs (like Job DSL Plugin (https://wiki.jenkins-ci.org/display/JENKINS/Job+DSL+Plugin) and Pipeline Plugin (https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin)) to configure Jenkins jobs the manual process of creating a job passed over into writing scripts.
Using scripts as a representations of jobs not only allows an automatically setup Jenkins configuration but also the versioning and creating backups of a Jenkins instance.

The testing of several microservices is solved by using individual Docker images representing the actual state of a single microservice.
Tools like Kubernetes and Google Cloud Engine (GCE) are used to deploy and test the software.

{% image blog/blog-microservices-pipeline-cdp-stages.png %}
Figure 1: Continuous Delivery Pipeline

There are actually two Jenkins instances active to display the continuous delivery pipeline (figure 1).

On the one hand there is the build-jenkins, which is responsible for running pull request tests from GitHub.
Hereby jobs are triggered when new pull requests (PR) of any microservice is available.
These jobs run unit and integration tests to validate the commits within this PRs.
If these checks have passed successfully a new docker image of the microservice is build and published.
In this stage the builds are able to be run in parallel.
One build in the build stage takes on average about 5 minutes.

On the other hand there is the cdp-jenkins, which is responsible for running the acceptance, pre-production and production stage.
The acceptance stage is triggered when a new pull request is merged on the master branch of a project.
For each acceptance stage a new GCE environment will be set up to run the API tests.
The acceptance stage also allows parallel builds to reduce time expenses.
One build of the acceptance stage lasts about 25 minutes on average.

After passing the acceptance stage all builds are queued up to sequentially pass over into the pre-production stage.
In this stage the services are updated with respect to zero downtime deployment.
To assure zero downtime there are zero downtime tests in place running in parallel to the updating process of the services.
Follow up regression API tests assure a correct functionality of each of the services.
The pre-production stage lasts about 5 minutes on average.

After passing the pre-production stage the changes to the service get rolled out.
The production stage lasts about 5 minutes.
