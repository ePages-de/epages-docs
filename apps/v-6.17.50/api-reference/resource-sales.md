---
layout: page
key: api-resources-sales-v-6.17.50
title: Sales
---

The result of a purchase request by a customer of one or more products from a shop.
To request the sales of a shop, an order must be created and not rejected (rejectedOn=false).

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shops-shopid-sales(.*)-information$' %}
    {% if match %}
      <li class="resource-entry">
        <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
        <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
      </li>
    {% endif %}
  {% endfor %}
</ul>
