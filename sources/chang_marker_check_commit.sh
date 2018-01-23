chang_marker_check_commit() {
  IFS=, read -ra args <<< "${@}"
  local commit=$(chang_last_change_commit "${args[@]}")
  if test -n ${commit} && test -f ${CHANG_TMP_PATH}/commit_marks/$(chang_marker_filename "${args[@]}")_${commit}; then
    return 0
  else
    return 1
  fi
}