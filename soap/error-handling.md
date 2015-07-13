---
layout: page
key: soap-error-handling
title: Error handling
---

API calls return error data that your client application can use to identify and resolve errors.
If an error occurs during the invocation of an API call, the API provides the following types of error handling:

# API data or process error (epages:`TError`)

If an error occurs on the SOAP API server during data processing it may be of the type `TError` as defined in ePagesTypes.xsd
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
The error can be related to the whole response, but if you process a list of data it could be related to a part of it. Refer to the following example that tries to create invoice, packing slip and credit of a non existing order:
{% highlight xml %}
<soap:Envelope>
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

# Missing SOAP service or similar fault in SOAP protocol (`soap:fault`)

If the request cannot be handled by the ePages service due to some error in the previous SOAP protocol, a SOAP error occurs with an HTTP 500 status code and a content such as:
{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope>
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

Find more details in the ePages log files related to the hash code and the error GUID.

# Incorrect authentication (`http:error`)

If an authentication is missing or incorrect, an HTTP error occurs with an HTTP 401 status code only without content. The error occurs even before the request will be passed to the ePages service.
