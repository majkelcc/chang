chang_compose_ps() {
  chang_compose ps --all --status running --status exited "$@"
}
