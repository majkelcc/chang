chang_run_command() {
  if [[ $# -eq 0 ]]; then
    [[ -f ${CHANG_PWD}/.chang/bin/ps ]] && chang ps || chang_compose ps
    return $?
  fi

  command=($(chang_find_command "$@"))
  if [[ $CHANG_DEBUG == true ]]; then
    set -x
  fi
  bash $CHANG_SET $command "${@:$((${command[1]} + 1))}" || chang_command_error $? "$@"
}
