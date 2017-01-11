---
layout: post
title: "Optimised monitoring and evaluation of Selenium test results"
date: "2016-02-11 10:11:12"
image: blog-header/test-automation-1.jpg
categories: tech-stories
authors: ["Benjamin N.", "Bastian K."]
---

Today we want to share with you the first of two blog posts on a recent project concerning an optimised workflow for the monitoring and evaluation of the Selenium integration test results from multiple environments in our pipeline. This initial article should serve as brief introduction to the business context, encompass the major pain points of the established test evaluation process and constitute the essential requirements for a technical solution. Furthermore, we will envision two solution approaches and discuss which option fits best our needs and therefore will be implemented.

The second post will seamlessly follow up and elaborate in-depth on the technical aspects of the implementation, but now let us start digging towards the core of the business challenge.

{% imagecaption blog/blog-pipeline-elk-test-evaluation-report.png 30% right %} The report index of a set {% endimagecaption %}

## Background story

Currently our [ePages Selenium Framework](https://developer.epages.com/blog/2015/07/23/the-epages-selenium-framework.html) (**ESF**) has evolved to a reputable instrument for quality assurance of the next iteration of the ePages platform. The development teams are highly deliberated in implementing corresponding automated UI tests for each feature to safeguard the functionality of every Cartridge (platform module).

In our Continuous Delivery Pipeline (**CDP**) we run all of these tests in various test sets (see image) on every possible type of ePages environment, which is either freshly installed or patched to the latest release candidate. The monitoring and evaluation of all test results from each pipeline run is a fundamentally important duty before releasing the next version of ePages.

### Motivation

In the past, an engineer of the release and test automation team needed to check a dozen of Jenkins Jobs – which represent the various use cases of ePages in production – to analyse the test results and create a list of failing tests in our wiki on a daily basis.

This tedious and time consuming collection task was soon identified as a major pain point. Hence, we decided to fully automate the process and figure out an effective, reliable and centralised storage solution for all test reports.

### Requirements

After careful consideration we determined that two non-functional requirements should be in the focus of the intended solution:

* **Simplicity:** The solution needs to be easy to implement, test, configure and maintain.
* **Expandability:** Later on, the solution needs to be able to additionally handle other kinds of logs from our pipeline machines as well as scale with the amount and frequency of data input.

### Two options

At first glance we had two different ideas for our architectural solution approach:

* **Option A:** Custom Python scripts at the end of a Selenium Jenkins job transfer the test results from a test machine into a dedicated MySQL database. Another script or a custom frontend should then retrieve all test results from the database at the end of a pipeline run and display them in an usable fashion.
* **Option B:** Use the popular ELK-stack (Elasticsearch, Logstash, Kibana) as a basis and adapt it to fit our needs. Each part should run in it's own Docker container and Docker images are build and tested in a CI environment. Our pipeline pulls the containers on-time and runs them with a dedicated configuration for each Jenkins job. For scaleability we create a distributed storage cluster including mirroring for node data.

After a team-internal discussion we concluded that we want to implement **Option B** as it relied on an established ecosystem which is popular for large-scale and high-performance system log monitoring. Like other key-value stores Elasticsearch supports a very flexible document structure, which does not need any database schema, and on top all documents can also be retrieved via simple REST calls, which leaves room for developing a custom-tailored client especially for our use case scenario.
Another important reason was that this approach would give us the opportunity to rather store other business-critical information (e.g. event logs) from a pipeline run in the near future as well. Last but not least, the ePages operations team is already using the ELK-stack at customer projects and hence there is a reliable knowledge source inside the company in case we would need it.

In summary, the mentioned ease of extension of Elasticsearch in combination with a generally low effort for maintenance convinced us to strongly opt against building every solution part on our own as suggested in **Option A**.

### Read on

If you are interested in learning more about this project you may accompany us on the second post which will be published the next week. This comprehensive follow-up will outline the solution architecture, split it up into individual solution parts and then focus on the technical details including the setup of Elasticsearch, Logstash, Jenkins Jobs, Docker and CircleCI.

Look forward to find out if we have choosen our options wisely!

## Related post

[How to ease test evaluation in the Continuous Delivery Pipeline](https://developer.epages.com/blog/2016/02/16/how-to-ease-test-evaluation-in-the-continuous-delivery-pipeline.html)
