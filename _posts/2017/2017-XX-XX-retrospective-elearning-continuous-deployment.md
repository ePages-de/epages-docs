---
layout: post
title: "Retrospective for Continuous Deployment E-Learning Course"
date: "2017-XX-XX 07:00:00"
image: XXX
categories: tech-stories
authors: ["Jan"]
---

# Introduction

Currently we are releasing new versions of the ePages shop system every three weeks. The update scripts are adjusted for the different providers and then installed with Capistrano (See [Implementing Capistrano as Configuration Management Tool](https://developer.epages.com/blog/2016/03/30/implementing-capistrano-as-configuration-management-tool.html)) by our Application Management team with zero downtime (See [Online Schema Updates with MySQL](https://developer.epages.com/blog/2016/03/08/online-schema-updates-with-mysql.html)). For our new product we want to take this a step further by including the deployment on the production system into the definition of done for a user story. As I was involved in the creation of the first draft of the process definition I got the e-learning course [Continuous Deployment](https://elearning.industriallogic.com/gh/submit?Action=AlbumContentsAction&album=continuousDeployment&devLanguage=Python) from Industrial Logic approved as professional training. My target was to derive some inspiration for our new process.

# Contents of the Course

The course is a series of 144 slides. They cover all the toppics involved in automatically deploying the changes to the production system after a commit in the version control. The description of the different techiques was rounded up with little comic stories.

Another element of the course were practical excercises. By the push on a button an AWS instance has been fired up which contained a simple Python/Django web application, Jenkins CI server and SVN repository. The excercises were done with test-driven development. After the activation of an exercise there were failing test. The tasks covered extending Selenium tests, doing zero-downtime database updates and the implementation of a coupon code feature with feature toogles.

Furter, there were many multiple choice quizzes. The answers contained statistics about how the other students answered. There were also two very short videos.

# Advantages

- The practical excercises are a very nice idea. After the completion of the course I have a gram of experience with things I have before only read about, e.g. feature toggles.
- It costs about six times less than a comparable on-site training while there are similar or maybe better learnings.
- The advantage of this e-learning course over related books and video series is that they give
- The course is easier digestable than a book and its faster to work throught it. Thus it's easier to find the time to work through it during office hours.
- The advantage over video series is that it not necessary to take notes about everything and then rework the notes for later reference.

# Disadvantes

- Even tough if I have official approval for training during work hours, it is impossible to find the time to do the excercises in office. I had to do this on train journeys and at home.
- Lots of the ideas were not yet applicable in our specific situation.
- As Python/Django is not our technology stack, wrapping my head around our Kubernetes deployment process is still a challenge for me.
- There could be more focus on the videos. They could be longer and more often be used as medium to describe complex.

# Conclusion

The attendance of the e-learning course did not pay off yet. The initial stages of our deployment pipeline are already covered by [the Continuous Delivery book](https://martinfowler.com/books/continuousDelivery.html). However, I still recommend this learning stlye and also this specific course. It improved my understanding of the subject and will also serve as source for new improvement ideas for our continiuous delivery pipeline.
