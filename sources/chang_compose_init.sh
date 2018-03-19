chang_compose_init() {
  if ! chang_compare_commit .chang; then
    if ! chang_compare_commit .chang/chang_compose.yml; then
      chang_reload
    fi
    if [[ -z ${_CHANG_COMPOSE_INIT:-} ]]; then
      if $CHANG_SYNC_ENABLED; then
        chang_sync
      fi

      chang_create_network $CHANG_NETWORK

      (
        source $CHANG_TMP_PATH/environment
        while read l; do
          eval echo "$l"
        done < $CHANG_TMP_PATH/volumes | while read volume; do chang_create_volume $volume; done
      )
      (
        source $CHANG_TMP_PATH/environment
        while read l; do
          eval echo "$l"
        done < $CHANG_TMP_PATH/proxy | while read proxy_app; do chang_rev_proxy_install $proxy_app; done
      )
      export _CHANG_COMPOSE_INIT=true
    fi
    chang_update_commit .chang
  fi
}