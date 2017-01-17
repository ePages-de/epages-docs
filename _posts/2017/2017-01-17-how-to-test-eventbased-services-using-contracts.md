---
layout: post
title: "How to test event-based services using contracts"
date: "2017-01-17 12:11:00"
image: blog-header/testing-async-interactions.jpg
categories: tech-stories
authors: ["Mathias"]
---

In a distributed architecture, we strive to build self-contained services.
We try hard to make these services as autonomous as possible, but it is often impossible to build a service that can fulfill its tasks without interacting with other services.

When it comes to service interaction we try to use an event-based approach.
This means interacting asynchronously and outside the user interaction where applicable.

Having embarked on this road you will soon ask yourself how to test such asynchronous interactions.
[Spring Cloud Contract](https://cloud.spring.io/spring-cloud-contract/) offers great support for such scenarios.
Let's address this challenge using a simple application consisting of two services and see how Spring Cloud Contract can help improve testing the asynchronous interaction between them.

## The sample application

Our application consists of two services:

- the product service is responsible for managing product data
- the checkout service offers cart-related capabilities.

The checkout service cannot fulfill the task of adding a certain quantity of a product to a cart without product data.
So the checkout service listens to product events to hold a copy of relevant data of each product.
This approach allows us to satisfy all user requests in the checkout service from its local database. This is a lot faster than having to ask the product service for product data while the user is waiting for a reply.
We also reduce runtime dependencies between our services.

Whenever we create a [product](https://github.com/mduesterhoeft/testing-asynchonous-interactions/blob/master/product-service/src/main/java/com/epages/product/Product.java) an event is [published](https://github.com/mduesterhoeft/testing-asynchonous-interactions/blob/master/product-service/src/main/java/com/epages/product/ProductEventHandler.java) which the checkout service [picks up](https://github.com/mduesterhoeft/testing-asynchonous-interactions/blob/master/checkout-service/src/main/java/com/epages/checkout/ProductSubscriber.java).
It will then store [its view on the product](https://github.com/mduesterhoeft/testing-asynchonous-interactions/blob/master/checkout-service/src/main/java/com/epages/checkout/ProductRef.java) in the checkout database.

For the sample application, we use [Spring Boot](http://projects.spring.io/spring-boot/),  [RabbitMQ](https://www.rabbitmq.com/) as the message broker, and [Spring Amqp](http://projects.spring.io/spring-amqp/) to interact with it from our application.

The code referenced in this post is available on [github](https://github.com/mduesterhoeft/testing-asynchonous-interactions). It is advisable to make yourself familiar with this code before reading on.

## A primitive test is better than nothing

How should we test this interaction between the product and the checkout service?
Of course, an integration test would be possible.
But we favor fast feedback and ideally want issues to become apparent as early as possible and without having to start all our services.
So we strive for a solution that allows us to test the interactions on the checkout service in isolation.
We do not want to run the product service and the message broker to be able to test it.
This is what we call a local integration test.

A test that is fairly easy to implement on checkout-service side is to just hard-code the event payload as the checkout service expects it and ensure that the service correctly consumes this event.

Such a [test](https://github.com/mduesterhoeft/testing-asynchonous-interactions/blob/master/checkout-service/src/test/java/com/epages/checkout/ProductSubscriberHardcodedPayloadTest.java) should do two things:

- make sure that the JSON event payload can be deserialized correctly
- ensure that the service is reacting appropriately.

```java
@Test
public void should_handle_product_created_event() {
  //GIVEN
  String payload = "{\n" +
    "  \"id\": 8,\n" +
    "  \"name\": \"Awesome Jeans\",\n" +
    "  \"salesPrice\": 49.99\n" +
    "}";

  //WHEN
  createAndEmitEvent(payload);
  //THEN
  then(productRefRepository.exists(8L)).isTrue();
}
```

Note that the test uses a mock connection factory to avoid connecting to a running message broker.
It also uses the Spring Amqp `MessageListener` to publish the event. Thus we leave the deserialization to Spring Amqp and also test the configuration there.
See the [test source](https://github.com/mduesterhoeft/testing-asynchonous-interactions/blob/master/checkout-service/src/test/java/com/epages/checkout/ProductSubscriberHardcodedPayloadTest.java) for on how this is done in detail.

Our basic test works for a start but as our service landscape becomes more and more complex, we will figure out that such an approach just does not scale.
Eventually, we will make changes to the product service without anticipating that these changes will break the checkout service.
The tests of both services will stay green although the interaction is broken.

## Spring Cloud Contract and provider contracts

Our situation would improve significantly if we could just test the event subscriber against the latest version of the payload as generated by the product service.
At the same time, we still want to be able to run this test without having to start a message broker and the product service.

Spring Cloud Contract is the missing piece here.
It is an umbrella project to help users to implement the [consumer-driven contract approach](http://martinfowler.com/articles/consumerDrivenContracts.html).
It addresses REST and messaging interactions.
We will use its messaging functionalities for our sample application.
Spring Cloud Contract provides integrations with Spring Integration, Spring Cloud Stream, Apache Camel, and plain [Spring Amqp](https://cloud.spring.io/spring-cloud-contract/spring-cloud-contract.html#_stub_runner_spring_amqp).

Testing the interaction between our checkout and product service with Spring Cloud Contract works as follows.

Our product service expresses the provider contract in the contract definition language which is a groovy DSL that describes the event.
The main purpose of the contract is to define the event structure.

```groovy
org.springframework.cloud.contract.spec.Contract.make {
  description 'should produce valid product event'
  label 'product.created.event'
  input {
    // the contract will be triggered by a method
    triggeredBy('emitProductCreatedEvent()')
  }
  outputMessage {
    sentTo 'test-exchange' //in our case the destination is an exchange name
    headers {
      header('contentType': 'application/json')
    }
    body ([
      id: $(consumer(9), producer(regex("[0-9]+"))),
      name: "Awesome Jeans",
      salesPrice: 49.99,
      purchasePrice: 25.00
    ])
  }
}
```

The contract contains assertions about the payload and headers of the produced event and a label which is the identifier of the contract.
In our scenario, a message is triggered by a certain action.

The `spring-cloud-contract-verifier` will generate a test from this contract which runs together with the usual tests of the application.
This test ensures that the contract definition is in sync with the implementation.

The method name given in the `triggeredBy` attribute of the input section of the contract is used to generate the test.
The abstract test base class [`ProductPublisherTestBase`](https://github.com/mduesterhoeft/testing-asynchonous-interactions/blob/master/product-service/src/test/java/com/epages/product/ProductPublisherTestBase.java) implements this method.
The method basically just sends the event populated with test data. The generated tests extend this base class to be able to call the trigger method.

```java
@RunWith(SpringRunner.class)
@SpringBootTest(classes = ProductServiceApplication.class)
@AutoConfigureMessageVerifier
public abstract class ProductPublisherTestBase {

  @Autowired
  private ProductEventHandler productEventHandler;

  public void emitProductCreatedEvent() {
    Product product = new Product(1L, "Awesome Jeans",
        BigDecimal.valueOf(49.99), BigDecimal.valueOf(25.00));
    productEventHandler.handleCreated(product);
  }
}
```

With the contract and test base class given above, a test class `ContractVerifierTest` is generated into `build/generated-test-sources/contracts/org/springframework/cloud/contract/verifier/tests/`.
The test calls the trigger method stated in the contract and then captures the event using `ContractVerifierMessaging`.
How an event is captured using plain Spring Amqp is part of the Amqp integration in Spring Cloud Contract that I contributed a while ago.
It is achieved by spying on the `RabbitTemplate`.
The test then runs the assertions from the `outputMessage` section of our contract against the event.

```java
public class ContractVerifierTest extends ProductPublisherTestBase {

  @Inject ContractVerifierMessaging contractVerifierMessaging;
  @Inject ContractVerifierObjectMapper contractVerifierObjectMapper;

  @Test
  public void validate_shouldProduceValidProdcutEvent() throws Exception {
    // when:
    emitProductCreatedEvent();

    // then:
    ContractVerifierMessage response = contractVerifierMessaging.receive("test-exchange");
    assertThat(response).isNotNull();
    assertThat(response.getHeader("contentType")).isEqualTo("application/json");
    // and:
    DocumentContext parsedJson = JsonPath.parse(contractVerifierObjectMapper.writeValueAsString(response.getPayload()));
    assertThatJson(parsedJson).field("name").isEqualTo("Awesome Jeans");
    assertThatJson(parsedJson).field("purchasePrice").isEqualTo(25.00);
    assertThatJson(parsedJson).field("id").matches("[0-9]+");
    assertThatJson(parsedJson).field("salesPrice").isEqualTo(49.99);
  }
}
```

So if we would change an attribute name in `Product` we would have a failing test.
**This shields us from making accidental incompatible contract-relevant changes**.

The contracts of the product service are published in a stub jar to a maven repository.
This stub jar can be used by the checkout service.
This is done by stating the stub information in the [application configuration](https://github.com/mduesterhoeft/testing-asynchonous-interactions/blob/master/checkout-service/src/main/resources/application.yml) of the checkout service.

```yml
stubrunner:
  work-offline: true
  ids: 'com.epages:product-service'
```

Now all we need to do is annotate our improved test on checkout side with `@AutoConfigureStubRunner` and use the `StubTrigger` to send the stub message in.
The `spring-cloud-contract-stub-runner` downloads the stub jar with our contract from a maven repository and emits it into our application.
This is done without interacting with a running broker.
After the event is emitted we can run our assertions to make sure the correct effect can be observed.
In our case, we check that the correct product reference has been saved.
Our [refactored test](https://github.com/mduesterhoeft/testing-asynchonous-interactions/blob/master/checkout-service/src/test/java/com/epages/checkout/ProductSubscriberContractTest.java) looks like this:

```java
@RunWith(SpringRunner.class)
@SpringBootTest(classes = CheckoutServiceApplication.class)
@AutoConfigureStubRunner
public class ProductSubscriberContractTest {

  @Autowired
  private StubTrigger stubTrigger;

  @Autowired
  private ProductRefRepository productRefRepository;

  @Test
  public void should_handle_product_created_event() {
    //emit an event from contract with label "product.created.event"
    stubTrigger.trigger("product.created.event");

    then(productRefRepository.exists(9L)).isTrue();
  }
}
```

Basically, the test covers the same aspects as our first version.
But **it always picks up the latest contract definitions**.
This can be called a provider contract test approach. The owner of the interface publishes the information about the structure of the event it emits (e.g. the contract).
A consumer can use the contract to assert that events that follow the contract can be processed.

## Benefits and drawbacks

The main benefit of this approach is the ability to always test against the contract published by the provider.
Tests in the consumer of a message break if it is no longer able to process messages that follow the contract.

Another big plus is the test generated on the provider side that makes sure the contract is in sync with the implementation.
**This protection from accidentally breaking the contract is very important**.

The price we need to pay for these benefits is writing contracts for our events and maintaining them.
In a complex application with a lot of interactions, this can be a significant effort.

Our solution could be improved further by working with consumer-driven contracts.
With this approach, the consumer would publish its expectations about the event produced by the provider.
The provider would pick up these consumer contracts and run its tests against them.
Spring Cloud Contract supports this for HTTP-based interactions and it is also achievable for event-based interactions.
For event-based interactions the solution differs from the one outlined above. This could be a topic for follow-up post.

All told, Spring Cloud Contract is a great tool to improve testing of event-based interaction that is well worth considering if your application is event-heavy.

## Related posts

[How to make microservice testing great again](/blog/2016/07/14/wiremock.html)
