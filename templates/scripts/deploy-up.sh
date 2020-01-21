#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR
cd ..

ENVIRONMENT=$1
ENV_FILE=env-$ENVIRONMENT
ZEIT_TOKEN=$2
ZEIT_TEAM=$3
ZEIT_ENV=$(cat $ENV_FILE | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ -e /g') # previous $(cat env-$1 | sed -z 's/\n/ -e /g') PLACEHOLDER_VAR=test

# bit of a hack to trick the nuxt/now-builder to do correct things
# - nuxt/now-builder only works correctly if nuxt.config.ts exists
# - BUT nuxt-typed-vuex will break locally with nuxt.config.ts in place (see https://github.com/danielroe/nuxt-typed-vuex/issues/29)
if [ -f nuxt.config.js ]; then mv nuxt.config.js nuxt.config.ts; fi

# and another hack to give more dependencies to nuxt/now-builder, that are for some reason required there...
cat package.json | jq '. * {"dependencies": {"typescript":"3.6.3","ts-loader":"6.2.1"}}' > package_tmp.json
mv package.json package_orig.json
mv package_tmp.json package.json

CLEANUP() {
  # clean up hacks
  mv nuxt.config.ts nuxt.config.js
  mv package_orig.json package.json
}
trap CLEANUP EXIT HUP INT QUIT PIPE TERM

./scripts/cbin/now \
  -t $ZEIT_TOKEN \
  $([ ! -z $ZEIT_TEAM ] && echo "-T $ZEIT_TEAM") \
  -e $ZEIT_ENV \
  -f \
  -A now.$ENVIRONMENT.json \
  deploy

./scripts/cbin/now \
  -t $ZEIT_TOKEN \
  $([ ! -z $ZEIT_TEAM ] && echo "-T $ZEIT_TEAM") \
  -A now.$ENVIRONMENT.json \
  alias
