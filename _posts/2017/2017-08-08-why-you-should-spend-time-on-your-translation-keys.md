---
layout: post
title: Why you should spend time on your translation keys
date: "2017-08-08 09:34:02"
image: blog-header/translation-keys.jpg
categories: tech-stories
authors: ["Christina"]
---
Translation keys are not important at all?
Spending time on them is a waste of time?
Let me convince you otherwise.

We just finished the revision of our translation keys because we noticed the value of a good key structure.
In the following, I will tell you why we changed the old system and what have been the most important aspects during this task.

## Structure

We already had functional keys before.
Everything worked out.
But nobody really paid attention to an overall structure or any consistency.
For our new technology platform, we will introduce a new localization process.
Therefore, we will work with a new tool.
A special feature of this tool is an In-Context Editor.
This way, translations and wording can be handled directly in the software and translators as well as UI-Writers are provided with as much context as possible.
They know exactly where the keys are located and which kind of wording is needed.
Thinking of the save button, you will understand why context is that important.
*Save* is not always just *save*.
In some cases it might be better to rename the button.
For example, a save button at the end of a product creation process might better be called a *create product* button.
This decision could not be made without any further information about the content of the specific page and the exact location of the button.

But software might not work 24/7 and it is possible that you are forced to work without the localization tool.
In this case you need to get the context information in a different way.
The only source for context information will then be the keys.
This is why the structure is that important.

Let me give you an example of our new structure:

{% highlight json %} {
"loginView": {
  "passwordTextField": {
    "label": "Password",
    "validationMessages": {
      "isRequired": "Please enter a password"
    }
  },
} {% endhighlight %}

Here you can see the keys for one element of the log in view.
It is a text field where you need to enter your password.
For us, the text field is a main element with several sub-elements.
Therefore, we decided to use a nested structure.
In this way, the context is part of the specific key as you can see in case of the validation message key.
You get the information, that the key is on the log in page and related to the password text field.
If the password in this field is still required, a validation message with the specific value appears.
This way the reader gets as much information about the context of the key as possible and should be able to translate it.

## Consistency

A structured creation of keys is not enough.
The keys have to be structured AND consistent.
There will be more than one developer who is working on the translation keys.
Every developer might have his own style to create his version of a structured key.
But even though he uses a nested and common structure and thus enables the reader to follow the path, there may come up some problems of comprehension.
Even if only one expression is changed and *explanation* is used instead of *hint*, the reader has to find out if there is a difference between those two.
This research takes time and can easily be prevented by the avoidance of two different versions.
The solution is a styleguide.
This document leads to a company-wide consistent usage and thus enables readers to understand the keys more easily.
Furthermore, developers have a given template and don't need to spend extra time thinking about the correct term or structure.

To create our new translation key style guide, we set up a meeting with two groups:
A developer took part to keep in mind the technical feasibility and UI-Writers in order to ensure their understanding of the keys.
Together we came up with a consistent structure that works for both of them.
If more groups need to work with your styleguide they should also participate in this meeting.

## Our learnings

Developing the perfect translation key structure is kind of impossible.
This is the main result of many hours of discussing and comparing.
We figured out a style that works for us.
In most of the cases.
There will always be a special case where no rule can be applied.
That's completely okay.
But the overall outcome has been really positive and useful and we will save a lot of time, queries, and energy.

So go ahead and spend some time on your translation keys.
It's worth it!
