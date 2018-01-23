chang_update_commit() {
  IFS=, read -ra args <<< "${@}"
  mkdir -p ${CHANG_TMP_PATH}/state
  chang_last_change_commit "${args[@]}" > "${CHANG_TMP_PATH}/state/commit_$(chang_marker_filename "${args[@]}")"
}