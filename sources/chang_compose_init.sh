chang_compose_init() {
  if [[ -z ${_CHANG_COMPOSE_INIT:-} ]]; then
    export _CHANG_COMPOSE_INIT=true

    if [[ $CHANG_SYNC_ENABLED == true ]]; then
      chang-sync >/dev/null
    fi

    local branch_marker_file=$CHANG_TMP_PATH/current_branch
    touch $branch_marker_file

    local current_branch=$(chang_current_branch)
    local last_used_branch=$(cat $branch_marker_file)
    if [[ $current_branch != $last_used_branch ]]; then
      (
        export COMPOSE_PROJECT_NAME=$(chang_app_id $CHANG_APP_NAME $CHANG_APP_HASH)${last_used_branch:+_$(chang_app_hash $last_used_branch)}
        chang_compose down -t 0
      )
      chang_reload
      chang_init
      printf $current_branch > $branch_marker_file
    fi
  fi
}