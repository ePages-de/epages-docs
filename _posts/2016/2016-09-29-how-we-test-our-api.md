---
layout: post
title: "How we test our API"
date: "2016-09-29 11:11:11"
image: blog-header/heartbeat.jpg
categories: api
authors: ["Ulf B."]
---

A few years ago, at the time when the development of the [ePages REST API](https://developer.epages.com/apps) started,
ePages 6 was a huge monolith written in Perl and already hard to handle.
The objective was to not further inflate the monolith, but rather be able to use state-of-the-art frameworks.
Therefore, the REST API was initiated as a separate service implemented in Java.

This service communicates with the monolith via REST and SOAP in order to process the data we want to expose to the public.
All the API related business logic like rights management and rate limiting are implemented in Java in order to make sure that the Perl implementation of the APIs is simple.

Of course, all resource and service classes are covered by unit tests on both sides, Perl and Java.
Yet, since the functionality of the API is based on two different projects that live in two different repositories,
for which releases two different teams are responsible,
our aim was to assure a simple way to check with a single click, if everything - from end to end - works as expected.

This was the starting point of RAT - our Rest API Test framework.

## RAT

The idea of RAT was to create a framework that allows us to easily verify the state of the REST API on an arbitrary ePages installation.

In order to do so, RAT sends requests to the API and validates the response.
To be able to compare a response with an expected one, we let the test run on shops of the DemoShopType
(The developer installation of ePages includes a DemoShopType, which allows to create a demo shop with certain products of different types and a few orders).
We wanted the test cases to be able to run in an arbitrary order.
The problem is that some of the API calls change a shop (DELETE product),
which leads to different results in the following calls.
The solution is to create new shops in order to test those calls.
So far, the ePages 6 REST API does not offer an endpoint to create new shops, this is why we used the ePages SOAP API to do so.

RAT is based on [REST-assured](http://rest-assured.io/) and [Serenity BDD](http://www.thucydides.info), two tools that ease a lot of our workload and help us to achieve good test results.
In the following paragraphs I will introduce the mentioned tools briefly and show how we use them.

### REST-assured

The particular test cases are implemented using REST-assured. It is a framework that is specially designed for testing REST APIs and allows to easily send different kinds of requests and validations of their responses.

A simple check, for instance, whether the product resource of our REST API is returning 22 products, could look as follows:

{% highlight java %}
given()
    .baseUri("http://some-host-with-an-epages-installation")
    .basePath("rs/shops/DemoShop")
    .accept("application/json")
.when()
    .get("products")
.then()
    .assertThat()
    .statusCode(200)
    .and()
    .body("results", equalTo(22));
{% endhighlight %}

REST-assured allows us to request and validate in a single step (*assertThat()* and *and()* are syntactic sugar and could be left out).

In RAT we usually store the result for later use (e.g. extracting the links and follow them with further requests)
and do the validation in a separate step.

Since baseUri and request headers are more or less the same for every request, we put the request specification in a separate class:

{% highlight java %}
JsonPath products = requestSpecification
                    .get("products")
                    .then()
                    .assertThat() //
                    .statusCode(200) //
                    .and() //
                    .extract() //
                    .body() //
                    .jsonPath();
{% endhighlight %}

#### JSONPath ####

REST-assured already includes a library for JSONPath (which is basically [XPath](https://en.wikipedia.org/wiki/XPath) for JSON) namely [com.jayway.restassured:json-path](https://mvnrepository.com/artifact/com.jayway.restassured/json-path)
that can be used to validate a JSON response and verify certain attributes.

Unfortunately, this library does not implement all the JSONPath expressions from [Stefan Gössner's JSONPath specification](http://goessner.net/articles/JsonPath/) - this is why we use [com.jayway.jsonpath:json-path](https://mvnrepository.com/artifact/com.jayway.jsonpath/json-path) instead.
To use this library we cannot simply apply *... .extract().body().jsonPath();* anymore. Instead, we have to get the response as a string first and then parse it in a second step:

{% highlight java %}
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;

// ...

String body = requestSpecification.get("products")
            .then().assertThat().statusCode(200)
            .extract().body().asString();

DocumentContext products = JsonPath.parse(body);
{% endhighlight %}

Using this library we can finally do some more powerful things like:

{% highlight java %}
int itemCount = products.read("items.length()");
// or
List<String> productNames = products.read("items[*].name");
{% endhighlight %}

### Serenity BDD

Similar to [Cucumber](https://cucumber.io/) in the Ruby world,
Serenity allows you to describe and structure the test cases in a way so that it acts like a complete specification that describes each use case step by step.

The following snippet shows a test case we use to check, if an uploaded image gets added to the slideshow of a product:

{% highlight java %}
@RunWith(SerenityRunner.class)
public class WhenUploadingProductImage {

    private static final String IMAGE_NAME = "scrum-values-800x800.jpg";

    @Steps(uniqueInstance=true)
    ProductImageSteps steps;

    @Before
    public void setup() {
        steps.given_a_demo_shop();
        steps.given_a_developer_token();
    }

    @After
    public void teardown() {
        steps.invalidate_shop();
    }

    @Test
    public void uploaded_image_is_added_to_slideshow() {
        steps.given_the_first_product();
        steps.when_uploading_a_product_image(IMAGE_NAME);
        steps.then_the_product_slideshow_contains_image(IMAGE_NAME);
        steps.when_the_product_image_is_changed_with_slideshow_image(IMAGE_NAME);
        steps.then_the_product_image_is_changed_accordingly();
    }

}
{% endhighlight %}

The implementation of the test steps can be found in different classes.
We have a class *ShopSteps* which contains tests that are shop-specific and needed in all tests.
Then we have e.g. *ProductSteps* inheriting from *ShopSteps* for steps that are used in product-related tests.

This example shows the *ProductImageSteps* (inherited from *ProductSteps*), which only contains those steps that are relevant for product image-related tests:

{% highlight java %}
public class ProductImageSteps extends ProductSteps {

    @Step("When uploading image {0} for product")
    public void when_uploading_a_product_image(String imageName) {
        // ... upload image using REST-assured ...
    }

    @Step("Then the product slideshow contains image '{0}'")
    public void then_the_product_slideshow_contains_image(String imageName) {
        // ... get slideshow using REST-assured and check if the imageName appears in the result ...
    }
}
{% endhighlight %}

Serenity offers the *@Step* annotation to define steps.
The string in the argument will later on appear in the test report.
You can use the variable *{n}*, which will be replaced with the n-th argument the method is called with.

#### HTML test report

After running all tests, Serenity generates a HTML test report.
On its homepage, the report offers a pie chart showing the test results of every featured category.
The following image shows how this diagram currently looks like in our project:

{% image blog/blog-rat-serenity-results.png %}

We try to work test-driven.
Therefore, there are a few test cases in a *pending* state (To do so, Serentity offers a *@Pending* annotation).
These tests are already written, yet will be skipped since the features they should test are not yet implemented.
As soon as everything is in place, they can be activated.

In order to check on the kind of test case, you can click on a feature.
Every test case may consist of multiple steps, which can be displayed in detail:

{% image blog/blog-rat-serenity-results-slideshow.png %}

In this particular test case we wanted to check on whether an image, that was uploaded for a product, appears on the product slideshow.
Within the first step a DemoShop is created (which is either newly created or is already used in other read-only test cases).
In a next step, we take the first product from the product collection resource (*GET /products*) and upload the image. Finally, we retrieve the product slideshow (*GET /products/{productId}/slideshow*) and check if the uploaded image appears.

## Summary

RAT allows us to check the complete state of the REST API on an arbitrary ePages installation by a single click.
We use it to partly automate our QA process and run it as last step of a developer installation via Jenkins to make sure everything went fine.
RAT takes over repetitive tasks and guarantees a certain level of quality - this enables us to spend more time on improving our test infrastructure as well as on the implementation of further test cases.

Currently, we are discussing on how to include RAT in the Jenkins job that checks our GitHub pull requests for new features in the Perl or Java repository.
Here, the challenge is to choose the particular RAT branch that corresponds to the changes in the branch from the pull request.
