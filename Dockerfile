# NOTE: needs to match base/yarn.sh
FROM node:8.11.3-alpine

ARG container_user_id
ARG s_base_name

ENV S_BASE_NAME=$s_base_name

RUN apk --no-cache add bash

RUN apk update && \
    apk upgrade && \
    apk add git

RUN apk add --no-cache --virtual .gyp \
        python \
        make \
        g++ \
    && npm install \
        [ your npm dependencies here ] \
    && apk del .gyp

# move node user away from uid 1000 in case our local user happens to have that uid
RUN apk --no-cache add shadow && mkdir /var/mail && \
  usermod -u 1234 node && \
  useradd --shell /bin/bash -u $container_user_id -o -c "" -m user-in-container

RUN mkdir -p /$s_base_name/src && mkdir -p /ext/node_modules

RUN yarn global add package-json-merge --network-timeout 80000

ADD ./base /$s_base_name
ADD ./scripts/entry.sh /entry.sh

RUN chown -R user-in-container:user-in-container /$s_base_name /ext && chmod +x /entry.sh

USER user-in-container

RUN cd /$s_base_name && tar xjof node_modules.tar.bz2

WORKDIR /$s_base_name/src
