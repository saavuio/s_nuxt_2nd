#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR

GIT_SHA_SHOULD_BE="LATEST"
GIT_SHA_IS=$(cd s_base/s_nuxt_2nd && git log --pretty=format:'%h' -n 1)

if [ "$GIT_SHA_SHOULD_BE" != "LATEST" ]; then
  if [ "$GIT_SHA_IS" != "$GIT_SHA_SHOULD_BE" ]; then
    echo "Base updated. Run ./s_base/s_nuxt_2nd/init.sh"
    ./s_base/s_nuxt_2nd/init.sh
  fi
fi

./s_base/s_nuxt_2nd/scripts/docker_run.sh ${@:1}
