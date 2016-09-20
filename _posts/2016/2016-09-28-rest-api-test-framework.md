---
layout: post
title: "How we test our API"
date: "2016-09-28 11:11:11"
image: blog-header/heartbeat.jpg
categories: tech-stories
authors: ["Ulf B."]
---

Long ago, when starting the development on the ePages public REST API, they decided to
implement it as a separate service because
at this time, ePages6 was only one huge Perl monolith and already hard to handle.

This service is implemented in JAVA using Jersey and it communicates with the monolith via REST and SOAP.
So we had to add a REST API to the Perl monolith as well, but just a simplified one - without any complex token and right management.
This is completely moved to the Java part where existing features of Jersey could be used.

Of course all the resource and services classes are coverey by unit test on both side, Perl and Java, but
since the functionality of the API is based on two different projects that lie in two different repositories
which have two different teams responsible for the releases,
we wanted to have a way to check with one click if everything - from end to end - is working as expected.

This was the starting point of RAT - our Rest API Test framework.

## RAT

The idea of RAT is to have a framework that checks the complete state of the REST API on an abritrary ePages installation just at the push of a button.

In order to do so, RAT sends requests to the API and validates the response.
To be able to compare the response with an expected one, we let the test base on shop of the DemoShopType
(The developer installation of ePages includes a DemoShopType which allows to create a demo shop with certain products of different types and a few orders).
We wanted the test cases to be able to run in a arbitrary order. The problem is that some of the API calls change a shop (DELETE product),
which lead to different results in the following calls. The solution is to create new shops for testing those calls.
The ePages6 REST API does not offer an endpoint to create new shops so far, so we used the ePages SOAP API to do that.

RAT is based on [REST-assured](http://rest-assured.io/) and [Serenity BDD](http://www.thucydides.info), two tools that take over a lot of work on the way to produce nice test results.

### REST-assured

The certain test cases are implemented using REST-assured. It is a framework that is specially designed for testing REST APIs and allows easily to send different kind of requests and validation of their responses.

[WIP]

### Serenity BDD

Similar to [Cucumber](https://cucumber.io/) in the Ruby world,
Serentiy allows you to describe and structure the test cases in way that acts like a complete specification with a checklist.

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

The certain test steps are in a separate classes. We have a class *ShopSteps* which contains tests that are shop specific and needed in all tests. Then we have e.g. *ProductSteps* inherting from ShopSteps for steps that are used in product-related tests.

This example shows the *ProductImageSteps* (which for their part inherit from *ProductSteps*) because the test is about product images. It only contains those steps that are relevant for product image-related tests:

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

Serenity offers the *@Step* annotation to define steps. The string in the argument will appear later in the test report. You can use the variable *{n}* which will be replaced with the n-th argument the method is called with.

#### HTML test report

After running all the test, Serenity generates a HTML test report. On its homepage, the report offers a nice pie chart showing the test results of each feature category. The following image shows how this diagram currently looks like in our project.

{% image blog/blog-rat-serenity-results.png %}

We try to work test-driven, therefore there are a few test cases in a *pending* state (To do that, Serentity offers a @Pending annotation).
These tests are already written but will be skipped since the features they should test are not yet implemented. As soon as everything is in place, they can be activated.

You can click on a feature to see what kind of test cases are there. Each test case can consist of multiple steps which can be displayed in detail:

{% image blog/blog-rat-serenity-results-slideshow.png %}

In this test case we want to check if an image that was uploaded for a product is appearing in the product slideshow. The first step gives us a DemoShop (which can be newly craeted or was already used in other read-only test cases). The we take the first product from the product collection resource (*GET /products*) and upload the image. Finally we retrieve the product slideshow (*GET /products/{productId}/slideshow*) and check if the uploaded image is in there.



## Summary

RAT allows us to check the complete state of the REST API on an abritrary ePages installation just at the push of a button. We use it to partly automate our QA process and run it as last step of a developer installation via Jenkins to make sure everything went fine.

Currently we discuss how to include RAT in the Jenkins job that checks our pull requests GitHub. The challenge here is to choose the RAT branch that corresponds with the changes in the branch from the pull request.
