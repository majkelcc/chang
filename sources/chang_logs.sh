chang_logs() {
  service=$1
  running_container=$(chang_running_container_name $service)
  if [[ -n $running_container ]]; then
    exec docker logs --follow --tail 1000 $running_container
  else
    existing_container=$(chang_existing_container_name $service)
    if [[ -n $existing_container ]]; then
      docker logs --tail 1000 $existing_container
    else
      exit 1
    fi
  fi
}