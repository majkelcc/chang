chang_app_hash() {
  echo "$@" | shasum - | head -c 8
}