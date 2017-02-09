---
layout: page
key: api-resources-carts-v-7.3.0
title: Carts
---

A cart allows users to pick products from a shop and store them to be bought now or at a later time.
The cart can contain products, variations and custom items.
All data added to a cart is stored and available as these data or an order is retrieved.
The cart also holds the feature for setting the billing address as well as the shipping address.

{% assign global_key = page.key %}
{% image carts-overview.png %}

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shops-shopid-carts(.*)-information$' %}
    {% assign visible = global_key | versioning_visible: page.url %}
    {% if match and visible %}
      <li class="resource-entry">
        <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
        <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
      </li>
    {% endif %}
  {% endfor %}
</ul>
