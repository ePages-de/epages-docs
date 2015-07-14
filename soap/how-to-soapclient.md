---
layout: page
key: soap-api
title: SOAP client
---

# Requirements
## 1. installed ePages DemoShop
For your test environment you should have access to a (fresh installed) ePages DemoShop with following data for later use:
shop URL: http://<HOSTNAME>/epages/DemoShop.sf
admin URL: http://<HOSTNAME>/epages/DemoShop.admin (user:admin, password:admin)
If you want to install it on your (virtualized) machine, please follow the simple steps from
[Link to install guide on epages help center](http://helpcenter.epages.com/Doc/ver_6_17_26/epages/Manual/en/ePages_Installation_Guide_for_Linux.html#Basic_ePages_Installation)

## 2. cloned ePages soapclient git repository
[Link to the GitHub soapclient repository.](https://github.com/ePages-de/soapclient)
You can simple clone it by command
{% highlight bash %}
git clone https://github.com/ePages-de/soapclient.git
{% endhighlight %}

initialising the gitclient updates the required dependencies as well
{% highlight bash %}
cd soapclient
./gradlew init
{% endhighlight %}

if you want to run the test suit it needs to pass the wsHostName if it different to localhost (the ePages DemoShop is installed on o different environment)
{% highlight bash %}
./gradlew check -DwsHostName=epages-test.mycompany.de
{% endhighlight %}

if you have a differnt name of DemoShop and changed credential to access of, then you should pass this as well (see README file of [Link to the GitHub soapclient repository.](https://github.com/ePages-de/soapclient) )

run only one of the long list of test cases (here the java test case of the PageCacheService)
{% highlight bash %}
./gradlew :java/shop:test -DwsHostName=epages-test.mycompany.de -Dtest.single=PageCacheService
{% endhighlight %}

the communication is logged into following file
{% highlight bash %}
tail -30 java/shop/logs/communication.log
{% endhighlight %}
the log content is for debuggin and looks like
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

Some more detailed and easier to handle communication tracking is available in tracking/proxy tools like wireshark (https://www.wireshark.org/)
You should configure the capture filter as "tcp port http" and the view filter as "xml" on the ePages machine as shown in this example (place image here).
The wireshark ui allows you to browse easy througth the request and responses and have a look to the structured xml content.






