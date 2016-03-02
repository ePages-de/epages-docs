#!/bin/bash

# If any script fails then exit 1.
set -e

# Always own possibly mounted docker volumes (files on host).
chown -R root:root ${EPAGES_DOCS}

# If the first argument is test, build, index or serve 
# then set exec to prepend with rake.
if [[ "${1}" =~ ^.*(test)|(build)|(index)|(serve).*$ ]]; then
    set rake "${@}"
fi

# If the first argument is rake
# then set exec with all given args.
if [[ "${1}" == "rake" ]]; then
    # Make sure new gems of the mounted local repo are added.
    bundle install
    # Test the syntax of all files.
    bundle exec rake test
    set "${@}"
fi

# Execute defined arguments.
# This includes not ruby related args (e.g. `bash`).
exec "${@}"
