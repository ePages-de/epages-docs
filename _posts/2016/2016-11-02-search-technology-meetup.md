---
layout: post
title: "Interesting insights from the Search Technology Meetup VI"
date: "2016-11-02 09:00:00"
image: blog-header/search.jpg
categories: events
authors: ["Rose"]
---

<style>
.twitter-tweet {
   margin: auto;
}
</style>

Last Friday, we hosted the seventh edition of the Search Technology Meetup Hamburg organized by [Shopping24](https://www.shopping24.de) in our new office in Holstenwall 5.
The room was packed and participants from all kinds of backgrounds engaged in discussions with the invited speakers even before the presentations started.
Next to some snacks and refreshing drinks, we then saw two brilliant talks on search architecture and how to use statistical as well as machine learning models for improving search.

Therefore, [Miguel Olivares](https://twitter.com/moliware) and Christian Würtz from [Xing](https://www.xing.com/) as well as Data Scientist [Andrew Clegg](https://twitter.com/andrew_clegg) from [Etsy](https://www.etsy.com/) gave us interesting insights into their search technology infrastructure, respectively.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">The room is packed and listening to <a href="https://twitter.com/andrew_clegg">@andrew_clegg</a>! The <a href="https://twitter.com/hashtag/search?src=hash">#search</a> community is in fire in <a href="https://twitter.com/hashtag/hamburg?src=hash">#hamburg</a> at <a href="https://twitter.com/hashtag/stmhh?src=hash">#stmhh</a>. Thanks for joining us! <a href="https://t.co/1j402flFF7">pic.twitter.com/1j402flFF7</a></p>&mdash; Search Tech Meetup (@stmhamburg) <a href="https://twitter.com/stmhamburg/status/792067869114851328">October 28, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## Evolution of search at Xing

At the social networking site for professionals, Xing, the search infrastructure plays a mayor role - from simple full text search up to an internal geo location service.
The speakers explained how they evolutionized Xing's search arquitecture and how they solved arising challenges in order to create their current infrastructure.
Xing developers put special emphasis on the enhancement of phonetic search to boost the search results, even if users misspell names.
Also, they improved the categorization of job ads.
Thus, if users search for the English job ad or the German one for Software Developer or "Entwickler", respectively, they are now unified and result in the same search outcome, which contributes to the improvement of qualitative search.

Furthermore, Xing developed as a service solution to what they call "search as a service ", since they offer a platform not only to search for business contacts or jobs, yet also they provide auto-suggestions based on one's personal network and geo location, etc.
A technology that considerably contributed to Xing's success was the Lucene-based search engine [Elasticsearch](https://www.elastic.co/de/products/elasticsearch).

## Search meets Data Science at Etsy

In his talk, Data Scientist Andrew Clegg introduced to us the challenges Etsy.com, the marketplace for unique items and creative goods, faces with regards to search and recommendation due to the variety in inventory.
The uniqueness of many of the offered items on Etsy's marketplace adds on to this difficulty.
The Data Science team at Etsy, as part of the broader Search Science Group, consequently dedicates its work towards improving the outcome of items that people will love and works at the intersection of search and machine learning.
Andrew Clegg, thus, introduced Etsy's search technology stack and ran through a few remarkable and humorous examples that showed how Etsy was able to improve the search by using statistical and machine learning models.
Andrew pointed out how challenging it can be to bring together search engineering and machine learning, since dealing with taxonomies surely is a well-known concept for search engineers, yet not so much for data scientists.
Consequently, it is crucial to consider semantic similarity concepts.
He therefore presented some use cases and how to measure similarity.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Big shout out to <a href="https://twitter.com/DataconomyMedia">@DataconomyMedia</a> and <a href="https://twitter.com/DataNativesConf">@DataNativesConf</a> in Berlin, and <a href="https://twitter.com/stmhamburg">@stmhamburg</a> and <a href="https://twitter.com/epagesdevs">@epagesdevs</a> in Hamburg. 3 talks in 2 cities in 1 day 🏆</p>&mdash; Andrew Clegg (@andrew_clegg) <a href="https://twitter.com/andrew_clegg/status/792123572781285376">October 28, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

For further insights, and to see which method Andrew considers best to measure semantic similarity, check out his [presentation](http://www.andrewclegg.org/Talks.html).

So again, many thanks to everyone who attended, to the speakers and of course the organizers.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Thanks <a href="https://twitter.com/stmhamburg">@stmhamburg</a> for organizing this great event! It was such a pleasure to be hosting it! <a href="https://twitter.com/hashtag/stmhh?src=hash">#stmhh</a> <a href="https://t.co/UIdX1vkYhR">pic.twitter.com/UIdX1vkYhR</a></p>&mdash; ePages Developers (@epagesdevs) <a href="https://twitter.com/epagesdevs/status/792077288342974468">October 28, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
