chang_exec() {
  local service_name=${1}
  local running_container=$(chang_running_container_name $service_name)

  if [[ -n $running_container ]]; then
    chang_notice "Running \`${@:2}\` in ${service_name} container"
    test -t 1 && tty="--tty"
    docker exec -i ${tty:-} $running_container "${@:2}"
  else
    chang_notice "Running \`${@:2}\` in a new ${service_name} container..."
    chang_run $service_name "${@:2}"
  fi
}