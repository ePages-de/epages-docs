---
layout: post
title: "A coffee with the CTO of ePages"
date: "2017-01-12 06:11:00"
image: blog-header/cto-coffee.jpg
categories: working-at-epages
authors: ["Rose", "Harm"]
---

[Harm Behrens](https://archive.epages.com/de/unternehmen/newsroom/news/Harm-Behrens-ist-neuer-CTO-bei-ePages.php) joined [ePages](https://www.epages.com/) as CTO in September 2014.
Ever since ePages benefits from Harm's over 15 years of expertise in the field of development and operation of extensive web and mobile applications.
In this interview, Harm talks about the next generation commerce platform, his daily coffee ration as well as his focus on people, the product portfolio, and development technologies.

### Harm, you have been working at ePages for more than two years now. Back then, you were hired to take charge of the advancement of the ePages software. What has happened in these two years?

Quite a lot.
It's true that I've been hired to push forward our existing software stack.
But the scope of my work is much broader than that.

First it was mainly about refining, enhancing, and adding value to our current core shop software ePages 6, but then it changed to lay out the foundation of our very latest backend architecture ePages BEYOND.
Furthermore, we had to hire a lot of developers and established a new development location in Hamburg.

ePages 6 is our very first and core product, which has a wide range of features and functionalities that our customers highly appreciate.
Over the past two years, we extended and enhanced ePages 6 with the [REST API](https://developer.epages.com/apps), which consequently allowed us to facilitate an [App Store](https://blog.epages.com/us/2016/05/14/the-epages-app-store-everything-for-your-e-commerce-success/) as well as a [Theme Store](https://themes.epages.com/en/).
Only then, we integrated the new storefront [ePages Now](https://www.epages.com/sell-online/now/) through the [REST API](https://developer.epages.com/apps) and launched the beta phase by the end of last year.

### How did you come up with the idea of ePages Now - a product with improved usability?

Actually ePages Now was an existing idea, even before I started at ePages.
In this respect, it is not my solely own creation.
However, I then took over the responsibility to further improve and align the goals of the ePages Now project.

Now it is basically a new "state of the art" storefront considering responsiveness and a variety of themes with import-/export functionality.
Furthermore, a modernized usability of the administration area allows the merchant to arrange items by drag and drop, as for example, content pages, landing pages, and alike.
Yet, the shop software is still based on the ePages 6 architecture.

But before we could really get started with that, we had to scale our resources.

### Tell me about that.

Well, shortly before I joined, the company went through a reorganization from a rather waterfall oriented development cycle to an agile approach {% emoji smile %}, and furthermore, we did not have enough developers to fulfill our ambitious product plans.

So, on the one side I had to restructure some teams and determine their focus.
On the other side, we established a new developer location in Hamburg, which in fact lead to another primary tasks since 2014: Recruiting developers to assure the development of ePages Now, i.e. the new fronted and administration area as well as to start with our new e-commerce platform ePages BEYOND.

Consequently, we now have several development teams dedicating their work to focus on ePages 6, ePages Now, and ePages BEYOND.

### What are the goals of ePages BEYOND?

Our new backend architecture pursues three main goals:

1. Support development on the product in distributed teams.
2. Create an architecture that is easy to change and to maintain.
3. Focus on the Java ecosystem with an up-to-date technology stack.

This resulted in a [microservices-](https://en.wikipedia.org/wiki/Microservices)based architecture with modern technologies such as [Docker](https://www.docker.com), [Kubernetes](http://kubernetes.io/), [Java](https://www.java.com/en/), [Spring Boot](https://projects.spring.io/spring-boot/), and alike.
Besides continually evolving BEYOND, we also created a blueprint approach in order to scale microservice development across teams and our different locations Barcelona, Jena and Hamburg.

This cuts down complexity, and thus makes it easier for existing teams to work on the project.

### Where does the development of ePages BEYOND stand today and what are you heading for?

We have two teams in two locations which already developed a first end-to-end prototype.
Our objective is to finish that by the end of February 2017.

One point that is still pending but very important to me, is a completely automated delivery pipeline to ensure that code changes are deployed live quickly.
It's basically about finding a way to easily and timely release changes - this then means only a few code lines instead of plenty.

Consequently, it also becomes more easy to roll-out new features, and if any, to identify and fix bugs immediately.
Creating this automation process is what we're currently aiming for and where we get great support by our Application Management team and their experience.

In contrast to the past we will also favor deployment in the cloud.
It remarkably facilitates scalability and reduces time to market.
This way, Sales and Business Development can present the fully fledged product and/or new features much earlier to our customers.

You see, we always strive forward.

### Besides these new software platforms, what else are you responsible for?

As already mentioned, my daily work consists of quite a lot of human resources work.
We place great value on finding the right employees and establishing a corresponding culture.
We cherish a company culture that employs great people, that has an international working atmosphere, and that challenges our employees.

I receive great support from HR in this regard.
Together, we redesigned the whole process of tech recruiting at ePages.
For instance, potential candidates have to solve a small coding challenges in advance.
This way, we get a first impression about their skills.

During the whole recruiting process, the future team colleagues are closely involved.
This is because we want to avoid possible impacts on other team members, which might ultimately decrease quality and productivity of the overall team.
We always like to get to know the candidates in person to see whether the interpersonal aspect fits as well.
And of course the candidates should get to know us.
During this probation day team members and candidate do a pair-programming session on real tasks to get a good impression on the skill set and to introduce them to our software stack.

All in all, we reduced a lot of uncertainties with this improved recruiting process.

### Certainly there is more...?

Well yes.
I introduced our [epagesdevs](https://twitter.com/epagesdevs) Twitter channel and pushed for the implementation of a developer blog, as I noticed the lack of employer branding in the community.
The teams alternate every month with writing tech stories that are related to their work. They use the markdown structure and [git](https://git-scm.com/) and do pull requests on [GitHub](https://github.com/) which are then reviewed by our [technical writer](https://developer.epages.com/blog/2016/11/30/what-its-like-to-be-an-agile-technical-writer.html).
This way, and by using [Jekyll](http://jekyllrb.com/) as a static blog engine, we integrated the blogging workflow into the developers' familiar work environment, which increased their motivation and contribution ratio to the blog a lot.

### What does your typical working day look like?

In the morning I usually cycle to work.
I always enjoy the bike ride along the beautiful Elbe to distract myself.
When arriving at ePages, I go through all offices saying "Hi" to everyone and eventually quickly clarify pending tasks or uncertainties.
Then I check new emails and try to attend as many [team reviews](https://developer.epages.com/blog/2015/12/15/scrum-basics-scrum-meetings.html) as possible during the day, even if it's from remote.

Furthermore, I attempt to keep myself up-to-date on the latest technology trends, and news.
I regularly have dedicated meetings concerning various technology approaches as well as lunch with different teams.
My office door is always open to ensure that everyone can proactively approach me with ideas, concerns, or whatsoever ... and "whatsoever" can also eat up a lot of time {% emoji angry %}.

I am in permanent exchange with HR and my colleague who is in charge of the development teams in Jena.
Therefore, I also try to visit the office in Jena every two months and in Barcelona every four months.

Hmmm, and I don't want to forget to mention the many Latte Macchiatos I have throughout the day {% emoji wink %}.

### What are the most important aspects when working with different development teams?

Open and honest communication!
I appreciate it a lot if employees approach me to make suggestions for further proceedings, changes, and improvements.
Sometimes it's challenging to immerse myself into all subject areas with the same attention.
The development teams that work on their tasks day-to-day often have a deeper understanding of challenges in their working area, and thus can make hands-on proposals.
This is also what I expect from the teams: to work autonomously, take on responsibility, and be self-organized.

### Which programming languages and technologies do you mainly work with?

Last year I would have said still a lot of Perl - simply because that's the code base of ePages 6, but now there are more modern technologies involved.
This change is due to switching to ePages Now and BEYOND.
The new storefront and editor uses modern Javascript libraries such as [Node.js](https://nodejs.org) and [React](https://facebook.github.io/react/).
We use Java and [Spring Boot](https://projects.spring.io/spring-boot/) for our new microservices, as well as API and [Elastic Search](https://www.elastic.co/) for the search-driven shop.
For supporting tools we use [Ruby](https://www.ruby-lang.org/en/) and [Rails](http://rubyonrails.org/).

### What do you like most about ePages?

ePages allows  everyone to proactively contribute and shape the topics we deal with.
One can work autonomously and with great responsibility.
The company culture creates a friendly and collaborative atmosphere - people enjoy working at ePages.
Personally, I think I could have a chat over a beer with every single ePagee.
I simply enjoy being in the office and around my colleagues.

### Can you give me a future outlook on what will happen next?

This year's challenge will be a shift of more resources to the new backend architecture of BEYOND.
Also, we have to assert our position in the US market.

### Thanks Harm, for the interview. It was very insightful chatting with you.
