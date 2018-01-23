chang_rev_proxy_start() {
  networks=""
  for app in $(ls -1 $CHANG_HOME); do
    chang_create_network $(chang_app_network $app)
    networks="${networks} --network=$(chang_app_network $app)"
  done

  docker run -d \
    --name ${CHANG_REV_PROXY_CONTAINER} \
    -p ${CHANG_REV_PROXY_BIND}:${CHANG_REV_PROXY_PORT}:80 \
    $networks \
    $CHANG_REV_PROXY_IMAGE > /dev/null
}