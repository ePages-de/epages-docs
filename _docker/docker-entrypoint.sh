#!/bin/bash

set -e

# if not given
# just run rake

# if bash 
# then open interactive bash

# if rake
# then run rake test in interactive bash

# if rake test
# then run rake test in interactive bash

# if rake build
# then run rake build in interactive bash

# if rake index
# then run rake index in interactive bash

exec "${@}"
