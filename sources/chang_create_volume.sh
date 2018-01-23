# if not exists
chang_create_volume() {
  local name=$1
  if ! docker volume ls -q | grep -q "^${name}$"; then
    docker run --rm \
      --entrypoint="" \
      --volume "${name}":/volume \
      ${CHANG_MIN_IMAGE} \
      chown ${CHANG_UID}:${CHANG_GID} /volume
  fi
}