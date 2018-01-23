chang_install() {
  mkdir -p ${CHANG_HOME}
  rm -f ${CHANG_HOME}/"${CHANG_APP_NAME}"
  ln -s "${CHANG_PWD}" ${CHANG_HOME}/"${CHANG_APP_NAME}"
  if [[ ${CHANG_REV_PROXY_ENABLED} ]]; then
    hal-rev-proxy install $CHANG_APP_NAME $CHANG_APP_PORT
  fi
}