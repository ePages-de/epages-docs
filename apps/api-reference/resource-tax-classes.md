---
layout: page
key: api-resources-tax-classes
title: Tax-classes
---
<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shops-shopid-tax-classes(.*)-information$' %}
    {% if match %}
      <li class="resource-entry">
        <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
        <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
      </li>
    {% endif %}
  {% endfor %}
</ul>
