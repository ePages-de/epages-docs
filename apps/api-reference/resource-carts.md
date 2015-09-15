---
layout: page
key: api-resources-carts
title: Carts
---

A cart allows users to pick products from a shop and store them to be bought now or at a later time.
The cart can contain products, variations and custom items.
All data added to a cart is stored and available as these data or an order is retrieved.
The cart also holds the feature for setting the billing address as well as the shipping address.

{% image carts-overview.png %}{% endimage %}

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shops-shopid-carts(.*)-information$' %}
    {% if match %}
      <li class="resource-entry">
        <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
        <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
      </li>
    {% endif %}
  {% endfor %}
</ul>
