---
layout: docs
title: Postman Collection PDFs
key: postman-pdfs
---

# Postman Collection PDFs

This page provides download links to PDF documentation generated from Postman collections.

## Available Collections

{% assign pdf_files = site.static_files | where: "extname", ".pdf" %}
{% if pdf_files.size > 0 %}
  <ul>
  {% for file in pdf_files %}
    {% if file.path contains "postman_collection" %}
      <li>
        <a href="{{ file.path | prepend: site.baseurl }}" target="_blank">
          {{ file.name }}
        </a>
        <small>({{ file.modified_time | date: "%B %d, %Y" }})</small>
      </li>
    {% endif %}
  {% endfor %}
  </ul>
{% else %}
  <p>No PDF files found. Run <code>rake generate_postman_pdf</code> to generate PDF documentation.</p>
{% endif %}

## How to Generate PDFs

To generate PDF documentation from Postman collections:

```bash
# Generate PDFs for all collections
rake generate_postman_pdf

# Or build the site with PDFs included
rake build_with_pdf
```

## Manual Generation

You can also generate PDFs manually using the script:

```bash
ruby scripts/generate_postman_pdf.rb postman_collections/beyond.postman_collection.json
```

The generated PDF will include:
- Collection overview and table of contents
- Detailed request/response documentation
- Formatted JSON examples
- Professional styling optimized for print