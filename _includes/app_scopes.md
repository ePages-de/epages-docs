<table id="resource-list">
  <thead>
    <th>App scope</th>
    <th>Used for</th>
  </thead>
  <tbody>
    {% for app_scope in site.app_scopes %}
      <tr>
        <td style="vertical-align: baseline; padding-top: 18px;"><span>{{ app_scope }}</span></td>
        <td>
          {% assign match = page.key | regex_match: '^apps-(.*)' %}
          {% for page in site.pages %}
            {% if page.raml_method.secured_by contains app_scope %}
              {% unless page.url contains '/v-' %}
                <li class="resource-entry" style="width: 710px;">
                  <span>{{ page.raml_method.method }}</span>
                  <a href="{{ page.url | prepend: site.baseurl }}">{{ page.raml_resource.relative_uri }}</a>
                </li>
              {% endunless %}
            {% endif %}
          {% endfor %}
        </td>
      </tr>
    {% endfor %}
  </tbody>

</table>
