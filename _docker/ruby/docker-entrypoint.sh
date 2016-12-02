#!/bin/bash

# If any script fails then exit 1.
set -e

# Always own possibly mounted docker volumes (files on host).
# - exclude all dot files and dot folders in root dir.
for i in `find ${EPAGES_DOCS} -depth 1 \( ! -iname ".*" \)`; do
  chown -R root:root "${i}";
done

# If the first argument is test, build, index or serve
# then set exec to prepend with rake.
if [[ "${1}" =~ ^.*(test)|(build)|(index)|(serve)|(dev)|(fast_dev).*$ ]]; then
    set rake "${@}"
fi

# If the first argument is rake
# then set exec with all given args.
if [[ "${1}" == "rake" ]]; then
	bundle install
    set "${@}"
fi

# Execute defined arguments.
# This includes not ruby related args (e.g. `bash`).
exec "${@}"
