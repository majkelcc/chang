chang_compose_init() {
  if [[ -z ${_CHANG_COMPOSE_INIT:-} ]]; then
    if $CHANG_SYNC_ENABLED; then
      chang-sync >/dev/null
    fi
    if ! chang_compare_commit .chang; then
      if ! chang_compare_commit .chang/chang_compose.yml; then
        chang_reload
        chang_start
      fi
      chang_update_commit .chang
    fi
    export _CHANG_COMPOSE_INIT=true
  fi
}