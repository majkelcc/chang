chang_update_branch() {
  IFS=, read -ra args <<< "${@}"
  mkdir -p ${CHANG_TMP_PATH}/state
  chang_last_change_branch "${args[@]}" > "${CHANG_TMP_PATH}/state/branch_$(chang_marker_filename "${args[@]}")"
}