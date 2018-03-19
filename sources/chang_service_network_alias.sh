chang_service_network_alias() {
  service=$1
  echo -n "${CHANG_APP_ID}_${service}"
}