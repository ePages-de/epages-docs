---
layout: page
key: api-resources-webhooks
title: Webhooks
---

Webhooks allow developers to build apps that receive near-real-time information about events that happen in ePages shops.
Instead of making constant API calls to check for specific changes on the shop, you can register webhooks.
For more information about webhooks and how to use them, [read here](page:apps-webhooks).

The following webhook resources are available:

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shopid-webhooks(.*)-information$' %}
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
