chang_check_env() {
  if [[ -z ${_CHANG_CHECK_ENV:-} ]]; then
    if chang_env_changed; then
      chang_notice "ENV CHANGED!"
      chang_reload
    fi
    export _CHANG_CHECK_ENV=true
  fi
}