---
layout: post
title: "SoCraTes 2017 - Order is optional"
date: "2017-09-01 07:37:42"
image: blog-header/socrates-2017-header.jpg
categories: events
authors: ["Oliver Z."]
---

What happens if you gather approximately 250 people in one place for four days, provide them with shelter, food, and drinks?
They might play beach volleyball, teach music theory, jam, dance, explore stoicism, guide each other through our galaxy, play board games, perform magic tricks, improve their handwriting, talk about inclusion, and taste proper tea, and coffee.
If those people would additionally all care about well-crafted software, you might call this gathering a [**So**ftware **Cra**ftsmanship and **Tes**ting Conference](https://www.socrates-conference.de/).

# SoCraTes 2017

The SoCraTes is an open space (un-)conference, meaning there is no upfront agenda: All sessions are provided by the participants based on personal experience, preference, skills, and demand.
In the morning, sessions for the day are pitched, and the room-timeslot-matrix (see header image) is populated.
In the evening, everyone gathers again to recap the day, and share what they have learned.

This year's SoCraTes tried to be more inclusive, e.g. by providing gender-neutral bathrooms, and a field on the name tags for your preferred pronoun.

I am always impressed by the openness of the attendees, everyone is sociable, and there are plenty of capable people willing to mentor.
In this post I would like to share what I took home from the SoCraTes 2017.

## What I learned

As you can guess from the conference format, the SoCraTes experience is highly individual:
You cannot visit all sessions, and you are always free to switch sessions at any time ("Law of Two Feet").
Prior to the conference I identified topics I would be interested in.
Being more involved in our company's hiring process, I was really interested in how others interview candidates, on-board them, and handle project handovers.

### Fixing the Pair Programming Interview

Two sessions hosted by [Raimo Radczewski](https://twitter.com/rradczewski) addressed nearly all my needs.
In the first session on Friday we discussed how to improve pair programming interviews assuming no complex domain (e.g. application or web development).
My takeaways:

* Offer the candidate a choice between a pair programming session, or a take-home exercise.
* Before conducting the pair programming interview, write a detailed email to the candidate beforehand to introduce of yourself (the interviewer), explain the task, and list used frameworks.
Ask whether the candidate has any special needs (e.g. dietary restrictions), and describe the development environment/machine you are going to provide to the candidate in detail.
* A controversial point was whether we should ask a candidate to bring their own device.
Some would like to gauge the development setup of the candidate, but it also creates an additional hurdle.
We concluded that bringing your own device should be stated - if at all - as a secondary option.
* During the interview, try to make it a pleasant experience, and ask them beforehand if they feel fit enough to be interviewed (similar to an exam).
* Make sure the task is somewhat relevant to your day-to-day business or problem domain.
Some companies use a subset of the production code base.
Here at ePages we use [ePizza - a microservices hands-on tutorial](https://github.com/ePages-de/epizza).
* If you work on the production code during the interview, make the candidate DELETE the code after the interview!
This is to avoid any legal claims.
* The time frame for the pair programming interview should be one to two hours.
If you see the candidate suffers, stop the interview, and hiring process early.
* If you are interviewing for a senior position, the candidate should lead, point direction, ask questions, and communicate clearly.
* Avoid scam tasks or trick questions!
Do not grill the candidate!
But: play "devils advocate" once a while, the candidate needs to be able to reason their decisions.
* If you see the candidate struggles, offer to lower bar, e.g. by applying junior instead intermediate level criteria.
* After the interview have a retro with the candidate, ask for feedback, and give feedback!
You might want to offer a private, non-company-related communication channel, too.

### The Medium interview handbook

In the second session on Saturday we dissected [Medium's interview handbook](https://medium.engineering/mediums-engineering-interview-process-b8d6b67927c4) with a focus on the [grading criteria](https://medium.engineering/engineering-interviews-grading-rubric-8b409bec021f).
While we found some weak spots of this manual, it is still an incredible resource that helps you assess a candidate's fit.

### Oh, it's about software development and technology, too

A SoCraTes is always a great place to level up your TDD, design, and mob programming skills practicing katas.
Playing the [Mob Programming RPG by Willem Larsen](https://github.com/willemlarsen/mobprogrammingrpg/) with a fizzbuzz kata we learned good mob programming behavior, and pairing practices.
For maximum effect, make some sound like "KAAASHINGG" when leveling up as an indicator to the group, that your behavior was beneficial.
Laughs included.

Obviously, there were Vim vs. Emacs bashes (or [fish](https://fishshell.com/)es?).
Vim clearly won this time around.
I was able to share knowledge I gained at university in a session about compilers, explaining the basic steps of language processing, grammars, and syntax trees.

Also a talk about the BEAM virtual machine (VM), the Erlang/Elixir/LFE runtime, by [Jan Stępień](https://twitter.com/janstepien) drew my attention.
Actually the BEAM VM is more like an operating system than a runtime: It prioritizes processes (Erlang functions), and assigns them to schedulers.
Inter-process communication happens via messages in [Erlang](https://www.erlang.org/).
Those are copied from the source to the target process, no memory is shared.
The VM's failure recovery mechanism can be used to strictly separate business logic from exceptional state handling as well as to control program flow in a distributed computing environment.
Linked processes get killed, if just one of the linked processes dies (this also applies transitively).
Supervisors can then restart killed processes, if needed, thus gracefully handling, and recovering non-happy-path executions.

One gem was saved for last: On Sunday [Xavier Detant](https://twitter.com/xdetant?lang=en) gave an excellent [introduction to functional programming](https://github.com/FaustXVI/functional-programming-introduction/tree/playing), transforming an imperative program to a functional one, step by step, eventually deriving a valid Haskell program from the original JavaScript source code ("Haskell is just some syntactic sugar for JavaScript").
If you want to replay the steps taken during the talk, switch to the `playing` branch and check the commits.

## Reduce(notes)(essence)

I filled pages with notes, and tapped into invaluable experiences of other attendees.
I built my first Personal Kanban board from paper at this year's SoCraTes.
After learning the advantages of a physical board, I am keen on building a more robust one from plates of plastic, and making use of it:
Moving "Blogpost SoCraTes 2017" from *Doing* to *Done Today*.

### Further links

* [Gabriel Birke's SoCraTes 2017 Notes](https://lebenplusplus.de/2017/08/27/impressions-from-socrates-2017/)
* Header image courtesy of [Jason Peper](https://www.flickr.com/photos/jason_peper/36632713242/)
