# if not exists
chang_create_network() {
  local name=$1
  if test -z $(docker network ls -qf "name=^${name}$"); then
    docker network create "$name" >/dev/null 
  fi
}