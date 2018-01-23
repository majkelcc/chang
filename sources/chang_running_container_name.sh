chang_running_container_name() {
  docker ps | grep -oE "[a-zA-Z0-9_-]+${CHANG_APP_HASH}_${1}_1" || true
}