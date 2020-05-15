chang_running_container_name() {
  docker ps | grep -oE "[a-zA-Z0-9_-]+${CHANG_APP_HASH}${CHANG_BRANCH:+_$CHANG_BRANCH_HASH}_${1}_1" || true
}