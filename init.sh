#!/bin/bash
S_BASE_ROOT="$(cd "$(dirname "$0")" && cd .. && pwd)"
cd $S_BASE_ROOT

if [ "$(basename $(echo $S_BASE_ROOT))" != "s_base" ]; then
  echo "Can't run from this directory."
  exit 1
fi

function fetch {
  NAME=$1
  VERSION=$2
  rm -rf ./$NAME
  git clone --single-branch -b $VERSION https://github.com/saavuio/$NAME
  PROJECT_ROOT_PATH=.. ./$NAME/scripts/after_fetch.sh
}

function build {
  PROJECT_ROOT_PATH=.. ./$NAME/scripts/docker_build.sh
  PROJECT_ROOT_PATH=.. ./$NAME/scripts/after_build.sh
}

# -- s_nuxt_2nd
if [ ! -d s_nuxt_2nd ] || [ -z $OBF ]; then
  fetch "s_nuxt_2nd" "v1"
  build "s_nuxt_2nd"
fi

