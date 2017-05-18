---
layout: post
title: "The pros and cons of an e-learning course about continuous deployment"
date: "2017-05-11 07:00:00"
image: blog-header/learning.jpg
categories: tech-stories
authors: ["Jan"]
---

New versions of our ePages software are currently released every three weeks.
The update scripts are adjusted for the different providers and then installed with [Capistrano](https://developer.epages.com/blog/2016/03/30/implementing-capistrano-as-configuration-management-tool.html) by our [Application Management team with zero downtime](https://developer.epages.com/blog/2016/03/08/online-schema-updates-with-mysql.html).
For our new product we'd like to take this a step further by including the deployment on the production system into the definition of done for a user story.
As I was involved in the creation of the first draft of the process definition I took the e-learning course [Continuous Deployment](https://elearning.industriallogic.com/gh/submit?Action=AlbumContentsAction&album=continuousDeployment&devLanguage=Python) from Industrial Logic to educate myself further in this area.
My target was to derive some inspiration for our new process.

## Scope of the course

The course is a series of 144 slides.
It covers all the topics involved in automatically deploying the changes to the production system after a commit in the version control.
The description of the different techniques was rounded up with little comic stories.

In addition to that, the course had practical exercises.
By pushing a button an AWS instance was fired up which contained a simple Python/Django web application, Jenkins CI server, and SVN repository.
The exercises were done with test-driven development.
After the activation of an exercise there were failing tests.
The tasks covered extended Selenium tests, zero-downtime database updates and the implementation of a coupon code feature with feature toggles.

Furthermore, there were many multiple choice quizzes.
The answers contained statistics about other participant's answers.
There were also two very short videos.

## Pros

* The practical exercises are a very nice idea.
After completing the course I have new experience with things I only read about before, e.g. feature toggles.
* It costs about six times less than a comparable on-site training while there are similar or maybe better learnings.
* The course is easier to digest than a book and faster to work through it.
Thus it's easier to find the time to work through it during office hours.
* It is not necessary to take notes about everything and then rework the notes for later reference.

## Cons

* Even though I had the official approval for training during working hours, it is impossible to find the time to do the exercises in the office.
I had to find other time slots to do the course.
* Lots of the examples were not yet applicable for our specific situation.
* As Python/Django is not our technology stack, wrapping my head around our Kubernetes deployment process is still a challenge for me.
* More focus on the videos would have been nice.
Longer and more frequent videos would have helped to describe complex matters.

## Conclusion

The attendance of the e-learning course did not pay off yet.
The initial stages of our deployment pipeline are already covered by [the Continuous Delivery book](https://martinfowler.com/books/continuousDelivery.html).
However, I still recommend this learning approach and also this specific course.
It improved my understanding of the subject and will also serve as a source for new improvement ideas for our continuous delivery pipeline.
