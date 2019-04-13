#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR
cd ..

ENVIRONMENT=$1
ENV_FILE=env-$ENVIRONMENT
ZEIT_TOKEN=$2
ZEIT_TEAM=saavu-$ENVIRONMENT
ZEIT_ENV=$(cat $ENV_FILE | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ -e /g') # previous $(cat env-$1 | sed -z 's/\n/ -e /g') PLACEHOLDER_VAR=test

# Prepare dockerized now-cli
if [ ! -d ./scripts/cbin/now_d/node_modules ]; then
  ./scripts/cbin/now build-node-modules
fi

# Merge package.jsons, the local copy overwrites
rm -rf _to_deploy
mkdir _to_deploy
MKTMP=$(mktemp)
jq -s 'reduce .[] as $d ({}; . *= $d)' ./s_base/s_nuxt_2nd/base/package.json ./package.json > merged-package.json
jq -r ".scripts[\"now-build\"] = \"npm run build\"" merged-package.json > "$MKTMP" && mv "$MKTMP" merged-package.json
jq -r ".scripts[\"build\"] = \"NODE_ENV=$ENVIRONMENT nuxt build\"" merged-package.json > "$MKTMP" && mv "$MKTMP" merged-package.json

# collect all the files required to make a deployment under _to_deploy
mv merged-package.json _to_deploy/package.json
mkdir -p _to_deploy/dist/generated
cp nuxt.config.js _to_deploy/
cp tsconfig.json _to_deploy/
cp .eslintrc.js _to_deploy/
cp .prettierrc.js _to_deploy/
cp now.$ENVIRONMENT.json _to_deploy/
cp -a src _to_deploy

cd _to_deploy

../scripts/cbin/now \
  -t $ZEIT_TOKEN \
  -T $ZEIT_TEAM \
  -e $ZEIT_ENV \
  -f \
  -A now.$ENVIRONMENT.json \
  deploy

../scripts/cbin/now \
  -t $ZEIT_TOKEN \
  -T $ZEIT_TEAM \
  -A now.$ENVIRONMENT.json \
  alias
