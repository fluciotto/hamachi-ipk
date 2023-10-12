#!/usr/bin/env bash

HAMACHI=logmein-hamachi-2.1.0.203-x64
WORK_DIR=./work

[ ! -d "${WORK_DIR}" ] && mkdir ${WORK_DIR}

if [ ! -f "${WORK_DIR}/hamachid" ]; then
  curl -s https://vpn.net/installers/${HAMACHI}.tgz | tar xz -C /tmp
  cp /tmp/${HAMACHI}/hamachid ${WORK_DIR}/hamachid
  cp /tmp/${HAMACHI}/hamachid ${WORK_DIR}/hamachi
fi

if [ ! -f "${WORK_DIR}/hamachid.static" ]; then
  docker run -it --rm \
    -v ./work:/work \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    fluciotto/staticx \
    sh -c "staticx hamachid hamachid.static && chmod 755 hamachid.static"
fi

if [ ! -f "${WORK_DIR}/hamachi.static" ]; then
  docker run -it --rm \
    -v ./work:/work \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    fluciotto/staticx \
    sh -c "staticx hamachi hamachi.static && chmod 755 hamachi.static"
fi
