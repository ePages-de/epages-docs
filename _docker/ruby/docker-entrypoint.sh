#!/bin/bash

# If any script fails then exit 1
set -e

# If the first argument is rake then run it
if [[ "${1}" = 'rake' ]]; then
    set "$@"
fi

# If the first argument is test, build or index then prepend it with rake
if [[ "${1}" =~ ^.*(test)|(build)|(index).*$ ]]; then
    set rake "$@"
fi

# If the argument is not related to ruby (e.g. `bash`) then run it as root
exec "${@}"
