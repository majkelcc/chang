chang_compare_commit() {
  IFS=, read -ra args <<< "${@}"
  local commit=$(chang_last_change_commit "${args[@]}")
  if test -n ${commit} && [[ $(cat "${CHANG_TMP_PATH}/state/commit_$(chang_marker_filename "${args[@]}")" 2>/dev/null) == ${commit} ]]; then
    return 0
  else
    return 1
  fi
}