chang_rev_proxy_join_network() {
  local network=$1
  if ! chang_rev_proxy_networks | grep -qw $network; then
    docker network connect $network $CHANG_REV_PROXY_CONTAINER
  fi
}