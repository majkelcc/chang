chang_existing_container_name() {
  docker ps -a | grep -oE "[a-zA-Z0-9_-]+${CHANG_APP_HASH}_${1}_1" || true
}