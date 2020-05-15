chang_service_network_alias() {
  service=$1
  echo -n "${CHANG_ENV_ID}_${service}"
}