---
layout: post
title: "Where's the bug in my microservices haystack?"
date: "2017-07-07 09:30:00"
image: blog-header/needle-in-a-haystack.jpg
categories: tech-stories
authors: ["Jens"]
---

## You shipped to production...

After a couple of very busy weeks or even months of development, you finally shipped your brand new system of microservices to production.
You impatiently wait for the first real customer feedback and are ready to implement the next big killer feature of your system.
Then nothing is more irritating than your product owner telling you, that an essential feature is sporadically behaving "strange" and asks you to investigate.

### ...and now?

Let's not discuss why your product owner needed to tell you about this in the first place, because your well-oiled monitoring system surely informed you hours ahead, or?
Let's discuss how to find out what is going wrong within your microservices.
Debugging is hard, but debugging a distributed system of microservices is even harder.
We will start sharing our experiences in this area in this blog post series.

Your first step when investigating will most likely involve consulting the logs created in your production environment.
But since your microservices are running as [Docker][docker] containers somewhere in the cloud, it would be very cumbersome to open a terminal connection to each of them and use command line tools like `grep` to search through log files written to disk.

## Log aggregation to the rescue

As described in [The Twelve-Factor App][12factor], you should treat logs as stream of events.
Your containers should not write them to disk, but instead send them directly to `stdout` to be collected and processed by specialized infrastructure components.
This logging infrastructure is responsible for gathering _all_ log events from _all_ runtimes in your system, transforming them into a format for easy searching, and storing them for later retrieval.
Dashboards and other visualisation tools can then be used to start digging through the haystack of log events in order to find the needle you are looking for.

### Structured log events

