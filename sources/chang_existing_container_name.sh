chang_existing_container_name() {
  docker ps -a | grep -oE "[a-zA-Z0-9_-]+${CHANG_APP_HASH}${CHANG_BRANCH:+_$CHANG_BRANCH_HASH}-${1}-1" || true
}