chang_compose() {
  chang_compose_init
  (
    export COMPOSE_PROJECT_NAME=$DOCKER_COMPOSE_PROJECT_NAME
    export COMPOSE_FILE=$DOCKER_COMPOSE_FILE
    source $CHANG_TMP_PATH/environment
    docker compose "$@"
  )
}