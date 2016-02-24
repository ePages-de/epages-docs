#!/bin/bash

# If any script fails then exit 1.
set -e

# Own mounted docker volumes (files on host).
chown -R root:root ${EPAGES_DOCS}

# If the first argument is rake
# then set exec with all given args.
if [[ "${1}" = 'rake' ]]; then
    set "${@}"
fi

# If the first argument is test, build or index 
# then set exec to prepend with rake.
if [[ "${1}" =~ ^.*(test)|(build)|(index).*$ ]]; then
    set rake "${@}"
fi

# Execute defined arguments.
# This includes not ruby related args (e.g. `bash`).
exec "${@}"
