chang_start() {
  chang_create_network $CHANG_NETWORK
  chang_compose_init

  (
    source $CHANG_TMP_PATH/environment
    while read l; do
      eval echo "$l"
    done < $CHANG_TMP_PATH/volumes | while read volume; do chang_create_volume $volume; done
  )

  if [[ $CHANG_REV_PROXY_ENABLED == true ]]; then
    chang_rev_proxy_start
    chang_rev_proxy_reset
    (
      source $CHANG_TMP_PATH/environment
      while read l; do
        eval echo "$l"
      done < $CHANG_TMP_PATH/proxy | while read proxy_app; do chang_rev_proxy_install $proxy_app; done
      chang_rev_proxy_reload
    )
  fi
}