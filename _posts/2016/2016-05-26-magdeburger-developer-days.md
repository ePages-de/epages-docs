---
layout: post
title: "Magdeburger Developer Days"
date: "2016-05-26 08:30:20"
image: blog-header/magdeburg-dev.jpg
categories: events
authors: ["Bastian and Benjamin"]
---

On May, 18th 2016, the first [Developer Days](http://md-devdays.de/) took place in the exhibition halls of Magdeburg, Germany.
Although this Java and .NET developer conference was organised for the first time, many developers from across Germany participated and followed the invitation from the [Twitter](https://twitter.com/MiB_MD_DevDays) channel of Michael Blume, the initiator and organiser.

{% image blog/blog-magdeburg-1.jpg %}

## The setting

The exhibition hall was parted into four large rooms, named after famous pioneers of the Information Technologies, like [Konrad Zuse](https://en.wikipedia.org/wiki/Konrad_Zuse) and [Bjarne Stroustrup](https://en.wikipedia.org/wiki/Bjarne_Stroustrup).
The lobby offered bar tables and an open space that could consistently be used for interesting discussions about the latest technologies, side projects, and networking.
Besides the catering with snacks and a variety of beverages, the orga team also delivered a conference booklet with over 40 pages, where each speaker and session was listed in depth on individual pages.
Another noteworthy subject was the affectionate designed certificates for the participants that were handed over at the entrance area in addition to the welcome bag.

{% image blog/blog-magdeburg-2.jpg %}

## The sessions

After the two introduction talks, the sessions began. The main topics were frontend and backend technologies, as well as a mixture of agile topics, requirements documentation, and programming technologies.

{% image blog/blog-magdeburg-3.jpg %}

The first session was a dive into [TypeScript](https://www.typescriptlang.org) by Rainer Stropek.
TypeScript is a JavaScript similar language and can be compiled into JavaScript.
It is a strictly typed and object-oriented programming language.
We learned how to compile and use TypeScript.
Rainer Stropek showed examples via live coding at the TypeScript [Playground](https://www.typescriptlang.org/play/index.html), which directly generates the resulting JavaScript.
He also showed how to use common JS libraries within TypeScript.

{% image blog/blog-magdeburg-4.jpg %}

Our second session was all about "What's still new in [Java SE 8](https://docs.oracle.com/javase/8/docs/api)?".
Bernd Gronostay, who works closely together with the author of "Java ist auch ein Insel", talked about a lot of new features and API changes.
Not only did he talk about the modifications, but also showed a lot of examples which illustrated these features very well.
The perhaps most interesting part in this session were the various show cases of lambda functions and streams.
This enables developers to write Java in a functional syntax.

{% image blog/blog-magdeburg-5.jpg %}

After lunch there was a talk with a topic which was completely new to us:
Functional Domain Driven Design (DDD) with F# held by Marco Heimeshoff.
He is one of the cofounders of the [DDD community](http://dddcommunity.org) in Germany.
His introduction showed a new idea of how the software models should look like.
The mapping between the Requirement Space (Domain) and the Implementation Space (Code) is usually a gap that needs to be bridged.
The difficulty is to have the code representing exactly the real domain.
But often developers have to check that there is no possibility to represent an illegal state.
The simple solution with DDD is: Make illegal states unrepresentable!
This is only a little extract of this session with a lot of new, interesting ideas and patterns for solving things in a deterministically different way that makes intense unit testing obsolete.

{% image blog/blog-magdeburg-6.jpg %}

The next session was an introduction into the JavaScript framework [React](https://facebook.github.io/react) by Oliver Zeigermann, who is the author of several JavaScript books.
He showed and explained the principals of React.
One feature of React is that it reperesents only the View in a Model-View-Controller (MVC) model.
So it is typical to have a mixture of JavaScript and HTML code in one file.
Another feature is that the Document Object Model (DOM) tree is virtualized.
That means, when a webpage flow is establihed only the objects that have change are updated via the calculation of a `diff` between the webpage states.
The interesting thing about React is, that due to that technique websites are always very fast.

{% image blog/blog-magdeburg-7.jpg %}

The last session of the day was "Architekturdokumentation leicht gemacht" (architecture documentation for dummies) by Andreas Richter, the organiser of the [Softwerkskammer Magdeburg](https://www.softwerkskammer.org/groups/magdeburg).
He introduced the [arc42](http://arc42.org) template and its most important parts.
The main benefits of such an architectural templates is that there is always the same structure.

## Summary

The Magdeburger Developer Days offered a lot of very interesting talks in a broad range of topics.
We were stunned from the professionel level that orga team could establish.
The speakers were well-choosen and the quality of talks was absolutely extraordinary.
The experience of the conference was very great and a visit next year is definitely reasonable.
