---
layout: page
key: api-resources
title: Resources
hot: true
---

This reference lists every resource currently available in the ePages API. The whole definition in [RAML](http://raml.org/) format can be downloaded [here]({{ '/resources/api.raml' | prepend: site.baseurl }}).

# Categories

* [Carts](page:api-resources-carts)
* [Categories](page:api-resources-categories)
* [Legal](page:api-resources-legal)
* [Products](page:api-resources-products)
* [Shipping method](page:api-resources-shipping-methods)

# All resources

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
