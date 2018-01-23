chang_app_hash() {
  app_path=$1
  echo $app_path | shasum - | head -c 8
}