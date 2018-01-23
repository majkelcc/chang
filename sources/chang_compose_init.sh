chang_compose_init() {
  chang_check_env
  if [[ -z ${_CHANG_COMPOSE_INIT:-} ]]; then
    if $CHANG_SYNC_ENABLED; then
      chang_sync
    fi
    export _CHANG_COMPOSE_INIT=true
  fi
}