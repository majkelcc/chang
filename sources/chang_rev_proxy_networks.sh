chang_rev_proxy_networks() {
  docker inspect --format '{{range $key, $value := .NetworkSettings.Networks}}{{$key}} {{end}}' $CHANG_REV_PROXY_CONTAINER
}