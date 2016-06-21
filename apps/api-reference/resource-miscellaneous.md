---
layout: page
key: api-resources-miscellaneous
title: Miscellaneous
---
<ul id="resource-list">
  {% for page in site.pages %}
  {% assign misc = "currencies locales search start-page watched-products products-categories" | split: ' ' %}
    {% for category in misc %}
      {% if page.raml_resource.relative_uri contains category %}
        <li class="resource-entry">
          <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
          <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
        </li>
      {% endif %}
    {% endfor %}
  {% endfor %}
</ul>
