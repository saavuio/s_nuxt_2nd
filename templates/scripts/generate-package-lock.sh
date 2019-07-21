#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR
cd ..

echo "fetching stuff from inside the container."
IMAGE_ID=s_nuxt_2nd
RUNNER=./${IMAGE_ID}.sh
if [ ! -f $RUNNER ]; then exit 1; fi
CONTAINER_NAME=${IMAGE_ID}_tmp
CONTAINER_NAME=$CONTAINER_NAME NO_TTY=1 $RUNNER eval "sleep 6000;" &
#
echo "run container..."
until docker ps | grep "$CONTAINER_NAME" > /dev/null; do
  sleep 2
  echo "waiting for container to start..."
done
echo "container started!"
#
echo "copy files from container..."
#
docker exec ${CONTAINER_NAME} npm install
docker cp ${CONTAINER_NAME}:/$IMAGE_ID/package-lock.json ./
#
echo "stop container..."
docker stop ${CONTAINER_NAME}
#

echo "done."
