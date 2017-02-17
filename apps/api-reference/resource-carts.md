---
layout: page
key: api-resources-carts
title: Carts
---

A cart allows users to pick products from a shop and store them to be bought now or at a later time.
The cart can contain products, variations and custom items.
All data added to a cart is stored and available as these data or an order is retrieved.
The cart also holds the feature for setting the billing address as well as the shipping address.

When creating a cart, the [response header](page:apps-response-headers) contains a cart token `X-ePages-Cart-Token`.
Without that token you cannot operate on carts.
Any further request needs to contain the cart token in the [request header](page:apps-request-headers) `X-ePages-Cart-Token`.


{% assign global_key = page.key %}
{% image carts-overview.png %}

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shopid-carts(.*)-information$' %}
    {% assign visible = global_key | versioning_visible: page.url %}
    {% if match and visible %}
      <li class="resource-entry">
        <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
        <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
        {% if page.raml_method.description contains '*epages6' %}
          <span class="ep-label-6 ep-label">ePages 6</span>
        {% endif %}
        {% if page.raml_method.description contains '*epagesNow' %}
          <span class="ep-label-now ep-label">ePages Now</span>
        {% endif %}
      </li>
    {% endif %}
  {% endfor %}
</ul>
