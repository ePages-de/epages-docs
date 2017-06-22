---
layout: post
title: "What is buzzing in Berlin 2017?"
date: "2017-06-22 09:30:00"
image: blog-header/berlin-buzzwords-2017.jpg
categories: events
authors: ["Jens"]
---

<style>

.twitter-tweet {
  margin: auto;
}
</style>

For the 8th time the [Berlin Buzzwords](https://berlinbuzzwords.de/17/) conference took place at Berlin's Kulturbrauerei, offering more than 60 talks that covered topics related to search, store, scale, and stream.
Especially the track dedicated to search caught my interest, since it is closely related to the [Elasticsearch](https://www.elastic.co/) technology that my team uses to implement the functionality of the product microservice in our new ePages software.

## Some introductory remarks

The conference started on a very nice Sunday with a barcamp, and about 70 participants attended to enjoy a number of self-organized sessions.
It was a very comfortable way to get to know your "birds of a feather" and start digging into the topics that would follow the next two days.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Lovely weather in Berlin – Join us for our barcamp today @ Palais Atelier starting at 3 (registration from 2) <a href="https://t.co/yWYpKcoYHi">https://t.co/yWYpKcoYHi</a> <a href="https://twitter.com/hashtag/bbuzz?src=hash">#bbuzz</a> <a href="https://t.co/ZllcNHs1wc">pic.twitter.com/ZllcNHs1wc</a></p>&mdash; Berlin Buzzwords (@berlinbuzzwords) <a href="https://twitter.com/berlinbuzzwords/status/873869570704109568">June 11, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Karen Sandler opened the first day of conference talks with a topic that was equally relevant to all 550 conference visitors: [Free and Open Source software today](https://berlinbuzzwords.de/17/session/keynote-free-and-open-source-software-today-kino).
It was really alerting when she talked about her unsuccessful attempts of getting access to the source code of the software running on her implanted heart defibrillator, just to suffer from electrical shocks being falsely applied to her during pregnancy!

## Learning to rank

Many of the following talks from the search track were dealing with Machine Learning techniques to improve the quality of search results, also known as "[learning to rank](https://en.wikipedia.org/wiki/Learning_to_rank)".

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Most mentioned phrase I heard at <a href="https://twitter.com/hashtag/bbuzz?src=hash">#bbuzz</a> so far: “learning to rank” <a href="https://t.co/P9mSAeanTL">https://t.co/P9mSAeanTL</a></p>&mdash; Jens Fischer (@jensfischerhh) <a href="https://twitter.com/jensfischerhh/status/874614871421313024">June 13, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

This is a very advanced topic in search technology and companies like [Bloomberg](https://berlinbuzzwords.de/17/session/apache-solr-learning-rank-win), [Snagajob](https://berlinbuzzwords.de/17/session/we-built-elasticsearch-learning-rank-plugin-then-came-hard-part), [Textkernel](https://berlinbuzzwords.de/17/session/learning-rank-faceted-search-bridging-gap-between-theory-and-practice), and [Zalando](https://berlinbuzzwords.de/17/session/modern-architecture-search) were able to tell their lessons learned from introducing these optimizations into their systems.
All of them already could benefit from years of experience tuning their search and made significant investments to achieve the next level of search quality by introducing Machine Learning.

## Takeaway

Our new ePages software still can benefit from tuning its search algorithm using more mundane optimizations like [query time boosting](https://www.elastic.co/guide/en/elasticsearch/guide/current/query-time-boosting.html).
One insight from Berlin Buzzwords for me was, that you need to introduce a way of measuring the quality of your search results prior to adjusting the algorithm.
Only then you are able to judge if an optimization was really for the better.
And especially due the very heterogenous assortments of our merchants, any change in the search algorithm that affects one merchant's assortment in a positive way, could negatively affect all the other merchants.
Tuning your search algorithm is a highly iterative process that requires constant inspection and adaption - and that is what we support by working in an agile process.
