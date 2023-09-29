chang_debug() {
  service=$1
  chang_compose kill $service || true
  chang_compose run --rm --service-ports --use-aliases $service
}