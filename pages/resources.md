---
layout: page
title: Resources
category: api
hot: true
---

This reference lists every resource currently available in the API.

{% for page in site.pages %}
  <ul id="resource-list">
  {% if page.category == 'raml' %}
    <li class="resource-entry">
      <span class="label label-default">{{ page.raml_resource.method | upcase }}</span>
      <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.uri }}</a>
    </li>
  {% endif %}
  </ul>
{% endfor %}
