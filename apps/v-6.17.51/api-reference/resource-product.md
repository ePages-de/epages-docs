---
layout: page
key: api-resources-products-v-6.17.51
title: Products
---

A product is an individual item for sale that belongs to the inventory of a shop.
This item can be added to the shopping basket and then sold using the checkout.
Specific items can also be assigned to a category.
**Note**: In case of errors for certain products or unknown product IDs, the product collections will **not** return errors, but skip the products in question.

{% image products-overview.png %}
{% assign global_key = page.key %}

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shops-shopid-(.*)products(.*)-information' %}
    {% assign exceptions = "product-category-assignment" | split: ' ' %}
    {% assign visible = global_key | versioning_visible: page.url %}
    {% if match and visible %}
      <li class="resource-entry">
        <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
        <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
      </li>
    {% endif %}
    {% for category in exceptions %}
      {% if (page.raml_resource.relative_uri contains category) and visible %}
        <li class="resource-entry">
          <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
          <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
        </li>
      {% endif %}
    {% endfor %}
  {% endfor %}
</ul>
