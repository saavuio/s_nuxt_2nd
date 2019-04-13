#!/bin/bash
if [ -z $PROJECT_ROOT_PATH ]; then
  echo "PROJECT_ROOT_PATH not provided"
  exit 1
fi

VERSION=v1
rm -rf s_nuxt_2nd_cache
git clone --single-branch -b $VERSION https://github.com/saavuio/s_nuxt_2nd_cache
cp s_nuxt_2nd_cache/node_modules.tar.bz2 s_nuxt_2nd/base

# folders required
mkdir ${PROJECT_ROOT_PATH}/src 2> /dev/null
mkdir ${PROJECT_ROOT_PATH}/dist 2> /dev/null
mkdir ${PROJECT_ROOT_PATH}/.webpack-cache 2> /dev/null
mkdir ${PROJECT_ROOT_PATH}/.nuxt 2> /dev/null
mkdir ${PROJECT_ROOT_PATH}/src/pages 2> /dev/null
if [ ! -f ${PROJECT_ROOT_PATH}/src/pages/index.vue ]; then
  printf "<template>\n  <span>Hi.</span>\n</template>\n" > ${PROJECT_ROOT_PATH}/src/pages/index.vue
fi

# link to self
cp ./s_nuxt_2nd/templates/s_nuxt_2nd.sh ${PROJECT_ROOT_PATH}

DATE=`date '+%Y-%m-%d_%H%M%S'`
STASH_DIR=_stash_${DATE}
mkdir $STASH_DIR

# scripts
cp -a ${PROJECT_ROOT_PATH}/scripts $STASH_DIR 2> /dev/null
rm -r ${PROJECT_ROOT_PATH}/scripts
cp -a ./s_nuxt_2nd/templates/scripts ${PROJECT_ROOT_PATH}/scripts

# .gitignore skel
cp ${PROJECT_ROOT_PATH}/.gitignore $STASH_DIR 2> /dev/null
rm ${PROJECT_ROOT_PATH}/.gitignore
cp ./s_nuxt_2nd/templates/gitignore ${PROJECT_ROOT_PATH}/.gitignore

# env-development skel
if [ ! -f ${PROJECT_ROOT_PATH}/env-development ]; then
  cp ./s_nuxt_2nd/templates/env-development ${PROJECT_ROOT_PATH}/env-development
fi
# package_app.json skel
if [ ! -f ${PROJECT_ROOT_PATH}/package_app.json ]; then
  echo "{}" > ${PROJECT_ROOT_PATH}/package_app.json
fi
