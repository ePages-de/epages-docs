---
layout: page
key: soap-error-handling
title: Error handling
---

API calls return error data that your client application can use to identify and resolve errors.
If an error occurs during the invocation of an API call, the API provides the following types of error handling:

# API data or process error (epages:TError)
If errors occures on the server in the SOAP API during processing data if may produces errors of type TError defined in ePagesTypes.xsd
{% highlight xml %}
<xs:complexType name="TError">
  <xs:annotation>
    <xs:documentation>an error object</xs:documentation>
  </xs:annotation>
  <xs:all>
    <xs:element name="Message" type="xs:string">
      <xs:annotation>
        <xs:documentation>a short error message as description</xs:documentation>
      </xs:annotation>
    </xs:element>
  </xs:all>
</xs:complexType>
{% endhighlight %}
the error can related to the whole rersponse, but if you process a list of date it could related to a part of it like in this example which tries to create invoice, packing slip and credit not of a non existing order:
{% highlight xml %}
<soap:Envelope ...">
  <soap:Body>
    <createResponse>
      <OrderDocuments soapenc:arrayType="namesp347:TCreate_Return[3]" xsi:type="soapenc:Array">
        <OrderDocument xsi:type="namesp347:TCreate_Return">
          <Error xsi:type="namesp348:TError">
            <Message xsi:type="xsd:string">Object with path Customers/1003/Orders/1002 was not found.</Message>
          </Error>
          <Order xsi:type="xsd:string">Customers/1003/Orders/1002</Order>
          <Alias xsi:type="xsd:string">myinvoice</Alias>
          <Class xsi:type="xsd:string">/Classes/Invoice</Class>
        </OrderDocument>
        <OrderDocument xsi:type="namesp347:TCreate_Return">
          <Error xsi:type="namesp348:TError">
            <Message xsi:type="xsd:string">Object with path Customers/1003/Orders/1002 was not found.</Message>
          </Error>
          <Order xsi:type="xsd:string">Customers/1003/Orders/1002</Order>
          <Alias xsi:type="xsd:string">mypackingslip</Alias>
          <Class xsi:type="xsd:string">/Classes/PackingSlip</Class>
        </OrderDocument>
        <OrderDocument xsi:type="namesp347:TCreate_Return">
          <Error xsi:type="namesp348:TError">
            <Message xsi:type="xsd:string">Object with path Customers/1003/Orders/1002 was not found.</Message>
          </Error>
          <Order xsi:type="xsd:string">Customers/1003/Orders/1002</Order>
          <Alias xsi:type="xsd:string">mycreditnote</Alias>
          <Class xsi:type="xsd:string">/Classes/CreditNote</Class>
        </OrderDocument>
      </OrderDocuments>
    </createResponse>
  </soap:Body>
</soap:Envelope>
{% endhighlight %}

# missing soap service or similar fault in soap protocol (soap:fault)
If the request can not handle by the epages service because some error in the soap protokol before, then it occures a soap error with an HTTP 500 error status code and a content like:
{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope ...">
  <soap:Body>
    <soap:Fault>
      <faultcode>soap:Server</faultcode>
      <faultstring>WebService doesn't exist (URI=urn://epages.de/WebService/OrderDocumentService/2011/08x)</faultstring>
      <detail>
        <ErrorDetails>
          <Code xsi:type="xsd:string">NoResults_WebServiceByURI</Code>
          <Hash xsi:type="xsd:string">d7882a199fc396f04ed7a35e90d39238</Hash>
          <GUID xsi:type="xsd:string">559FB3B2-469F-BC89-623B-AC183217F1D3</GUID>
        </ErrorDetails>
      </detail>
    </soap:Fault>
  </soap:Body>
</soap:Envelope>
{% endhighlight %}
some more detail could be found in epages log files related to the Hashcode and the error GUID

# wrong authentication (http:error)
By missing or wrong authentication it occures a HTTP error only before passing to the epages service. It responses a statuscode 401 only without any content



