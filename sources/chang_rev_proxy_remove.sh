chang_rev_proxy_remove() {
  if chang_rev_proxy_exists; then
    docker rm -f $CHANG_REV_PROXY_CONTAINER >/dev/null
  fi
}
