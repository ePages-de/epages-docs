---
layout: page
key: soap-data-types
title: Data types
---

The API uses the following the XSD supported data types:

# Integer

The integer data type is used to specify a numeric value without a fractional component.

## Example

{% highlight xml %}
<price>356</price>
{% endhighlight %}

# Float

The float data type is used to specify a numeric value, that has a potential decimal place.

## Example

{% highlight xml %}
<price>3.56</price>
{% endhighlight %}

# String

The string data type is used to specify values that contain character strings.

## Example

{% highlight xml %}
<customer>John Smith</customer>
{% endhighlight %}

# Array

The array data type is used to specify an ordered collection of values.

## Example

{% highlight xml %}
<numbers type="array">
  <numbers>3</value>
  <numbers>4</value>
  <numbers>5</value>
</numbers>
{% endhighlight %}

# Boolean

The boolean data type is used to specify a true or false value.

## Example

{% highlight xml %}
<price disabled="true">356</price>
{% endhighlight %}

# DateTime

The dateTime data type is used to specify a date and time.

## Example

{% highlight xml %}
<startdate>2015-05-06T09:00:00</startdate>
{% endhighlight %}
