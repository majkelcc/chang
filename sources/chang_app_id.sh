chang_app_id() {
  app_name=$1
  app_hash=$2
  echo -n "chang_${app_name}_${app_hash}"
}