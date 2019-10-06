#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR
cd ..

set -e

# remove extra spaces
./scripts/remove-extra-spaces.sh

# check for lint errors
./s_nuxt_2nd.sh yarn run lint

# check for build or type errors
NODE_ENV=development ./s_nuxt_2nd.sh ./node_modules/.bin/nuxt build
