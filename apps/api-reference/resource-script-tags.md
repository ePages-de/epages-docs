---
layout: page
key: api-resources-script-tags
title: Script tags
---

Script tags provide URLs to remote JavaScript files that are loaded on full page loads on all pages of a shop's storefront as well as the order confirmation page.
This simplifies adding functionality to specific shop pages without touching theme templates.

When an app is uninstalled from a shop, all of the automatically generated script tags are removed along with it.

The following resources are available to work with script tags:

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shopid-script-tags(.*)-information$' %}
    {% if match %}
      <li class="resource-entry">
        <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
        <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
        {% if page.raml_method.description contains '*epages6' %}
          <span class='ep-label-6 ep-label'>ePages 6</span>
        {% endif %}
        {% if page.raml_method.description contains '*epagesNow' %}
          <span class='ep-label-now ep-label'>ePages Now</span>
        {% endif %}
      </li>
    {% endif %}
  {% endfor %}
</ul>
