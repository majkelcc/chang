chang_rev_proxy_start() {
  if ! chang_rev_proxy_running; then
    chang_notice "Starting chang-rev-proxy"
    chang_rev_proxy_remove
    docker run -d \
      --name ${CHANG_REV_PROXY_CONTAINER} \
      -p ${CHANG_REV_PROXY_BIND}:${CHANG_REV_PROXY_PORT}:80 \
      -p ${CHANG_REV_PROXY_BIND}:443:443 \
      -p 8080-8090:8080-8090 \
      $CHANG_REV_PROXY_IMAGE > /dev/null
  fi
}