Tools like [**L**ogstash][logstash] or [**F**luentd][fluentd] are Open Source solutions for gathering and transforming log events. They provide one part of a technology stack often abbreviated as **ELK** or **EFK**, completed by [**E**lasticsearch][elasticsearch] for storing and [**Ki**bana][kibana] for visualising log events.
While such tools are very flexible with regards to their input data formats, you should already create log events in a structure that eases (or even let's you completely skip) the transformation step.
For your microservices developed in Java you can use the combination of [Logback][logback] and [Logback JSON encoder][logstash-logback-encoder] to produce log events in JSON, while still allowing seamless integration into all [SLF4J][slf4j] logging calls of your app.
The JSON format created out of the box is already a good fit for Logstash, but you can also introduce your [custom JSON structure](https://github.com/logstash/logstash-logback-encoder#composite-encoderlayout) for more advanced use cases. 
You configure a typical Java application by adding Logback JSON encoder to your classpath and including this `logback.xml` file:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder class="net.logstash.logback.encoder.LogstashEncoder"/>
    </appender>
    <root level="INFO">
        <appender-ref ref="STDOUT"/>
    </root>
</configuration>
{% endhighlight %}

An excerpt of JSON log events produced during startup of a [Spring Boot][spring-boot] application looks like this:

{% highlight json %}
{
  "@timestamp": "2017-07-07T14:20:45.309+02:00",
  "@version": 1,
  "message": "No active profile set, falling back to default profiles: default",
  "logger_name": "com.epages.debugging.DebuggingApplication",
  "thread_name": "main",
  "level": "INFO",
  "level_value": 20000
} {
  "@timestamp": "2017-07-07T14:20:46.375+02:00",
  "@version": 1,
  "message": "Root WebApplicationContext: initialization completed in 1018 ms",
  "logger_name": "org.springframework.web.context.ContextLoader",
  "thread_name": "localhost-startStop-1",
  "level": "INFO",
  "level_value": 20000
} {
  "@timestamp": "2017-07-07T14:20:47.042+02:00",
  "@version": 1,
  "message": "Started DebuggingApplication in 2.203 seconds (JVM running for 2.585)",
  "logger_name": "com.epages.debugging.DebuggingApplication",
  "thread_name": "main",
  "level": "INFO",
  "level_value": 20000
}
{% endhighlight %}

The properties `@timestamp`, `@version` and `message` are what the ELK stack expects in order to visualise log events without any further configuration.

### Using Mapped Diagnostic Context

Your logging framework SLF4J comes with a feature called "Mapped Diagnostic Context" (MDC), that allows you to store arbitrary key/value pairs to be automatically attached to each log event without explicitly including them in the message you want to log.
After request processing, you must make sure to also cleanup the MDC from all values that you stored in it. This can be automatically achieved by leveraging Java's [try-with-resources][try-with-resources] feature:

{% highlight java %}
@Slf4j
@RestController
public class ProcessingController {
    @GetMapping
    public void process(Principal principal) {
        String user = (principal != null) ? principal.getName() : "anonymous";
        try (MDC.MDCCloseable mdc = MDC.putCloseable("user", user)) {
            log.info("I processed a request!");
        }
    }
}
{% endhighlight %}

Logback JSON encoder already knows how to include MDC key/value pairs in your log events, and an example output generated by processing a request for user `fred` looks like this:

{% highlight json %}
{
  "@timestamp": "2017-07-07T17:37:29.429+02:00",
  "@version": 1,
  "message": "I processed a request!",
  "logger_name": "com.epages.debugging.ProcessingController",
  "thread_name": "http-nio-8080-exec-1",
  "level": "INFO",
  "level_value": 20000,
  "user": "fred"
}
{% endhighlight %}

Now it is easy to search for all log events that include a property named `user` containing the value `fred`.

## Correlating log events

Most requests to your microservices system will be processed by the orchestrated effort of multiple containers, all of their log events being aggregated centrally.
When inspecting the log stream, you want to correlate events from different containers based on matching properties to get the full picture of all participating microservices.
This correlation can be useful for e.g. filtering all events that happened while processing a particular single request identified by its unique ID.

### Single point of entry

It is not uncommon to have one container act as an [API gateway][api-gateway] in front of all the other containers.
With its powerful reverse proxy capabilites, [nginx][nginx] is a robust choice for fulfilling this role.
Using a custom log format it is also possible to directly log every HTTP access in our desired JSON structure:

{% highlight nginx %}
events {
}
http {
    log_format logstash escape=json
        '{'
            '"@timestamp": "$time_iso8601",'
            '"@version": 1,'
            '"message": "$request",'
            '"level": "INFO",'
            '"level_value": 20000,'
            '"app": "api-gateway",'
            '"request-id": "$request_id"'
        '}';
    server {
        listen 80;
        access_log /dev/stdout logstash;
        location / {
            proxy_set_header X-Request-Id $request_id;
            proxy_pass http://service:8080;
        }
    }
}
{% endhighlight %}

Notice how the `$request_id` [nginx variable](http://nginx.org/en/docs/http/ngx_http_core_module.html#var_request_id) is used to define an additional JSON property named `request-id` for every request, containing a randomly generated hexadecimal value.
This ID is also communicated to the downstream service using a custom HTTP header `X-Request-Id`:

{% highlight json %}
{
  "@timestamp": "2017-07-07T20:54:40+02:00",
  "@version": 1,
  "message": "GET / HTTP/1.1",
  "level": "INFO",
  "level_value": 20000,
  "app": "api-gateway",
  "request-id": "3b79790f6b320a4b5b3a5c0c0cd06d73"
}
{% endhighlight %}

Adding this `request-id` to the MDC for every request to your downstream service can be achieved using a servlet filter:

{% highlight java %}
@Component
public class RequestIdFilter extends OncePerRequestFilter {
    @Override
    @SneakyThrows
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, 
                                    FilterChain chain) {
        try (MDC.MDCCloseable mdc = MDC.putCloseable("request-id", request.getHeader("X-Request-Id"))) {
            chain.doFilter(request, response);
        }
    }
}
{% endhighlight %}

Now all container log events emitted as part of the same request also share the same `request-id`, allowing them to be correlated:

{% highlight json %}
{
  "@timestamp": "2017-07-07T22:57:32.715+02:00",
  "@version": 1,
  "message": "I processed a request!",
  "logger_name": "com.epages.debugging.ProcessingController",
  "thread_name": "http-nio-8080-exec-1",
  "level": "INFO",
  "level_value": 20000,
  "app": "service",
  "request-id": "3b79790f6b320a4b5b3a5c0c0cd06d73",
  "user": "fred"
}
{% endhighlight %}

## Outlook

In an upcoming blog post in this series we will have a look at how we can enhance the JSON log events with even more 
helpful information for debugging and how to investigate a request spanning multiple services, also know as **distributed tracing**.


[docker]:                   https://www.docker.com/         "Docker container platform"
[12factor]:                 https://12factor.net/logs       "The Twelve-Factor"
[logstash]:                 https://www.elastic.co/products/logstash    "Logstash data processing pipeline"
[fluentd]:                  http://www.fluentd.org/         "Fluentd data collector"
[elasticsearch]:            https://www.elastic.co/products/elasticsearch    "Elasticsearch search and analytics engine"
[kibana]:                   https://www.elastic.co/products/kibana    "Kibana"
[logback]:                  https://logback.qos.ch/         "Logback - The Generic, Reliable Fast & Flexible Logging Framework"
[logstash-logback-encoder]: https://github.com/logstash/logstash-logback-encoder    "Logback JSON encoder"
[slf4j]:                    https://www.slf4j.org/          "Simple Logging Facade for Java"
[spring-boot]:              https://projects.spring.io/spring-boot/ "Spring Boot"
[try-with-resources]:       https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html          "The try-with-resources Statement"
[api-gateway]:              http://microservices.io/patterns/apigateway.html            "Pattern: API Gateway / Backend for Front-End"
[nginx]:                    https://nginx.org/en/       "nginx reverse proxy server"
