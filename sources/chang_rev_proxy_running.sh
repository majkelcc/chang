chang_rev_proxy_running() {
  ! test -z $(docker ps -q --filter name=^/${CHANG_REV_PROXY_CONTAINER}$)
}