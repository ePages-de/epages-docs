---
layout: post
title: "Where's the bug in my microservices haystack?"
date: "2017-07-13 09:30:00"
image: blog-header/needle-in-a-haystack.jpg
categories: tech-stories
authors: ["Jens"]
---

While developing our new ePages product using a microservices architecture, we came to experience the challenges involved in operating these kinds of systems.
Debugging is hard, but debugging a distributed system of microservices is even harder.
We are going to tell you about our learnings in this series of blog posts, starting with the topic of logging in a distributed environment.

## It's only after shipping to production...

After a couple of very busy weeks or even months of development, you finally shipped your brand new system of microservices to production.
You impatiently wait for the first real customer feedback, and are ready to implement the next big killer feature of your system.
Then nothing is more irritating than your product owner telling you, that an essential feature is sporadically behaving "strange" and asks you to investigate.

## ...that the real fun begins!

But because of your well-oiled monitoring system, you were already informed about this hours ago.
Here is how we at ePages deal with these situations to find out what is going wrong within our microservices.

Our first step when investigating, involves consulting the logs created in our production environment.
But since our microservices are running as [Docker][docker] containers somewhere in the cloud, it would be very cumbersome to open a terminal connection to each of them, and use command line tools like `grep` to search through log files written to disk.

## Log aggregation to the rescue

As described in [The Twelve-Factor App][12factor], logs should be treated as stream of events.
Containers should not write them to disk, but instead send them directly to `stdout` to be collected and processed by specialized infrastructure components.
This logging infrastructure is responsible for gathering _all_ log events from _all_ runtimes in the system, transforming them into a format for easy searching, and storing them for later retrieval.
Dashboards and other visualization tools can then be used to start digging through the haystack of log events in order to find the needle we are looking for.

## Structured log events

Tools like [**L**ogstash][logstash] or [**F**luentd][fluentd] are Open Source solutions for gathering and transforming log events.
They provide one part of a technology stack often abbreviated as **ELK** or **EFK**, completed by [**E**lasticsearch][elasticsearch] for storing and [**K**ibana][kibana] for visualizing log events.
While such tools are very flexible with regards to their input data formats, we already create log events in a structure that eases (or even lets us completely skip) the transformation step.
For our microservices executed in a Java Virtual Machine (JVM) we use the combination of [Logback][logback] and [Logback JSON encoder][logstash-logback-encoder] to produce log events in JSON, while still allowing seamless integration into all logging calls of our app.
The JSON format created out of the box is already a good fit for Logstash, but it's also possible to introduce a [custom JSON structure](https://github.com/logstash/logstash-logback-encoder#composite-encoderlayout) for more advanced use cases.
A typical Java application can be configured by adding Logback JSON encoder to the classpath and including this `logback.xml` file:

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
  "level_value": 20000,
  "app": "service"
} {
  "@timestamp": "2017-07-07T14:20:46.375+02:00",
  "@version": 1,
  "message": "Root WebApplicationContext: initialization completed in 1018 ms",
  "logger_name": "org.springframework.web.context.ContextLoader",
  "thread_name": "localhost-startStop-1",
  "level": "INFO",
  "level_value": 20000,
  "app": "service"
} {
  "@timestamp": "2017-07-07T14:20:47.042+02:00",
  "@version": 1,
  "message": "Started DebuggingApplication in 2.203 seconds (JVM running for 2.585)",
  "logger_name": "com.epages.debugging.DebuggingApplication",
  "thread_name": "main",
  "level": "INFO",
  "level_value": 20000,
  "app": "service"
}
{% endhighlight %}

The properties `@timestamp`, `@version` and `message` are what the ELK stack expects in order to visualize log events without any further configuration.
We also added the property `app` to include the application name of the microservice for all log events using the following technique.

## Using Mapped Diagnostic Context

The logging abstraction [SLF4J][slf4j] of our choice comes with a feature called "Mapped Diagnostic Context" (MDC), allowing us to store arbitrary key/value pairs to be automatically attached to each log event without explicitly including them in the message we want to log.
After request processing, it is important to also cleanup the MDC from all values that were stored in it, to prevent them from leaking into unrelated following log events.
This can be automatically achieved by leveraging Java's [try-with-resources][try-with-resources] feature:

