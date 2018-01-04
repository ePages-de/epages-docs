#!/bin/sh

bundle install --without development

bundle exec jekyll build
