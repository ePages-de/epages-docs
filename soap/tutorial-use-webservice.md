---
layout: docs
key: tutorial-use-webservice
title: How to use a web service
---

## 1. Requirements

### 1.1 Existing development environment

In order to be able to use a web service, make sure to have an appropriate development environment in place such as Java, .NET or Perl.

### 1.2 Installed ePages DemoShop

For your test environment you should have access to a freshly installed ePages DemoShop with the following data for later use:

* shop URL: `http://{HOSTNAME}/epages/DemoShop.sf`
* admin URL: `http://{HOSTNAME}/epages/DemoShop.admin` (user: admin, password: admin)

Install the DemoShop on your (virtual) machine by following this [installation guide](http://helpcenter.epages.com/Doc/ver_6_17_26/epages/Manual/en/ePages_Installation_Guide_for_Linux.html#Basic_ePages_Installation).

{% callout info Pro tip: %}
Simply install ePages via this YUM repository patch:
{% endcallout %}

{% highlight text %}
rpm -hiv http://ftp.epages.com/repo/epages/yum/epages-release.noarch.rpm
yum install @epages
{% endhighlight %}

### 1.3 Cloned GitHub repository `ePages-de soapclient`

You can simply clone the [ePages-de soapclient](https://github.com/ePages-de/soapclient) with this command:

{% highlight bash %}
git clone https://github.com/ePages-de/soapclient.git
{% endhighlight %}

## 2. Intitialising the git client

Initialise the git client and update the required dependencies:

{% highlight bash %}
cd soapclient
./gradlew init
{% endhighlight %}

If the client is not located on the same machine as the ePages DemoShop, the client cannot be initialised.
To run the test suite, pass the wsHostName then:

{% highlight bash %}
./gradlew check -DwsHostName=epages-test.mycompany.de
{% endhighlight %}

If the name of the DemoShop as well as the access credentials differ, then pass this information as well (see README.md file in [soapclient repository](https://github.com/ePages-de/soapclient)).

## 3. Sending a request

Run one of the test cases (here: Java test case of `PageCacheService`):

{% highlight bash %}
./gradlew :java/shop:test -DwsHostName=epages-test.mycompany.de -Dtest.single=PageCacheService
{% endhighlight %}

Explanation:

* `java/shop` is supposed to call the `Java` cases.
* `:test` is supposed to call the test cases.
* `test.single` is supposed to call a specific case.

The communication is logged in the following file:

{% highlight bash %}
tail -30 java/shop/logs/communication.log
{% endhighlight %}

The log content is used for debugging and looks like this:

{% highlight bash %}
11:17:22.255 DEBUG - >> "POST /epages/Store.soap HTTP/1.1[\r][\n]"
11:17:22.272 DEBUG - >> "Content-Type: text/xml; charset=utf-8[\r][\n]"
11:17:22.272 DEBUG - >> "SOAPAction: "urn://epages.de/WebService/PageCacheService/2006/07#clear"[\r][\n]"
11:17:22.272 DEBUG - >> "User-Agent: Axis/1.4[\r][\n]"
11:17:22.272 DEBUG - >> "Authorization: Basic L1Nob3BzL0RlbW9TaG9wL1VzZXJzL2FkbWluOmFkbWlu[\r][\n]"
11:17:22.272 DEBUG - >> "Host: hmoye-vm1.intern.epages.de[\r][\n]"
11:17:22.272 DEBUG - >> "Content-Length: 403[\r][\n]"
11:17:22.272 DEBUG - >> "[\r][\n]"
11:17:22.273 DEBUG - >> "<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><ns1:clear soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="urn://epages.de/WebService/PageCacheService/2006/07"/></soapenv:Body></soapenv:Envelope>"
11:17:22.292 DEBUG - << "HTTP/1.1 200 OK[\r][\n]"
11:17:22.293 DEBUG - << "HTTP/1.1 200 OK[\r][\n]"
11:17:22.293 DEBUG - << "Date: Fri, 10 Jul 2015 09:17:21 GMT[\r][\n]"
11:17:22.294 DEBUG - << "Server: Apache[\r][\n]"
11:17:22.294 DEBUG - << "SOAPServer: SOAP::Lite/Perl/1.08[\r][\n]"
11:17:22.294 DEBUG - << "X-AppServer: 172.24.50.23:10046[\r][\n]"
11:17:22.294 DEBUG - << "X-Powered-By: epages 6[\r][\n]"
11:17:22.294 DEBUG - << "X-Store: Store[\r][\n]"
11:17:22.294 DEBUG - << "X-TimeAS: 15[\r][\n]"
11:17:22.294 DEBUG - << "Content-Length: 399[\r][\n]"
11:17:22.294 DEBUG - << "Vary: Accept-Encoding,User-Agent[\r][\n]"
11:17:22.294 DEBUG - << "Connection: close[\r][\n]"
11:17:22.294 DEBUG - << "Content-Type: text/xml; charset=utf-8[\r][\n]"
11:17:22.294 DEBUG - << "[\r][\n]"
11:17:22.302 DEBUG - << "<"
11:17:22.302 DEBUG - << "?"
11:17:22.302 DEBUG - << "x"
11:17:22.302 DEBUG - << "ml version="1.0" encoding="U"
11:17:22.303 DEBUG - << "TF-8"?><soap:Envelope soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soap:Body><clearResponse xsi:nil="true" /></soap:Body></soap:Envelope>"
{% endhighlight %}

More detailed and easier to handle communication tracking is available in tracking or proxy tools such as [Wireshark](https://www.wireshark.org/).
Configure the **Capture Filter** (1) as "tcp port http" and the **Filter** (2) as "xml" on the ePages machine as shown in this example:

{% image soap-wireshark.png %}

The Wireshark UI allows you to easily browse through requests and responses and to take a look at structured xml content.
Read further [here](http://geekswithblogs.net/EltonStoneman/archive/2009/01/29/debugging-soap-messages-with-wireshark.aspx) on how to capture soap xml content with Wireshark or check this [video](https://www.youtube.com/watch?v=qAF8FMxFwoQ&feature=youtu.be) on Wireshark tracing web services.
