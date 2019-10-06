#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR
cd ..

RESOURCES_DIR=/var/tmp/sharedsh-resources

ACTION=$1
PACKAGE=$2

if [ -z $1 ]; then echo "provide import or export as first parameter"; exit 1; fi
if [ -z $2 ]; then echo "provide package name as second parameter"; exit 1; fi

if [ "$ACTION" = "import" ]; then
  mkdir -p ./src/shared/$PACKAGE
  /bin/cp -Larf $RESOURCES_DIR/$PACKAGE/* ./src/shared/$PACKAGE
fi

if [ "$ACTION" = "export" ]; then
  /bin/cp -Larf ./src/shared/$PACKAGE/* $RESOURCES_DIR/$PACKAGE
fi
