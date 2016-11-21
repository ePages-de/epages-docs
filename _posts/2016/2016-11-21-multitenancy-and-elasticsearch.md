---
layout: post
title: "Multitenancy and Elasticsearch"
date: "2016-11-21 09:00:00"
image: blog-header/multitenant.jpg
categories: tech-stories
authors: ["Ulf S."]
---

A key requirement for our software stack at ePages is to deal with multitenancy.
This means that instead of providing an installation for every merchant (the tenant in our case), we have a single installation serving multiple merchants at the same time.

The first part of this blog post will explain multitenancy with its pros and cons, the second part will shed some light on solutions when using Elasticsearch.

## Why Multitenancy?

The main reasons to implement a multitenancy concept are efficiency and better scaling properties.
In the classic 1:1 hosting model you need to have your services up and running 100% of the time even if only 50% of the tenants are active at a given time.
You can mitigate that problem by running multiple installations on the same hardware, but every installation will have some fixed costs and this model is limited in terms of scalability.

The multitenant architecture usually has higher fixed costs for a single installation, but the resources are shared and each tenant adds considerably less overhead.

There are also other benefits:

- you don't need to spin up a new installation to add a new tenant
- you can usually add one almost instantaneously
- maintenance is easier because you do it for all tenants simultaneously

This all sounds great, but multitenancy comes with its own challenges.
A multitenancy architecture is not the cure-all for every application and scaling problem out there and there are some general drawbacks.

A major one is data isolation: you don't want to accidentally leak or mix sensitive information of different tenants.

Another downside is the complexity you introduce - the complexity of the system itself as well as the complexity the developer has to deal with when implementing features in a tenant context.
This depends on the frameworks you use and abstractions you introduce.

## Elasticsearch

As already mentioned, there are some challenges with multitenancy, especially when it comes to data isolation and reducing the development complexity overhead.

Since multitenancy is not a novel concept, a lot of frameworks and storage solutions have some support for multitenancy out of the box.
Elasticsearch and the frameworks we evaluated do not come with any such feature and in addition, the way to implement it is not as straightforward as it is for traditional databases.

There are two general ways to go about it, which are

1. One index per tenant
2. Shared index

### One index per tenant

The first option is a very simple concept, which is easy to implement.
It provides solid data isolation from a storage perspective and you can still query across multiple indices, if you need to.
This solution is sufficient for most cases.

Each index comes with some overhead and this can easily add up.
By introducing a new index per tenant, you are multiplying your index by the number of tenants `T` you have.
If you then introduce localization for `L` languages, you need to create a new index, because you want to use different, language-specific analyzers for the same field.
In each of those, you might have `O` different types of documents, which you might (or cannot) keep in the same index as well.
Considering that, you end up with `L * O * T` indices for one installation.
As an example, for 10,000 tenants, 10 types and 10 supported languages, you will need 1 million indices.

### Shared Index

To keep the amount of indices under control, you can share the same index for all tenants.
This would reduce the number of indices to 100 for the example mentioned above.

Elasticsearch provides some features that help dealing with multitenancy in a single index.

#### Bool / Filtered query

An obvious way to implement this is by wrapping queries into a [bool query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-bool-query.html) and filter by tenant.
This is very similar to what you might be used to with other databases and corresponding frameworks.

{% highlight javascript %}
POST /products/_search
{
  "query" : {
    "bool" : {
      "filter" : {
        "term" : { "tenantId" : "12345" }
      },
      // ...
    }
  }
}
{% endhighlight %}

This is a possible solution, but you would probably like to have some kind of framework support for that, otherwise you forget to wrap a query somewhere and end up exposing data across tenants.

#### Index alias

Another nifty feature you can use are [filtered aliases](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-aliases.html#filtered).

Filtered aliases basically enable you to do the same thing as with filtered queries by introducing an alias for every tenant.
This way you can deal with tenancy in a more transparent way.
You don't need to wrap every query yourself, you let Elasticsearch do it for you.

{% highlight javascript %}
POST /_aliases
{
  "actions" : [
    {
      "add" : {
         "index" : "products",
         "alias" : "products_12345",
         "filter" : { "term" : { "tenantId" : "12345" } }
      }
    }
  ]
}
{% endhighlight %}

{% highlight javascript %}
POST /products_12345/_search
{
  "query" : {
    // ...
  }
}
{% endhighlight %}

It is also more secure when it comes to data separation, because you will need to specify the index/alias you want to query.
Forgetting about the tenant will lead to the index not being found instead of retrieving the results for all tenants.

By delegating this responsibility to Elasticsearch, you can get rid of some complexity in your code, but you need to take care of creating and deleting these aliases.
In our architecture, a service emits events for shop activation/deactivation and we listen for those to create/delete aliases automatically.

Aliases are pretty lightweight, but in extreme cases this might still lead to performance issues.
If you create too many aliases, you increase the size of your cluster state and might introduce a new bottleneck.
The cluster state is transferred between nodes on every update and includes index, alias and mapping information.

Another issue with using a shared index in general, is that there is no complete data separation for scoring.
The [inverse document frequency](https://en.wikipedia.org/wiki/Tf%E2%80%93idf#Inverse_document_frequency), which is part of the scoring algorithm, is calculated across all documents.
This means that documents of different tenants influence the scoring of results.

This might be undesired, because ordering of results might "magically" change without the tenant having changed anything.
It might also be possible to carefully craft documents and queries to derive information about other tenants.

## Conclusion

Choosing a strategy and finding the right configuration for a multitenancy concept is not a straightforward endeavour.

Every case has different demands, but Elasticsearch provides a nice way to implement this using aliases.
They provide a powerful abstraction, which makes development easier, less error-prone and generally scales pretty well.
