---
layout: page
key: 1and1-api-resources
title: Resources
hot: true
---

This reference lists every resource currently available in the API. The whole definition in [RAML](http://raml.org/) format can be downloaded [here]({{ '/1and1/api-reference/api.raml' | prepend: site.baseurl }}).

* [Shop configuration](page:1and1-api-resources-shop-configuration)

# All resources

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^1and1-api-(.*)-information$' %}
    {% if match %}
      <li class="resource-entry">
        <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
        <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
      </li>
    {% endif %}
  {% endfor %}
</ul>
