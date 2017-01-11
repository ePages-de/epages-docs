---
layout: post
title: "Mockify - A mocking framework for Perl"
date: "2016-02-23 08:00:02"
image: blog-header/mocking-bird.jpg
categories: tech-stories
authors: ["Christian B."]
---

When reading the title of this post, you may ask yourself why THE hell do they deal with Perl?
Don't worry.
There's a good reason.
Stay tuned and you'll see!

## Why developing a mocking framework for Perl

- Yes, Perl is a good old scripting Camel.
- Yes, we already started the new version of ePages based on a modern software stack, but our core is written in Perl and we have to live with this for a while.
- No, we cannot switch from one day to another to the new technology.
- No, writing NO tests is not an option.

We have to support the current core for a while.
Furthermore, we need to write unit tests in our legacy code base.
This should be as easy as possible, since Perl by itself is [confusing](https://media.ccc.de/v/32c3-7130-the_perl_jam_2) enough.

In order to achieve this, I created [**Mockify** *minimal mocking framework for perl*](https://github.com/ePages-de/Mockify).

## Why not using Test::MockObject directly

[Test::MockObject](http://search.cpan.org/~chromatic/Test-MockObject-1.20150527/README.pod) is a really smart package, but actually it is too smart.
One of its features is to add methods to packages which are not existing.
On the one hand this is very flexible, on the other hand it leads to a big problem.

Let's assume you have to mock a package in order to write a test.
In that mock you add a method which exists in this package.
You prove it by looking it up in the original package.
You write your test and it's all fine.
Later, another developer decides to *rename* or *delete* the method that you mocked previously.
If you run your tests now, all is fine.
But outside of your test environment your code will **die**, because the method your code is calling does not exist anymore.
It is unlikely to cover all these issues completely with integration tests.

For this reason *Mockify* verifies that the method you are trying to mock is actually existing on the affected package.
This was the starting point of *Mockify* and with the time I added more functionality to the framework.

{% highlight ruby %}
my $Mockify = Mockify->new('Package::Path::MyModule',['ParameterInConstructor']);
$Mockify->mock('myMethodName',sub {
  #Your code
});
my $MyModule = $Mockify->getMockObject();
{% endhighlight %}

### Return values

A mocked method is defined by a *name* and a *function pointer*, which will be called instead of the original method.
Most of the time you need a static return value ([stub](https://en.wikipedia.org/wiki/Method_stub)).
To save time and keep the code more clean, a method exists for this purpose.
The method expects two arguments.
The first argument is the name of the method to mock, the second argument is the return value.

{% highlight ruby %}
$Mockify->mock('myMethodName','the return value');
{% endhighlight %}

### Parameter checks

Perl does not care about the *amount of parameters* you handover to a method.
So you have to make sure that your mocked method was called with the correct amount of parameters.
Perl also does not care about the *order of the parameters*.
Your test has to ensure this, too.

In *Mockify* you can define the *type*, and additionally, the *value* you expect for every parameter.

{% highlight ruby %}
$Mockify->mock('myMethodName','the return value',['string',{'int' => 123}]);
{% endhighlight %}

Here we expect two arguments, one arbitrary string and one integer which has to be exactly 123.

### Collect meta data

Sometimes the parameters can change at runtime, so you cannot check this with parameter checks at call-time.
You have to verify this at a later stage in the test.
To provide this option *Mockify* stores the parameters in the mocked object.
*Mockify* provides several functions to access this information from the mocked object.

  - `GetParametersFromMockifyCall`
  - `GetCallCount`
  - `WasCalled`

### Method spy

Once it was possible to verify the parameters of a mocked method I missed this functionality for unmocked methods.
Inspired by other mocking frameworks I introduced the spy-functionality to *Mockify*.
A spied method keeps its original behaviour, but additionally provides the possibility to access its meta data.

{% highlight ruby %}
$Mockify->addMethodSpyWithParameterCheck('myMethodName', ['object',{'float' => 1.23}];
{% endhighlight %}

Here we expect two arguments, one arbitrary object and one float which has to be exactly 1.23.

## Summary

*Mockify* enables us to create readable, "refactor-able" unit-tests in a legacy software stack.
The investment to develop a mocking framework for our needs definitely payed off.
And yes, it feels really good to commit something, you can be very sure that it will not break the software.
