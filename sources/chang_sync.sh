chang_sync() {
  if [[ -z ${_CHANG_SYNC:-} ]]; then
    chang-sync >/dev/null
    export _CHANG_SYNC=true
  fi
}