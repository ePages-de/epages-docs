---
layout: docs
key: api-resources-producttypes
title: Product Types
---
{% assign global_key = page.key %}

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shopid-producttypes(.*)-information$' %}
    {% assign visible = global_key | versioning_visible: page.url %}
    {% if match and visible %}
      <li class="resource-entry">
        <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
        <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
        {% if page.raml_method.description contains '*epages6' %}
          <span class="ep-label-base ep-label">Base</span>
        {% endif %}
        {% if page.raml_method.description contains '*epagesNow' %}
          <span class="ep-label-now ep-label">Now</span>
        {% endif %}
      </li>
    {% endif %}
  {% endfor %}
</ul>
