---
layout: post
title: "Guest post: Smart localization formats in i18n"
date: "2016-12-08 07:00:00"
image: blog-header/smart.jpg
categories: tech-stories
authors: ["Frederik"]
---
From our work with hundreds of companies localizing software here at [PhraseApp](https://phraseapp.com/), I want to share some insights in the usage of gettext and advanced translation message format features.
I'll share my point of view on which features to use and which to rather avoid.

## A discussion of the "smartness" of localization formats

Locales for text-based resources are usually quite simple.
They are composed of segments, each given a label or name and the translation content for the segment in the given language.
For example, when using the [gettext locale format](https://phraseapp.com/docs/guides/formats/gettext-po/), a locale contains bits like this:

{% highlight text %}
  msgid "Hello World"
  msgstr "Hallo Welt"
{% endhighlight %}

Where `msgid` is the label and `msgstr` here is the German translation.

### Interpolation- or placeholder support

Depending on the framework, interpolation or the usage of placeholders is possible:

{% highlight text %}
  msgid "Hello, %s!"
  msgstr "Hallo %s!"
{% endhighlight %}

This allows using the segment and inserting a text bit where the string contains the `%s`-placeholder. Allowing you to use dynamic bits of text to, for example, greet your applications user:

{% highlight text %}
  printf("Hello,  %s.!", username);
  # prints Hello, Fred! with username=Fred
{% endhighlight %}

### Pluralization

Languages vastly differ in the amount and distinction level of plurals.
Especially the Slavic language family has quite complex plural rules.
Many localization formats support advanced expressions like correct pluralization rules for the given language.

In gettext, pluralization support needs to be declared in the header of the locale file:

{% highlight text %}
  msgid ""
  msgstr ""
  "Language: en\n"
  "MIME-Version: 1.0\n"
  "Content-Type: text/plain; charset=UTF-8\n"
  "Content-Transfer-Encoding: 8bit\n"
  "Plural-Forms: nplurals=2; plural=(n != 1);\n"
{% endhighlight %}

The last line defines that the language `en` for English uses `2` plural forms and a plural is used for amounts that are not `1`.
E.g. 2 houses (plural), 1 house (singular), 0 houses (plural).

A translated segment would look like this:

{% highlight text %}
  msgid "You've got one messages."
  msgid_plural "You’ve got %d messages."


  msgstr[0] "You've got a message."
  msgstr[1] "You've got %d messages."
{% endhighlight %}


The `msgstr[0]` is not the zero, but the singular form given a single message, and the `msgstr[1]`form is the plural form used for any other amount of messages, e.g. 0, 2, 3 or n messages with (n=0 or n>1).

In languages with more plural forms, additional plural forms can be added, e.g. for forms for few or many items, labeled `msgstr[2]`, `msgstr[3]` etc.
They need to be numbered according to the [gettext plural-form specification](https://www.gnu.org/savannah-checkouts/gnu/gettext/manual/html_node/Plural-forms.html).

### Process-related format features

Besides simple contextual comments...

{% highlight text %}
  # This is used in the menu
  msgid "About Us"
{% endhighlight %}

... gettext supports also noting the approval-state of a current translation, by using [the keyword `fuzzy` as a system-comment](https://www.gnu.org/software/gettext/manual/html_node/Fuzzy-Entries.html).

{% highlight text %}
  #, fuzzy
  msgid "About Us"
{% endhighlight %}

### gettext's advanced features

Although, pluralization is a useful feature it is usually used sparsely in projects.
The use-cases of phrases such as "You've got %d items in your cart." are actually quite rare and often not worth the trouble of communicating the specifics with translators who may or may not be aware of pluralization features in software localization.
Same story for complex interpolation, such as `"%.2f"` or similar.
Any non-standard text may cause confusion, misunderstanding and in some cases even programmatic errors. Simple is usually more maintainable.
Albeit, modern [translation management platforms](https://phraseapp.com) like PhraseApp help to assist translators in translating strings that have interpolation or plural-rules they adhere to.

### ICU is a completely different story

The ICU MessageFormat tries to allow complex interpolation of sentences and their correct translation in different languages.

This example from the ICU docs highlights a message that changes based on gender of a party's host as well as the number of party guests.
Sounds complex?
Well, let's have a quick look at the example:

{% highlight text %}
  "{gender_of_host, select,"
    "female {"
      "{num_guests, plural, offset:1 "
        "=0 { {host} does not give a party.}"
        "=1 { {host} invites {guest} to her party.}"
        "=2 { {host} invites {guest} and one other person to her party.}"
        "other { {host} invites {guest} and # other people to her party.}"
      "}"
    "}"
    "male {"
    [...]
{% endhighlight %}

I'll skip the rest.

This is hard to understand if you're a developer.
Even more so, if you're a copy-writer or translator usually not used to reading source code or conditional statements.

Why is it hard to understand?
It's mixing the logical part of an application in a standardized way with a usually static text file containing the localization data.
Such a combination is usually not a great idea.
It sure looks like complex application logic and therefore should be part of the application code.
This allows easier testing and it places the logic at a place another reader of the source code would most likely look for it.
Having this run through and evaluated by an external library doesn't add additional transparency.

In short: Algorithmic complexity in translation content is a burden on the translator who needs to work with it as well as generations of developers who will try to understand why a certain piece of logic of their application is hidden in a locale file.

However, there are certain cases in which the ICU message format can be used to enable pluralization support or simple linguistic switches.
Some frameworks such as the popular PHP-web-framework Symfony even introduce [their own version of the same idea](http://symfony.com/doc/current/components/translation/usage.html#message-placeholders).
But this should be done carefully and it may make the translation process more error-prone.

## The gist: keep it simple!

I would suggest to reduce the complexity in the translation process by using explicit sentences with pluralization and placeholders at most.
Complex rule-based translation messages usually lead to confusion with external editors or translators, make problems harder to debug and solve and thereby overcomplicate the process.
Using a [translation management system with a translation memory](https://phraseapp.com) and simple ways to manage a large complex word base is key to being able to achieve an [efficient translation process](https://phraseapp.com).

## About the author

{% image blog/blog-phraseapp-fvollert.jpg 15% left %}

Fred is the founder of PhraseApp.com and shares the team's notoriously bad music taste; he loves rap. Having spent some time in the U.S. as a high-school student and enjoying traveling he is interested in the differences and similarities in international culture and took localization seriously from the beginning in every project he worked on.
