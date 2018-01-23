chang_rev_proxy_exists() {
  ! test -z $(docker ps -aq --filter name=^/${CHANG_REV_PROXY_CONTAINER}$)
}
