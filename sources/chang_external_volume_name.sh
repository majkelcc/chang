chang_external_volume_name() {
  local volume=$1
  if [[ $volume == "chang" ]]; then
    echo -n $CHANG_SYNC_VOLUME
  else
    echo -n ${CHANG_ENV_ID}_$volume
  fi
}