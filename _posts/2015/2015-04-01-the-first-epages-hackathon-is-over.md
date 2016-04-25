---
layout: post
title: "The first ePages hackathon is over"
date: "2015-04-01 12:00:00"
categories: events
authors: ["Anja", "Birgit"]
---

**2 days - 50 ePagees - 8 teams.** On March 24 and 25, 2015 all signs in the ePages Jena office pointed to exploratory programming.

The rules were simple:

<ul class="fa-ul">
  <li><i class="fa-li fa fa-thumb-tack"></i>Work on a solution for something that bothers in daily work, is time consuming or even would make our work life easier.</li>
  <li><i class="fa-li fa fa-thumb-tack"></i>Achievable in two days.</li>
  <li><i class="fa-li fa fa-thumb-tack"></i>Developed in cross-functional teams.</li>
</ul>

After two days of "blood, sweat, tears" and lots of fun, we had awesome results:

* Team 1 - Prototype for an interactive administration area guide:
In order to develop a prototype for an interactive administration area guide, the team first tested two different frameworks. After finishing the tests, they came up with a pretty good solution guiding a customer through the administration area to create a product.

* Team 2 - Help yourself with Sublime Editor:
Many team members use Sublime Editor in their daily business. But as the support for Windows has been cut off, the team developed timesaving extensions and plugins itself.

* Team 3 - Replace ArgoUML with an easier tool:
ArgoUML is hard and time-consuming to use. The team's goal was to find an easier tool for creating database models. Split up in two groups, one group fixed the erros in the existing database models and remodeled them in a new modelling language. The other group pushed the results in an eclipse update site/repository and created an eclipse plugin. Every ePages developer can use this solution in future for database modelling.

* Team 4 - Implement Circuit Breaker software:
ePages applications become more and more distributed, but currently highly depend from each other. It's like a house with several rooms: if one room has an energy overload, the circuit breaker trips, shuts down the energy for this room, but keeps the rest of the house safe and running. At ePages, currently a problem in one "room" could shut down the whole "house".
The team implemented an existing Circuit Breaker software to avoid that a problem of one applicaton affects the rest of the software.

* Team 5 - Increase company culture:
This team used the hackathon to build a Pong Game. A game takes only two minutes and is ideal for a short pause for reflection. The team members not only achieved to build the game, but learned a lot from each other during the project.

* Team 6 - Hush! Top secret stuff.

* Team 7 - Evaluate Gradle as professional Build-Management-System:
The old language pack build process was quite time-consuming and required lots of manual work. The team managed to proof that Gradle would work for ePages and could save a lot of time. Some manual steps of the language pack build process have already been automated.

* Team 8 - Evaluating Docker to optimise resource consumption:
ePages runs automated acceptance tests with a Selenium Framework against a great number of ePages installations. This requires a significant amount of server resources. The team had to face quite some challenges and worked hard to solve them. But at the end, they managed to run the tests with Docker. Yay!

The team spirit throughout R&D was fantastic. ePagees from Hamburg, Jena, Barcelona (and even New York participated via Skype) worked in crossfunctional teams and had a great time together!

Looking forward to the next ePages hackathon!
