chang_compare_branch() {
  IFS=, read -ra args <<< "${@}"
  local branch=$(chang_last_change_branch "${args[@]}")
  if test -n ${branch} && [[ $(cat "${CHANG_TMP_PATH}/state/branch_$(chang_marker_filename "${args[@]}")" 2>/dev/null) == ${branch} ]]; then
    return 0
  else
    return 1
  fi
}