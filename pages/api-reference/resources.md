---
layout: page
title: Resources
category: api
hot: true
---

This reference lists every resource currently available in the ePages API. The whole definition in [RAML](http://raml.org/) format can be downloaded [here]({{ '/resources/api.raml' | prepend: site.baseurl }}).

<ul id="resource-list">
  {% for page in site.pages %}
    {% if page.category == 'raml' %}
      <li class="resource-entry">
        <span class="label label-default">{{ page.raml_method.method }}</span>
        <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
      </li>
    {% endif %}
  {% endfor %}
</ul>
