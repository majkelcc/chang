chang_app_hash() {
  echo "$@" | ${CHANG_SHASUM} - | head -c 6
}