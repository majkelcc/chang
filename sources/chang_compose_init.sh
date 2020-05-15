chang_compose_init() {
  if [[ -z ${_CHANG_COMPOSE_INIT:-} ]]; then
    export _CHANG_COMPOSE_INIT=true

    if [[ $CHANG_SYNC_ENABLED == true ]]; then
      chang-sync >/dev/null
    fi

    if ! chang_compare_commit .chang; then
      chang_reload
      chang_init
      chang_update_commit .chang
    fi
  fi
}