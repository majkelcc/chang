chang_last_change_branch() {
  IFS=', ' read -ra args <<< "${@}"
  git log -n1 --oneline "${args[@]}" | awk '{print $2;}'
}