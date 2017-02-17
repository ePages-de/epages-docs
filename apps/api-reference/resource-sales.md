---
layout: page
key: api-resources-sales
title: Sales
---

The result of a purchase request by a customer of one or more products from a shop.
To request the sales of a shop, an order must be created and not rejected (rejectedOn=false).

{% assign global_key = page.key %}

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shopid-sales(.*)-information$' %}
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
