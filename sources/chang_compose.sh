chang_compose() {
  chang_compose_init
  (
    export COMPOSE_FILE=$CHANG_TMP_PATH/docker-compose.yml
    source $CHANG_TMP_PATH/environment
    docker-compose "$@"
  )
}