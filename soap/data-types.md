---
layout: docs
key: soap-data-types
title: Data types
---

The API uses the following the XSD supported data types:

# Integer

The integer data type is used to specify a numeric value without a fractional component.

## Example

{% highlight xml %}
<Count>356</Count>
{% endhighlight %}

# Float

The float data type is used to specify a numeric value, that has a potential decimal place.

## Example

{% highlight xml %}
<Length>3.56</Length>
{% endhighlight %}

# String

The string data type is used to specify values that contain character strings.

## Example

{% highlight xml %}
<CustomerName>John Smith</CustomerName>
{% endhighlight %}

# Array

The array data type is used to specify an ordered collection of values.

## Example

{% highlight xml %}
<Numbers type="array">
  <Value>3</Value>
  <Value>4</Value>
  <Value>5</Value>
</Numbers>
{% endhighlight %}

# Boolean

The boolean data type is used to specify a true or false value.

## Example

{% highlight xml %}
<IsAvaliable>true</IsAvailable>
{% endhighlight %}

# DateTime

The dateTime data type is used to specify a date and time.

## Example

{% highlight xml %}
<StartDate>2015-05-06T09:00:00</StartDate>
{% endhighlight %}

# TAttribute

ePages-specific data type.
The TAttribute data type is used to specify a name-value pair of a base type.
It can be used in an array to receive a list of name-value pairs.

## Example

{% highlight xml %}
<Attribute xsi:type="TAttribute">
    <Name>Manufacturer</Name>
    <Type>String</Type>
    <Value>ePagesBuilder</Value>
</Attribute>
{% endhighlight %}

# TProductPrice

ePages-specific data type.
The TProductPrice data type handles different prices related to products.
It holds an amount for each related currency and tax model.

## Example

{% highlight xml %}
<ProductPrice xsi:type="TProductPrice">
    <CurrencyID>GBP</CurrencyID>
    <Price>9.99</Price>
    <TaxModel>gross</TaxModel>
</ProductPrice>
{% endhighlight %}

# TLocalizedValue

ePages-specific data type.
The TLocalizedValue data type specifies a value for different languages.
The base type of the values can be one of the general types mentioned above and the type "file".

## Examples

The default base type does not need to be specified by the <Type>String</Type>.

{% highlight xml %}
<Description soapenc:arrayType="TLocalizedValue[2]" xsi:type="soapenc:Array">
    <LocalizedValue>
        <LanguageCode>de</LanguageCode>
        <Value>das ist eine Beschreibung</Value>
    </LocalizedValue>
    <LocalizedValue>
        <LanguageCode>en</LanguageCode>
        <Value>this is a description</Value>
    </LocalizedValue>
</Description>
{% endhighlight %}

### Boolean example

{% highlight xml %}
<IsAvailableForLanguage soapenc:arrayType="TLocalizedValue[2]" xsi:type="soapenc:Array">
    <LocalizedValue>
        <LanguageCode>de</LanguageCode>
        <Type>Boolean</Type>
        <Value>true</Value>
    </LocalizedValue>
    <LocalizedValue>
        <LanguageCode>es</LanguageCode>
        <Type>Boolean</Type>
        <Value>false</Value>
    </LocalizedValue>
</IsAvailableForLanguage>
{% endhighlight %}

### File example

{% highlight xml %}
<Picture soapenc:arrayType="TLocalizedValue[2]" xsi:type="soapenc:Array">
    <LocalizedValue>
        <LanguageCode>de</LanguageCode>
        <Type>File</Type>
        <Value>pic_de.png</Value>
        <FileContent>BeispielInhalt</FileContent>
    </LocalizedValue>
    <LocalizedValue>
        <LanguageCode>en</LanguageCode>
        <Type>File</Type>
        <Value>pic_en.png</Value>
        <FileContent>exampleContent</FileContent>
    </LocalizedValue>
</Description>
{% endhighlight %}

# ListOf

ePages-specific data type.
The ListOfType data type is based on different ePages-specific data types e.g. TLocalizedValue, TAttribute or similar and holds a list of items of this specific base type.

## Example

{% highlight xml %}
<Mapping type="ListOfAttributes">
    <Attribute type="TAttribute">
        <Name>Peter</Name>
        <Value>Boss</Value>
    </Attribute>
    <Attribute type="TAttribute">
        <Name>Klaus</Name>
        <Value>Member</Value>
    </Attribute>
    <Attribute type="TAttribute">
        <Name>Mary</Name>
        <Value>Customer</Value>
    </Attribute>
</Mapping>
{% endhighlight %}

# TError

ePages-specific data type.
The TError data type specifies a message and code and responds with an error.

## Example

{% highlight xml %}
<Error type="TError">
    <Message>the customer 'Freddy' does not exists</Message>
    <Code>CUSTOMER_NOT_EXISTS</Code>
</Error>
{% endhighlight %}
