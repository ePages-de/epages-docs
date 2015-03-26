---
layout: page
key: api-resources-products
title: Product
---

<ul id="resource-list">
  {% for page in site.pages %}
    {% if page.category == 'raml' %}
      {% assign match = page.raml_resource.relative_uri | start_with: '/shops/{shopId}/products' %}
      {% if match %}
        <li class="resource-entry">
          <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
          <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
        </li>
      {% endif %}
    {% endif %}
  {% endfor %}
</ul>
