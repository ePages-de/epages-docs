---
layout: page
key: api-resources-miscellaneous
title: Miscellaneous
---
{% assign global_key = page.key %}

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign visible = global_key | versioning_visible: page.url %}
    {% if visible %}
      {% assign misc = "currencies locales search start-page watched-products" | split: ' ' %}
        {% for category in misc %}
          {% if page.raml_resource.relative_uri contains category %}
            <li class="resource-entry">
              <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
              <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
            </li>
          {% endif %}
        {% endfor %}
      {% endif %}
  {% endfor %}
</ul>
