---
layout: post
title: Why you should invest time on translation keys
date: "2017-08-08 09:34:02"
image: blog-header/translation-keys.jpg
categories: tech-stories
authors: ["Christina"]
---
Let me guess.
You believe that translation keys are not important at all?
That taking a closer look at them is just a waste of time?
Let me convince you otherwise.

In the following, I will tell you why we looked at our translation keys more closely, and what have been the most important aspects.

## What is the purpose of all this?

We already had functioning translation keys, and everything worked out.
So far.
Somehow.
But nobody really paid attention to an overall structure or any consistency.
This led to keys that are not conclusive enough to work with them without deeper knowledge of the specific page they are located on.
The main problem was that the keys did not include enough context information.

Here's an example:

{% highlight json %}
{
"categoryList": {
  "create": "Add category",
  "name": "Name",
  "type": "Type"
    }
  }
{% endhighlight %}

It is not clear, if "Add category" is an explanation, a button label, or something completely different.
In addition, the reader has no indication, what "name" and "type" stand for, and where they are located.
To answer these uncertainties, our UI writers now have two options:

* Ask the developer
* Manually find the page where the key is used and take a closer look at it.

These additional steps could be skipped, if the key itself would answer these questions.

## Breaking new ground

For our new technology platform, we will introduce a new localization process.
And we will work with a software localization tool.
A special feature of this tool is an In-Context Editor, that will already tremendously help us handling source and target texts directly in the software.
This way, our UI writers can create texts in the specific context, and know exactly what kind of wording is needed.
But it is difficult to use this editor for keys that are not directly visible on the website (such as modal dialogs), and the localization software might not work 24/7.
So there's still the need to optimize the translation keys.

## The importance of context

In case we need context information without being able to access the In-Context Editor, the only source will then be our translation keys.
This is why it is important to use a key structure where the missing context is included.
As you have already seen in the example above, our old key structure didn't really include any kind of these information.
So we changed the structure and came up with the following:

{% highlight json %}
{
"categoryListView": {
  "createButton": {
  "label": "Add category"
  },
   "nameColumn": {
   "label": "Name"
  },
  "typeColumn": {
  "label": "Type"
    }
  }
}
{% endhighlight %}

The first difference between the old and the new version is quite obviously the length.
This is due to the additional context information.
The reader now gets the important information, that "Add category" is a button label, whereas "Name" and "Type" are actually column labels.
Just by looking at the keys, our UI writers get an idea for which UI element the source text is required.

## The importance of consistency

But structured keys are not enough.
The keys have to be structured AND consistent.
Many developers will create translation keys for the software.
And they will have their own style to create a translation key.
But even though they all use a nested and common structure, and thus enable the reader to follow the path, probably problems of comprehension might come up due to inconsistent wording.
Even if only one expression is changed and *section* is used instead of *column* in the above mentioned example, our UI writers would have to figure out if there is a difference between those two, and if they need to use a different kind of wording.
This research takes time and can easily be prevented by the avoidance of two different versions.

## Bringing all the threads together

What we need is a style guide for translation keys.
It leads to a company-wide consistent usage, and thus enables readers to understand the keys more easily.
Furthermore, developers have a given template and don't need to spend extra time thinking about the correct term or structure.

To create our new translation key style guide, we set up a meeting with:

* developers, to keep in mind the technical feasibility
* UI writers, to ensure their understanding of the keys.

Together we came up with a consistent structure that works for all parties.
If in your specific case, more groups need to work with such a style guide, they should also participate in this meeting.

## Our learnings

Developing the perfect translation key structure is kind of impossible.
This is the main result of many hours of discussing and comparing.
We figured out a style that works for us.
In most of the cases.
Our style guide now helps other teams to create new keys or improve old ones.
But there will always be a special case where no rule can be applied.
That's completely okay.
All in all the outcome has been really positive and useful, and we will save a lot of time, queries, and energy.

Now you're ready to start and spend some time on your translation keys.
It's worth it!
