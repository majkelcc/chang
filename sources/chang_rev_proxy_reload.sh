chang_rev_proxy_reload() {
  docker exec $CHANG_REV_PROXY_CONTAINER sh -c 'nginx -s reload 2>/dev/null'
}