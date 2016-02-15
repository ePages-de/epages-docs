#!/bin/bash

set -e

# if not given
# just open bash
#
# if rake
# run rake in interactive bash
#
# if rake test
# run rake test in interactive bash
#
# if rake build
# ...
#
# if rake index
# ...

exec "${@}"
