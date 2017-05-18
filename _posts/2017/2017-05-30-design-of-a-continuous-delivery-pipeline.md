---
layout: post
title: "Design of a continuous delivery pipeline"
date: "2017-05-30 07:00:00"
image: blog-header/microservices-pipeline-1.jpg
categories: tech-stories
authors: ["Benjamin", "Nicole"]
---

This is the first post of a three-part blog post series about the foundation pillars for the [ePages](https://www.epages.com/en/) next generation e-commerce platform, where we'll talk about the Continuous Delivery Pipeline (CDP) of our new Microservices Architecture.

In these posts we will answer the 4 most important questions that show how to continuously deliver new microservices, feature updates, and bug fixes to our customers within less time than the average lunch break.
To deploy in under 45 minutes, with highest confidence, and without quality compromises we need to apply several advanced techniques for building a solid and high-performance continuous delivery pipeline that is capable of handling all our demands with ease.

This post deals with the design of the CDP, whereas in the next to we'll talk about versioning microservices and handling failures.

## How did we design our continuous delivery pipeline in detail so that we support our microservices architecture?

In former times, a Continuous Delivery Pipeline was set up by using the UI of a CI/CD tool such as [Jenkins](https://jenkins.io/) as well as various virtual machines as test environments.
With the help of tools like [Puppet](https://puppet.com/) and [vSphere](http://www.vmware.com/de/products/vsphere.html), we integrated virtual machines as nodes to Jenkins  to distribute different Jenkins jobs onto.
A CDP was a concatenation of several jobs producing a job chain, which were manually set up using the WebUI of Jenkins.

With the concept infrastructure-as-code the setup of a CDP changed completely to an automated process.
Using Jenkins DSLs (like the [Job DSL Plugin](https://developer.epages.com/blog/2016/01/28/jenkins-job-dsl-plugin.html) and [Pipeline Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin)) to configure Jenkins jobs, the manual process of creating a job passed over into writing scripts.
Using scripts as a representation of jobs not only allows an automatically set up Jenkins configuration but also versioning and creating backups of a Jenkins instance.

Testing of several microservices is solved by using individual Docker images representing the actual state of a single microservice.
Tools such as [Kubernetes](https://kubernetes.io/) and [Google Compute Engine (GCE)](https://cloud.google.com/compute/) are used to deploy and test the software.

{% imagebasic blog/blog-microservices-pipeline-cdp-stages.png The_Continuous_Delivery_Pipeline %} image {% endimagebasic %}

There are actually two Jenkins instances active to display the CDP (see image above).

On the one hand, there is the build-jenkins, that is responsible for running pull request tests from [GitHub](https://github.com/).
This way, jobs are triggered when new pull requests (PR) of any microservice are available.
These jobs run unit and integration tests to validate the commits within these PRs.
If these checks have passed successfully a new docker image of the microservice is build and published.
In this stage the builds are able to be run in parallel.
One build in the build stage takes about 5 minutes on average.

On the other hand, there is the cdp-jenkins, that is responsible for running the acceptance, pre-production, and production stage.
The acceptance stage is triggered when a new pull request is merged on the master branch of a project.
For each acceptance stage a new GCE environment will be set up to run the API tests.
The acceptance stage also allows parallel builds to reduce time expenses.
One build of the acceptance stage lasts about 25 minutes on average.

After passing the acceptance stage, all builds are queued up to sequentially pass over into the pre-production stage.
In this stage the services are updated with respect to zero downtime deployment.
To assure zero downtime there are zero downtime tests in place running in parallel to the updating process of the services.
Follow up regression API tests assure a correct functionality of each service.
The pre-production stage lasts about 5 minutes on average.

After passing the pre-production stage the changes to the service get rolled out.
The production stage lasts about 5 minutes.

That's pretty fast, isn't it?

Ok, folks, we're done with part 1.
Stay tuned for the next post about versioning microservices.
