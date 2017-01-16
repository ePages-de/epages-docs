---
layout: page
key: api-resources-categories-v-7.2.0
title: Categories
---

A collection of product categories of a shop.

{% assign global_key = page.key %}

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shops-shopid-categories(.*)-information$' %}
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
