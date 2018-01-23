chang_marker_mark_branch() {
  IFS=, read -ra args <<< "${@}"
  mkdir -p ${CHANG_TMP_PATH}/branch_marks
  local branch=$(chang_last_change_branch "${args[@]}")
  touch ${CHANG_TMP_PATH}/branch_marks/$(chang_mark_filename "${args[@]}")_${branch}
}