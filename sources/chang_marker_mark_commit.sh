chang_marker_mark_commit() {
  IFS=, read -ra args <<< "${@}"
  mkdir -p ${CHANG_TMP_PATH}/commit_marks
  local commit=$(chang_last_change_commit "${args[@]}")
  touch ${CHANG_TMP_PATH}/commit_marks/$(chang_marker_filename "${args[@]}")_${commit}
}