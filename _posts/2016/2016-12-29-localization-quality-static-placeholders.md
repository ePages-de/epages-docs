---
layout: post
title: "Guest post: Higher localization quality with static placeholders"
date: "2016-12-29 07:00:00"
image: blog-header/quality.jpg
categories: tech-stories
authors: ["Frederik"]
---
In the prior article on [smart localization formats](https://developer.epages.com/blog/2016/12/08/smart-localization-formats.html), I tried to shed some light on some of the possible features of the commonly used localization format [gettext](https://www.gnu.org/software/gettext/) and to give a quick introduction to the [ICU Message Format](http://userguide.icu-project.org/formatparse/messages).

This article aims at localization best-practices and achieving a higher localization quality through a technically functional and consistent localization.
So, we transition from i18n (internationalization) to l10n (localization), the act of actually localizing the content for a specific audience.

## Static placeholders

There are cases in which a translatable string contains a phrase that's not be translated at all or to always have the same translation across a project.
Such a phrase can be a company name, product name, a URL, or anything similar.

In any case, I would advise you to split static configuration content, such as email addresses or URLs, from linguistic coherence content, such as shared terminology.

## QA through automated testing

Usually configurations are best kept in the code or close to it, so that no accidental change during translation can happen at all, as they're part of the translation.
If they are used in interpolation the result should be checked by automated tests.
E.g. an automated test runs through the available languages and checks that a certain string contains the correct value for the configuration URL or email address.

## Glossary for shared terminology

At [PhraseApp](https://phraseapp.com/), we've got a [glossary feature](https://phraseapp.com/docs/guides/working-with-phraseapp/glossary/), which allows the management of shared terminology across one or multiple localization projects.
Each term can be configured with a standard translation or marked as non-translatable.

Translators can easily distinguish shared terminology in our Translation Center Editor interface and thus the language consistency can be improved.

This can also be used for shared configuration.
However, as translators are allowed to adapt the glossary terms to the used grammatical case and inflect them, this shouldn't be done without the prior mentioned extra layer of automated testing.

## Keeping track of the translation progress

Especially in large projects, keeping track of the completeness of the translation in all languages a feature should be localized to can be tedious.

At [PhraseApp](https://phraseapp.com/) we use a tagging mechanism.
Regardless if your localization format supports segment context information, once imported into PhraseApp, segments (we call them keys) can be annotated with one or multiple tags.

For example, let's say you added a new checkout flow called `checkout-v2` to your application.
When you added the keys to your locale file and upload them for the first time to PhraseApp, you can specify `checkout-v2` as a tag for the newly created keys. You can later remove this tag from tagged keys or add it to other keys.

{% image blog/blog-higher-localization-1.jpg %}

From now on, you can access detailed stats on this tag such as completion, word-count in the PhraseApp Reports section if you're a user of our statistics and reports features:

{% image blog/blog-higher-localization-2.jpg %}

Additionally, tags simplify translation order processes with our integrated providers as well as translation agencies you work with as you can scope exports and translation orders to tags.

## Summary

The universal paradigm for localization formats and features to me is well described by the popular programmer's acronym: KISS which stands for "keep it simple, stupid".

Complex solutions sometimes look enticing at the beginning, but can lead to additional problems.
A balanced usage of localization library and format smartness leads to a stable and maintainable translation process.

Using [advanced localization feature](https://phraseapp.com/features) should be a topic discussed by all involved parties including your translation team or vendor as they all will have to deal with this long after the localization format initially was introduced and choices to use advanced format feature were made.

## About the author

{% image blog/blog-phraseapp-fvollert.jpg 15% left %}

Fred is the founder of [PhraseApp.com](https://phraseapp.com/) and shares the team's notoriously bad music taste; he loves rap.
Having spent some time in the U.S. as a high-school student and enjoying traveling he is interested in the differences and similarities in international culture and took localization seriously from the beginning in every project he worked on.
