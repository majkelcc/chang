chang_exec() {
  local service_name=${1}
  local running_container=$(chang_running_container_name $service_name)

  if [[ -n $running_container ]]; then
    docker exec -it $running_container "${@:2}"
  else
    chang_error "chang_exec: ${service_name} container is not running"
  fi
}