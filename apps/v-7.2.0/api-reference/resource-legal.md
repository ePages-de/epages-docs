---
layout: page
key: api-resources-legal-v-7.2.0
title: Legal
---

Legal holds the shop's key information on contact information, privacy policy, terms and conditions, right and withdrawal and shipping information.

{% image legal-overview.png %}
{% assign global_key = page.key %}

<ul id="resource-list">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shops-shopid-legal(.*)-information$' %}
    {% assign visible = global_key | versioning_visible: page.url %}
    {% if match and visible %}
      <li class="resource-entry">
        <span class="http-method http-method-{{ page.raml_method.method | downcase }}">{{ page.raml_method.method }}</span>
        <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
      </li>
    {% endif %}
  {% endfor %}
</ul>
