---
layout: post
title: "Tracing the suspect - a microservices murder mystery"
date: "2017-08-17 09:30:00"
image: blog-header/tracing-the-suspect-a-microservices-murder-mystery.jpg
categories: tech-stories
authors: ["Jens"]
---

The [first post][haystack] in this series of blog posts about debugging microservices covered, how we can produce structured log events to ease log aggregation.
We also introduced the concept of log correlation using a `correlation-id`, that spans multiple microservices to connect related log events.
In this second post we will enhance the JSON log structure, and dive deeper into the topic of **distributed tracing**.

## Custom JSON structure

At ePages we use [Google's Stackdriver Logging infrastructure][stackdriver] to aggregate all our log events, thus we need to adjust our JSON structure to follow their format:
We want to rename the default JSON properties `@timestamp` and `level` to `time` and `severity` respectively, while completely dropping `@version`, `level_value`, and `thread_name`.
Using [Spring Boot][spring-boot]'s support for [Logback][logback], we control the JSON structure by introducing a [custom encoder layout](https://github.com/logstash/logstash-logback-encoder#composite-encoderlayout) in this `logback-spring.xml` file:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <include resource="org/springframework/boot/logging/logback/defaults.xml"/>
    <springProperty scope="context" name="app" source="spring.application.name"/>
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder class="net.logstash.logback.encoder.LoggingEventCompositeJsonEncoder">
            <providers>
                <timestamp>
                    <fieldName>time</fieldName>
                    <pattern>yyyy-MM-dd'T'HH:mm:ss.SSS'Z'</pattern>
                    <timeZone>UTC</timeZone>
                </timestamp>
                <logLevel>
                    <fieldName>severity</fieldName>
                </logLevel>
                <context/>
                <pattern>
                    <pattern>{ "correlation-id": "%mdc{correlation-id:-}" }</pattern>
                </pattern>
                <loggerName>
                    <fieldName>logger</fieldName>
                </loggerName>
                <message/>
            </providers>
        </encoder>
    </appender>
    <root level="INFO">
        <appender-ref ref="STDOUT"/>
    </root>
</configuration>
{% endhighlight %}

The JSON property `app` is rendered by the `<context/>` JSON provider, which gets its value from the `<springProperty/>` element used to access the `spring.application.name` configuration value available for every Spring Boot app.
The `correlation-id` is fetched from the Mapped Diagnostic Context (as introduced in the previous blog post) using the special [conversion word](https://logback.qos.ch/manual/layouts.html#mdc) `%mdc{}`.

A typical stream of log events produced by processing a single request spanning the microservices named *ping*, *pong* and *ack* behind our *api-gateway* in our (artificial) system looks like this:

{% highlight json %}
{
  "time": "2017-08-09T16:20:11.242Z",
  "severity": "INFO",
  "app": "ping",
  "correlation-id": "889ef8b52abdaf7559850bef6c86e157",
  "logger": "com.epages.pingpong.PingPongController",
  "message": "PING working hard for 1s"
} {
  "time": "2017-08-09T16:20:12.248Z",
  "severity": "INFO",
  "app": "pong",
  "correlation-id": "889ef8b52abdaf7559850bef6c86e157",
  "logger": "com.epages.pingpong.PingPongController",
  "message": "PONG working hard for 1s"
} {
  "time": "2017-08-09T16:20:13.254Z",
  "severity": "INFO",
  "app": "ack",
  "correlation-id": "889ef8b52abdaf7559850bef6c86e157",
  "logger": "com.epages.pingpong.PingPongController",
  "message": "ACK working hard for 0s"
} {
  "time": "2017-08-09T16:20:13+00:00",
  "severity": "INFO",
  "app": "api-gateway",
  "correlation-id": "889ef8b52abdaf7559850bef6c86e157",
  "logger": "access_log",
  "message": "GET /ping HTTP/1.1"
}
{% endhighlight %}


## And then it crashed!

In our example it is possible, that one of the participating microservices is producing an error, causing the whole request spanning all microservices to fail.
For investigating these kinds of failures it is important to also get access to the stacktrace providing detailed information.
Stacktraces in Java can get pretty unwieldy and long, and they happen to hide the most important information at the very bottom.
We introduce a special `<stackTrace/>` JSON provider, that can be configured to truncate noisy stacktrace frames (e.g. from invocation via reflection), and moves the root cause to the top:

{% highlight xml %}
<stackTrace>
    <fieldName>stacktrace</fieldName>
    <throwableConverter class="net.logstash.logback.stacktrace.ShortenedThrowableConverter">
        <rootCauseFirst>true</rootCauseFirst>
        <exclude>sun\.reflect\..*\.invoke.*</exclude>
    </throwableConverter>
</stackTrace>
{% endhighlight %}

The log event looks like this (after applying some additional manual trimming):

{% highlight json %}
{
  "time": "2017-08-09T16:18:52.384Z",
  "severity": "ERROR",
  "app": "ping",
  "correlation-id": "d82f882ec1fb71386f9ece8a9420f0d7",
  "logger": "com.epages.pingpong.PingPongController",
  "message": "Error calling http://service/",
  "stacktrace": "java.net.SocketTimeoutException: Read timed out
    at java.net.SocketInputStream.socketRead0(SocketInputStream.java)
    at java.net.SocketInputStream.socketRead(SocketInputStream.java:116)
    at java.net.SocketInputStream.read(SocketInputStream.java:171)
    at java.net.SocketInputStream.read(SocketInputStream.java:141)
    at java.io.BufferedInputStream.fill(BufferedInputStream.java:246)
    at java.io.BufferedInputStream.read1(BufferedInputStream.java:286)
    at java.io.BufferedInputStream.read(BufferedInputStream.java:345)
    at sun.net.www.http.HttpClient.parseHTTPHeader(HttpClient.java:735)
    at sun.net.www.http.HttpClient.parseHTTP(HttpClient.java:678)
    at sun.net.www.protocol.http.HttpURLConnection.getInputStream0(HttpURLConnection.java:1569)
    at sun.net.www.protocol.http.HttpURLConnection.getInputStream(HttpURLConnection.java:1474)
    at java.net.HttpURLConnection.getResponseCode(HttpURLConnection.java:480)
    at org.springframework.http.client.SimpleBufferingClientHttpRequest.executeInternal(SimpleBufferingClientHttpRequest.java:84)
    at org.springframework.http.client.AbstractBufferingClientHttpRequest.executeInternal(AbstractBufferingClientHttpRequest.java:48)
    at org.springframework.http.client.AbstractClientHttpRequest.execute(AbstractClientHttpRequest.java:53)
    at org.springframework.http.client.InterceptingClientHttpRequest$InterceptingRequestExecution.execute(InterceptingClientHttpRequest.java:99)
    at org.springframework.http.client.InterceptingClientHttpRequest$InterceptingRequestExecution.execute(InterceptingClientHttpRequest.java:86)
    at org.springframework.http.client.InterceptingClientHttpRequest.executeInternal(InterceptingClientHttpRequest.java:70)
    at org.springframework.http.client.AbstractBufferingClientHttpRequest.executeInternal(AbstractBufferingClientHttpRequest.java:48)
    at org.springframework.http.client.AbstractClientHttpRequest.execute(AbstractClientHttpRequest.java:53)
    at org.springframework.web.client.RestTemplate.doExecute(RestTemplate.java:652)
    ... 60 common frames omitted"
}
{% endhighlight %}


# TODO



## B3

The B3 portion of the header is so named for the original name of Zipkin: BigBrotherBird.


{% highlight json %}
{
  "@timestamp": "2017-08-09T13:08:08.329+00:00",
  "@version": 1,
  "message": "PING working hard for 2s",
  "logger_name": "com.epages.pingpong.PingPongController",
  "thread_name": "http-nio-80-exec-5",
  "level": "INFO",
  "level_value": 20000,
  "app": "ping",
  "X-Span-Export": "true",
  "X-B3-SpanId": "55e38df688e6dfd2",
  "X-B3-TraceId": "74639eb71741c6e255e38df688e6dfd2"
} {
  "@timestamp": "2017-08-09T13:08:10.335+00:00",
  "@version": 1,
  "message": "PONG working hard for 0s",
  "logger_name": "com.epages.pingpong.PingPongController",
  "thread_name": "http-nio-80-exec-7",
  "level": "INFO",
  "level_value": 20000,
  "app": "pong",
  "X-Span-Export": "true",
  "X-B3-SpanId": "2a05d6822505a7e7",
  "X-B3-ParentSpanId": "55e38df688e6dfd2",
  "X-B3-TraceId": "74639eb71741c6e255e38df688e6dfd2"
} {
  "@timestamp": "2017-08-09T13:08:10.339+00:00",
  "@version": 1,
  "message": "ACK working hard for 0s",
  "logger_name": "com.epages.pingpong.PingPongController",
  "thread_name": "http-nio-80-exec-7",
  "level": "INFO",
  "level_value": 20000,
  "app": "ack",
  "X-Span-Export": "true",
  "X-B3-SpanId": "b3bd3b3c4d90de2e",
  "X-B3-ParentSpanId": "2a05d6822505a7e7",
  "X-B3-TraceId": "74639eb71741c6e255e38df688e6dfd2"
} {
  "@timestamp": "2017-08-09T13:08:10+00:00",
  "@version": 1,
  "message": "GET /ping HTTP/1.1",
  "level": "INFO",
  "level_value": 20000,
  "app": "api-gateway",
  "trace": "74639eb71741c6e255e38df688e6dfd2"
}
{% endhighlight %}



[haystack]:                 /blog/2017/07/13/where-is-the-bug-in-my-microservices-haystack.html         "Where's the bug in my microservices haystack?"
[stackdriver]:              https://cloud.google.com/logging/                   "Google Stackdriver Logging"
[spring-boot]:              https://projects.spring.io/spring-boot/ "Spring Boot"
[logback]:                  https://logback.qos.ch/         "Logback - The Generic, Reliable Fast & Flexible Logging Framework"
[logstash-logback-encoder]: https://github.com/logstash/logstash-logback-encoder    "Logback JSON encoder"
[nginx]:                    https://nginx.org/en/       "nginx reverse proxy server"
[dapper]:                   https://research.google.com/pubs/pub36356.html  "Dapper, a Large-Scale Distributed Systems Tracing Infrastructure"
[sleuth]:                   https://cloud.spring.io/spring-cloud-sleuth/    "Spring Cloud Sleuth"
[zipkin]:                   http://zipkin.io/                               "Zipkin distributed tracing system"
[b3-spec]:                  https://github.com/openzipkin/b3-propagation    "B3 specification"
