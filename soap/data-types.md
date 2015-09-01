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

# ePages specific types

ePages brings own data types in .WSDL files (webservice definition languages) and with the related .XSD files.
All the types starts wit a capital T following by the type name. Here are described some examples of it

# TAttribute

The TAttribute data type is used to specify name-value pair of a base type, it can used in array to have a list of name-value pairs

##Example

{% highlight xml %}
<Attribute xsi:type="TAttribute">
    <Name>Manufacturer</Name>
    <Type>String</Type>
    <Value>ePagesBuilder</Value>
</Attribute>
{% endhighlight %}

# TProductPrice

The TProductPrice data type is a very specific ePages type to handle different kind of prices related to products. It holds an amount for each related currency and tax model.

##Example

{% highlight xml %}
<ProductPrice xsi:type="TProductPrice">
    <CurrencyID>GBP</CurrencyID>
    <Price>9.99</Price>
    <TaxModel>gross</TaxModel>
</ProductPrice>
{% endhighlight %}

# TLocalizedValue

The LocalizedValue data type is used to specify a value for different languages. The base type of the values can be one of the general types above and the type "file"

## Examples

the default base type does not need to specify with the <Type>String</Type>

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

boolean example

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

file example

{% highlight xml %}
<Picture soapenc:arrayType="TLocalizedValue[2]" xsi:type="soapenc:Array">
    <LocalizedValue>
        <LanguageCode>de</LanguageCode>
        <Type>File</Type>
        <Value>pic_de.png</Value>
        <FileContent>iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAIAAAACUFjqAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH0QofESYx2JhwGwAAAFZJREFUeNqlj8ENwDAI
A6HqGDCWp2QQ2AP2oI9IbaQm/dRPn9EJ7m7a56DPPDgiIoKIzGyBM9Pdx+4ueXabWVUBEJHR
nLNJVbfuqspMAEOxwO9r/vX3BTEnKRXtqqslAAAAAElFTkSuQmCC</FileContent>
    </LocalizedValue>
    <LocalizedValue>
        <LanguageCode>fr</LanguageCode>
        <Type>File</Type>
        <Value>pic_fr.png</Value>
        <FileContent>iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAIAAAACUFjqAAAABmJLR0QA/wD/AP+gvaeTAAAA
A6HqGDCWp2QQ2AP2oI9IbaQm/dRPn9EJ7m7a56DPPDgiIoKIzGyBM9Pdx+4ueXabWVUBEJHR
CXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH0QofESYx2JhwGwAAAFZJREFUeNqlj8ENwDAI
nLNJVbfuqspMAEOxwO9r/vX3BTEnKRXtqqslAAAAAElFTkSuQmCC</FileContent>
    </LocalizedValue>
</Description>
{% endhighlight %}

# ListOf<TEpagesType>

The ListOfType data type is based on different ePages Types i.e. TLocalizedValue, TAttribute and similar and holds a list of items of this specific base type

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

The TError data type specify message and code responded by occuring an error.

## Examples

{% highlight xml %}
<Error type="TError">
    <Message>the customer 'Freddy' does not exists</Message>
    <Code>CUSTOMER_NOT_EXISTS</Code>
</Error>
{% endhighlight %}


