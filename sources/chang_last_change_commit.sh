chang_last_change_commit() {
  IFS=', ' read -ra args <<< "${@}"
  git log -n1 --oneline "${args[@]}" 2>/dev/null | awk '{print $1;}'
}