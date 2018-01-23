chang_sync() {
  if [[ -z ${_CHANG_SYNC:-} ]]; then
    chang_notice "CHANG_SYNC!"
    chang-sync &>/dev/null
    export _CHANG_SYNC=true
  fi
}