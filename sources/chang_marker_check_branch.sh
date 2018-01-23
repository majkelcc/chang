chang_marker_check_branch() {
  IFS=, read -ra args <<< "${@}"
  local branch=$(chang_last_change_branch "${args[@]}")
  if test -n ${branch} && test -f ${CHANG_TMP_PATH}/branch_marks/$(chang_marker_filename "${args[@]}")_${branch}; then
    return 0
  else
    return 1
  fi
}
