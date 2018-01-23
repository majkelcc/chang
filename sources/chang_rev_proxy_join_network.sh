chang_rev_proxy_join_network() {
  local network=$1
  docker network connect $network $CHANG_REV_PROXY_CONTAINER &>dev/null || true
}