---
layout: post
title: "RESTful API documentation using RAML rocks! A TechWriter experience report."
date: "2015-05-21 12:00:00"
icon: compass
tags: RESTful API documentation RAML RamlParser
categories: tech-stories
authors: ["Birgit Bader"]
---

With a career background as a Technical Writer mainly in mechanical/electrical engineering and consumer goods businesses, I was a real newbie in the field of software development. I took this fresh challenge and find myself now right in the middle of an exciting path to a state-of-the-art RESTful API documentation. Interested in my story how ePages faces this? Read on!

Developing a REST API based on JSON to simply connect third party applications to the ePages software, this REST API also needed proper documentation. To realise this, I needed to work closely together with the developers and find a way to connect with their favourite working environment. And there was no way around `GitHub`. It was all about **Fetch**ing, **Pull**ing, **Commit**ting and making **Pull Requests** to familiarise myself with the GitHub workflow. To do so, `Source Tree` and `Sublime Text` became part of my daily working environment.

We wanted to publish the API documentation online - no sooner said than done: one of our developers was very committed to support this project and built a `Jekyll`-based static html generation tool, to create documentation from markdown files.

One of the main requirements for our API documentation was to automatically import `RAML` files into the documentation tool, to easily bridge development and documentation and to avoid double work. To achieve this, he developed a Ruby-based open source library, the [raml_parser](https://github.com/ePages-de/raml_parser). The RamlParser reads raml files and returns the respective information. On top of that, he came up with a Jekyll plugin using the RamlParser to generate an API console that now enriches our documentation.

Meanwhile, I made myself familiar with RAML (RESTful API Modeling Language), which is a useful tool to describe RESTful APIs in a structured and simple way.
RAML allows to define simple patterns that help reduce repetitions in an API. Resources and methods can be displayed easily and filled with custom details. It also allows to include markdown-formatted descriptions or entire markdown documentation sections.

I’ve never come across all this in my previous TechWriter life, but noticed very soon that our inhouse documentation tool compared with simply editing markdown and raml files enriches my knowlegde and makes my work way more easy.

It really is a challenge to cope with so much new stuff, but I can totally recommend this way of working to every TechWriter.