{% highlight java %}
@Slf4j
@RestController
public class ProcessingController {
    @GetMapping
    public void process(Principal principal) {
        String user = (principal != null) ? principal.getName() : null;
        try (MDC.MDCCloseable mdc = MDC.putCloseable("user", user)) {
            log.info("I processed a request!");
        }
    }
}
{% endhighlight %}

Logback JSON encoder already knows how to include MDC key/value pairs in the log events, and an example output generated by processing a request for user `fred` looks like this:

{% highlight json %}
{
  "@timestamp": "2017-07-07T14:22:29.429+02:00",
  "@version": 1,
  "message": "I processed a request!",
  "logger_name": "com.epages.debugging.ProcessingController",
  "thread_name": "http-nio-8080-exec-1",
  "level": "INFO",
  "level_value": 20000,
  "app": "service",
  "user": "fred"
}
{% endhighlight %}

Now it is easy to search for all log events that include a property named `user` containing the value `fred`.

## Correlating log events

Most requests to a microservices system will be processed by the orchestrated effort of multiple containers, all of their log events being aggregated centrally.
When inspecting the log stream, we want to correlate events from different containers based on matching properties to get the full picture of all participating microservices.
This correlation can be useful for e.g. filtering all events that happened while processing a particular single request identified by a so-called unique **Correlation ID**.

## Single point of entry

It is not uncommon to have one container acting as an [API gateway][api-gateway] in front of all the other containers.
With its powerful reverse proxy capabilities, [nginx][nginx] is a robust choice for fulfilling this role.
Using a custom log format, it is also possible to directly log every HTTP access using our desired JSON structure:

{% highlight nginx %}
http {
    log_format logstash escape=json
        '{'
            '"@timestamp": "$time_iso8601",'
            '"@version": 1,'
            '"message": "$request",'
            '"level": "INFO",'
            '"level_value": 20000,'
            '"app": "api-gateway",'
            '"correlation-id": "$request_id"'
        '}';
    server {
        listen 80;
        access_log /dev/stdout logstash;
        location / {
            proxy_set_header X-Correlation-ID $request_id;
            add_header       X-Correlation-ID $request_id;
            proxy_pass http://service:8080;
        }
    }
}
events {}
{% endhighlight %}

Notice how the `$request_id` [nginx variable](http://nginx.org/en/docs/http/ngx_http_core_module.html#var_request_id) is used to define an additional JSON property for every request, containing a randomly generated hexadecimal value used as the **Correlation ID**.
It is also communicated to the downstream service using a custom HTTP header `X-Correlation-ID`, as well as returned to the calling client as a response header:

{% highlight json %}
{
  "@timestamp": "2017-07-07T14:23:32+02:00",
  "@version": 1,
  "message": "GET / HTTP/1.1",
  "level": "INFO",
  "level_value": 20000,
  "app": "api-gateway",
  "correlation-id": "3b79790f6b320a4b5b3a5c0c0cd06d73"
}
{% endhighlight %}

Adding this `correlation-id` to the MDC for every request to our downstream service can be achieved using a servlet filter:

{% highlight java %}
@Component
public class CorrelationIdFilter extends OncePerRequestFilter {
    @Override
    @SneakyThrows
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain chain) {
        String correlationId = request.getHeader("X-Correlation-ID");
        try (MDC.MDCCloseable mdc = MDC.putCloseable("correlation-id", correlationId)) {
            chain.doFilter(request, response);
        }
    }
}
{% endhighlight %}

Now all container log events emitted as part of the same request also share the same `correlation-id`, finally allowing them to be correlated:

{% highlight json %}
{
  "@timestamp": "2017-07-07T14:23:32.715+02:00",
  "@version": 1,
  "message": "I processed a request!",
  "logger_name": "com.epages.debugging.ProcessingController",
  "thread_name": "http-nio-8080-exec-1",
  "level": "INFO",
  "level_value": 20000,
  "app": "service",
  "correlation-id": "3b79790f6b320a4b5b3a5c0c0cd06d73",
  "user": "fred"
}
{% endhighlight %}

## Outlook

In an upcoming blog post of this series we will have a look at how we can enhance the JSON log events with even more helpful information for debugging, and how to investigate a request spanning multiple services, also known as **distributed tracing**.


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
