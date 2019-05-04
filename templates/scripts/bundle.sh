#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR
cd ..

ENVIRONMENT=production
if [ ! -z $1 ]; then ENVIRONMENT=$1; fi
echo "Bundling for $ENVIRONMENT"

NODE_ENV=$ENVIRONMENT ./s_nuxt_2nd.sh yarn run build ${@:2}
