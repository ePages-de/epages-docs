---
layout: post
title: "ePages goes FullStack JavaScript conference"
date: "2016-07-19 14:00:00"
image: blog-header/javascript.png
categories: events
authors: ["Paolo"]
---

The Brexit is coming, the pound sterling is low, and my fellow colleague Erik and I took the opportunity to visit a conference in London ~~before we'll need a visa for that~~. It was called [_FullStack - the conference on JavaScript, Node & Internet of Things_][fullstack-website] and featured, among others, speakers from Google, Microsoft, and Facebook.
In this post, I want to share my key takeaways from three very intense conference days.

## 1. JavaScript is spreading out

{% imagecaption blog/blog-tessel.png %}
An LED sound level meter built within a few hours of JavaScript hacking.
{% endimagecaption %}

With JavaScript rapidly becoming a language to program the **Internet of Things (IoT)**, quite a few talks at the conference covered topics like remote controlling [bluetooth][bluetooth-talk] and [medical devices][pacemaker-talk], or [Virtual Reality][vr-talk]. In one of the workshops around minicomputers and microcontrollers, my colleague Erik hacked an LED sound level meter using Node.js on the [Tessel 2][tessel-website].

Naturally, in the IoT context **security** gains more importance, and I attended two interesting ~~advertisements~~ talks on [automated code vulnerability scanning][jacks-talk] with [Jacks][jacks-website] and [protecting your client-side JavaScript][jscrambler-talk] with [Jscrambler][jscrambler-website]. Both products provide convenient ways for developers to secure their JavaScript applications, without requiring an expertise in the domain of web application security.

## 2. React still has huge momentum

Just like the other conferences I attended in the last 12 months, _FullStack_ featured the canonical talk by a company that [moved from a monolithic [add your current technology here] application to a micro-service based system with a front-end powered by an isomorphic React & Redux app running on NodeJS][react-talk].

In total, there were around half a dozen talks around the [NodeJS][node]/[React][react]/[Redux][redux] stack that my team is using for building ePages' next generation frontend and website editor. One of the most interesting was by [Forbes Lindesay][forbes-twitter] from Facebook, who talked about [data fetching in React][react-data-fetching]. All in all there was plenty of opportunity to compare notes on that topic with other attendees from the very international audience.

## 3. This doesn't mean framework fragmentation is a thing of the past

{% imagecaption blog/blog-varnish.png %}
Can you spot the syntax error on the conference shirt?
{% endimagecaption %}

Of course there's enough space for other frameworks in the JavaScript world. [Angular 2][ng-2] was a big topic at _FullStack_, and after giving it a try in an intense workshop, I was left with the impression that the parts I liked most about it, namely [RxJS][rx-js] and [TypeScript][ts], are by Microsoft. But it's good to see that Angular 2 adds server side rendering or **Universal JavaScript**, and [Ember][ember] is getting that as well, as pointed out in a keynote by Ember co-creator [Yehuda Katz][yehuda-twitter].

JavaScript being JavaScript, there were of course many more framework ~~fights~~ talks, for instance about [Meteor][meteor], [Polymer][polymer], and [Riot][riot]. [Mark Rendle][mark-twitter] gave a humorous wrap-up to this topic in his closing talk ["The Things That I Like Are Superior To The Things That You Like"][mark-talk].


[fullstack-website]: https://skillsmatter.com/conferences/7278-fullstack-2016-the-conference-on-javascript-node-and-internet-of-things
[bluetooth-talk]: https://skillsmatter.com/skillscasts/8135-bluetooth-for-web-developers-programming-flying-robots-with-javascript
[pacemaker-talk]: https://skillsmatter.com/skillscasts/8133-the-bad-guys-have-your-pacemaker-how-to-stop-attacks-on-your-iot-devices)
[vr-talk]: https://skillsmatter.com/skillscasts/7922-in-your-face-vr-is-here-and-it-wants-to-play
[jacks-talk]: https://skillsmatter.com/skillscasts/8133-the-bad-guys-have-your-pacemaker-how-to-stop-attacks-on-your-iot-devices
[jacks-website]: https://jacks.codiscope.com/
[jscrambler-talk]: https://skillsmatter.com/skillscasts/8175-a-case-for-integrity-javascript-apps-should-have-it-too
[jscrambler-website]: https://jscrambler.com/
[tessel-website]: https://tessel.io/
[react-talk]: https://skillsmatter.com/skillscasts/8169-what-could-go-wrong-moving-80-million-users-to-react-redux-and-nodejs
[node]: https://nodejs.org/
[react]: https://facebook.github.io/react/
[redux]: http://redux.js.org/
[forbes-twitter]: https://twitter.com/forbeslindesay
[react-data-fetching]: https://skillsmatter.com/skillscasts/8543-keynote-data-fetching-in-react
[ng-2]: https://angular.io/
[rx-js]: https://github.com/Reactive-Extensions/RxJS
[ts]: https://www.typescriptlang.org/
[ember]: http://emberjs.com/
[yehuda-twitter]: https://twitter.com/wycats
[meteor]: https://www.meteor.com/
[polymer]: https://www.polymer-project.org/
[riot]: http://riotjs.com/
[mark-twitter]: https://twitter.com/markrendle
[mark-talk]: https://skillsmatter.com/skillscasts/7363-the-things-that-i-like-are-superior-to-the-things-that-you-like
