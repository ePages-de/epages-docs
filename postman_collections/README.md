# Postman Collections

This directory contains Postman collection files for the ePages APIs.

## Current Collections

- `beyond.postman_collection.json` - Beyond REST API collection

## Generating PDF Documentation

You can generate PDF documentation from the Postman collections using the following methods:

### Using Rake Task

```bash
rake generate_postman_pdf
```

This will process all JSON files in the `postman_collections` directory and generate PDF documentation in the `_site` directory.

### Using the Script Directly

```bash
ruby scripts/generate_postman_pdf.rb postman_collections/beyond.postman_collection.json [output_directory]
```

The output directory defaults to `_site` if not specified.

## Generated PDF Features

The generated PDF documentation includes:

- Collection overview with name, version, and schema information
- Table of contents with links to all requests
- Detailed request information including:
  - HTTP method and URL
  - Request headers
  - Request body (formatted JSON)
  - Response examples with headers and body
- Professional styling optimized for print

## Requirements

- `wkhtmltopdf` must be installed on the system
- Ruby with JSON and ERB support

## Output

Generated PDFs are saved with the same name as the collection file (e.g., `beyond.postman_collection.pdf`).