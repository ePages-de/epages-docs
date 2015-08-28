---
layout: page
key: apps-data-types
title: Data types
---

In the following the JSON supported data types are listed.

# Number

An integer or floating point.

| Type      | Description    |
|---------------|---------------|
| Integer   | Digits 1-9, 0 and positive or negative |
| Floating point | Digit string of any length with a radix point, e.g. 15289.1104|

## Example

{% highlight text %}
{"page": 1}
{% endhighlight %}

# String

A sequence of characters.

## Example

{% highlight text %}
{"shopId": "CreamyIceShop"}
{% endhighlight %}

# Enumeration

Consists a set of named values.

## Example

{% highlight text %}
{"enum": ["oldest", "newest"]}
{% endhighlight %}

# Boolean

True or false values.

## Example

{% highlight text %}
{"layout": "page", "title": "use case", "searchable": true}
{% endhighlight %}

# Array

An ordered collection of values. These are enclosed square brackets, i.e. an array begins with [ and ends with ].
The values are separated by comma.
An array indexing can be started at 0 or 1. Arrays should be used when the key names are sequential integers.

## Example

Array with multiple objects:

{% highlight text %}
{
  "products": [
  { "jacket":"Blizzard" , "colour":"blue" },
  { "jacket":"Paclite" , "colour":"red"},
  { "jacket":"Revolution" , "colour":"white"}
  ]
}
{% endhighlight %}

# Object

An unordered set of name/value pairs. Objects are enclosed in curly braces, i.e. they start with { and end with }.
Each name is followed by a colon and the name/value pairs are separated by comma.
The keys must be strings and should be different from each other.
Objects should be used when the key names are arbitrary strings.

## Example

{% highlight text %}
{
  "id":"589623iuz781",
  "language":"de_DE"
  "currency":"EU"
}
{% endhighlight %}

# Date

An RFC 2822 date. All dates are output in GMT (+0000) time.

## Example

{% highlight text %}
{
  "Fri, 17 Apr 2015 16:56:19 GMT"
}
{% endhighlight %}

# null

An empty value.

## Example

{% highlight text %}
{
    "date": null,
    "price": null
}
{% endhighlight %}
