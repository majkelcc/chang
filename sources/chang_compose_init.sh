chang_compose_init() {
  if chang_memo CHANG_COMPOSE_INIT; then
    if [[ $CHANG_SYNC_ENABLED == true ]]; then
      chang-sync >/dev/null
    fi

    if ! chang_compare_commit .chang; then
      chang_reload
      chang_init
      chang_update_commit .chang
    fi

    last_branch_file=$CHANG_TMP_PATH/last_branch
    touch $last_branch_file
    last_branch=$(cat $last_branch_file)
    if [[ $CHANG_BRANCH != $last_branch ]]; then
      local running_containers=$(docker ps | grep -oE ${CHANG_APP_ID}_'[^[:space:]]*' | grep -v $CHANG_BRANCH_HASH)
      if [[ ! -z $running_containers ]]; then
        chang_notice "Switching to ${CHANG_BRANCH} branch"
        docker kill $running_containers
      fi
      printf "$CHANG_BRANCH" > $last_branch_file
    fi
  fi
}