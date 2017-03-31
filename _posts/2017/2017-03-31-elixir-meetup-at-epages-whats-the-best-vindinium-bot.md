---
layout: post
title: "Elixir Meetup at ePages: What's the best vindinium bot?"
date: "2017-03-31 06:39:20"
image: blog-header/elixir.jpg
categories: events
authors: ["Rose"]
---
<style>
.twitter-tweet {
  margin: auto;
}
</style>

This Tuesday, the second part of the [hh.ex vindinium challenge](https://www.meetup.com/de-DE/Elixir-Hamburg/events/238421135/?eventId=238421135) took place in the [ePages](https://www.epages.com/en/) office in Hamburg.
Despite the amazing weather conditions outside, there were quite a few [Elixir](http://elixir-lang.org/) and [vindinium](http://vindinium.org/) interested developers to join the meetup.

## Programming a semi static blog engine with Elixir

The event started off with a presentation about a side project of our developer Erik.
He presented his semi static blog engine "Jelly Shot".

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/Air2ick">@Air2ick</a> presents his semi static blogengine <a href="https://twitter.com/hashtag/JellyShot?src=hash">#JellyShot</a> with <a href="https://twitter.com/elixirlang">@elixirlang</a> <a href="https://twitter.com/HamburgEx">@HamburgEx</a> <a href="https://twitter.com/hashtag/meetup?src=hash">#meetup</a> <a href="https://twitter.com/hashtag/hamburg?src=hash">#hamburg</a> cc/ <a href="https://twitter.com/epagesdevs">@epagesdevs</a></p>&mdash; harm (@netzfisch) <a href="https://twitter.com/netzfisch/status/846769010389798912">March 28, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

The idea to set up this blog engine came up, because for him, working with the static site generator [Jekyll](https://jekyllrb.com/) often takes up too much time.
Motivated by this experience, he thought it couldn't be too difficult to write his own blog engine.
And he was absolutely right!

His blog project Jelly Shot uses the web framework [Phoenix](http://www.phoenixframework.org/) and is written in [Elixir](http://elixir-lang.org/).
Unlike other blog systems, Jelly Shot has no access to databases nor uses static file generation, but stores data in its memory.
The `Agent`, a simple state abstraction, administers all data and is able to filter, delete, or replace parts of it - and this at a much faster pace.

Check out Erik's [repository](https://github.com/erikmueller/jelly_shot) for more information!

## The grand hh.ex vindinium challenge tournament

After a short break to charge the batteries with some snacks and drinks, everyone was ready to join or watch the vindinium show.
Vindinium is an Artificial Intelligence programming challenge, in which the players take control over a legendary hero fighting for the land of Vindinium using their favorite programming language.
In this case, there were three competitors who programmed their heroes with Elixir.
The forth player was a random bot.
The participants got really engaged with the four legendary heroes slashing goblins and stealing gold mines.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/epagesdevs">@epagesdevs</a> <a href="https://twitter.com/elixirlang">@elixirlang</a> <a href="https://twitter.com/HamburgEx">@HamburgEx</a> <a href="https://twitter.com/Air2ick">@Air2ick</a> <a href="https://twitter.com/h4cc">@h4cc</a> <a href="https://twitter.com/hashtag/guys?src=hash">#guys</a> playing and having fun like <a href="https://twitter.com/hashtag/kids?src=hash">#kids</a> :-)</p>&mdash; harm (@netzfisch) <a href="https://twitter.com/netzfisch/status/846787780357341186">March 28, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Everyone watched the screen with excitement to see which of the players would collect the most gold to win the game.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">And the winner iiiiis: <a href="https://twitter.com/h4cc">@h4cc</a> :) <a href="https://twitter.com/hashtag/elixirlang?src=hash">#elixirlang</a> <a href="https://twitter.com/hashtag/vindinium?src=hash">#vindinium</a> <a href="https://t.co/uHkPTDbhkb">pic.twitter.com/uHkPTDbhkb</a></p>&mdash; ePages Developers (@epagesdevs) <a href="https://twitter.com/epagesdevs/status/846788530403774467">March 28, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

The meetup itself was a great way to spark discussions on the participants' experiences and challenges with Elixir.
It was a great evening and we were happy to host the Elixir Meetup Hamburg again.
