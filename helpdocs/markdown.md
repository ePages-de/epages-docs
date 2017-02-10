# Markdown Style Guide

Markdown is just great to write plain text and get great formatted output in return.
The Markdown used in this repository should be simple and consistent and with a syntax that is easy to follow.
Please stick to the guidelines below:

## Document layout

Every page in this repository that is going to be published must have a layout.

### Developer Documentation

If you create a file for the **Developer Documentation** use the *page* layout.
Together with the layout, define a meaningful *key* and choose a *title* for the page.

~~~ bash
---
layout: page
key: apps-cms-plugin
title: CMS plugin
---
~~~

### Developer Blog

If you create a file for the **Developer Blog** use the *post* layout.
Assign the post a *title* and a *date*.
Choose an *image* that matches the post.
You can either use your own images, or search for one here: [Pexels](https://www.pexels.com/), [Pixabay](https://pixabay.com/), or [Unsplash](https://unsplash.com/).
Edit the image as explained in [Confluence](https://epages.atlassian.net/wiki/display/TW/Editing+blog+header+images) (example with Gimp).
Save the image in the folder "blog-header".
Define a *category* where the post best relates to.

~~~ bash
---
layout: post
title: "ePages REST API out of beta"
date: "2016-01-21 09:34:28"
image: blog-header/dream-team.jpg
categories: tech-stories
authors: ["Birgit"]
---
~~~

## Headings

Use ATX-style for headings.

~~~ bash
## Heading 2
~~~

### Document title

As the first heading use a level two heading (# h2).
The level one heading (# h1) is directly used from the `title` of the page layout.

Exception: for interview blog posts use the level three heading (# h3).

### Spacings

Prefer spacing after `#` and new lines before and after a heading:

~~~ bash
... text before heading.

## Heading 2

Text after heading...
~~~

## Short and simple sentences

Keep headings and sentences short for a readable and portable source text.
Use one sentence per line.

~~~ bash
This is the first sentence.
This is the second sentence.
This is the third sentence.
~~~

## Trailing white spaces

Don't use trailing white spaces.
If trailing white spaces are available, CIRCLE CI tests will fail.
Test you project with the `rake test` command.

## Lists

Prefer fully numbered lists, as it is nicer to read in source:

~~~ bash
1. Foo.
2. Bar.
3. Baz.
~~~

or

~~~ bash
* Item 1
* Item 2
* Item 3
~~~

When nesting lists, use a 4-space indent for both numbered and bulleted lists.

~~~ bash
* Item 1
* Item 2
* Item 3
    * Item 3a
    * Item 3b
    * Item 3c
~~~

## Code

&#96;Backticks&#96; designate `inline code`.
Use them for short code quotations and technical keys.

~~~ bash
Run `sudo gem install epages-rest`.
Use one of the HTTP request types `GET`, `POST`, `PUT` and `DELETE`.
~~~

## Code blocks

For code quotations longer than a single line, use a code block.
Use the following highlighting style that is rendered by epages-docs:

~~~ bash
{% highlight json %}
{
  "message": "Bad Request",
  "status": 400
}
{% endhighlight %}
~~~

~~~ bash
{% highlight ruby %}
# some syntax highlighted Ruby code
module MyModule
  class MyClass
    def initialize(name)
      @name = name
    end
  end
end
{% endhighlight %}
~~~

Explicitly declare the language, so that neither the syntax highlighter nor the reader or next author must guess.

In order to see the different types possible, refer to [examples.md](page:_examples).

## Links

Long links make source Markdown difficult to read and break the 80 character wrapping.
Whenever possible, shorten your links.

### Use informative Markdown link titles

Write your sentence naturally, then go back and wrap the most appropriate phrases with the link:

~~~ bash
[Sign up](http://www.epages.cloud/developer/) for the Developer Program.
~~~

Avoid titling your links as "link" or "here".

### Link types

In order to see the different link types possible, refer to [examples.md](page:_examples).

## Images

In order to see the different possibilities, refer to [examples.md](page:_examples).

### Developer Documentation

Use images, preferably screenshots, and specifically use them to show the UI you're referring to.
Insert images over the full width of the page.

### Developer Blog

Use meaningful images that show a direct relation to your topic.
Either insert the over the full width or align them to the left or right of your text with a reduced file size.
For an example, see the source of [this blog post](https://developer.epages.com/blog/2016/03/01/hr-java.html).

Comment: This section will be updated with new design of developer.epages.com.

## Tables

Any tables in your Markdown should be small.
Large, complex tables are difficult to read in source and most importantly, a pain to modify later.
For an example, see the source of [this markdown file](page:apps-request-headers).

But in any case, use this style:

~~~ bash
| This is       | a table       |
|---------------|---------------|
| Value 1a      | Value 1b      |
| Value 2a      | Value 3b      |
| Value 3a      | Value 3b      |
~~~
