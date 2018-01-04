#!/bin/sh

bundle install --without development

JEKYLL_ENV=production jekyll build
