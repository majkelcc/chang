chang_external_volume_name() {
  local volume=$1
  if [[ $volume == "chang" ]]; then
    echo -n $CHANG_SYNC_VOLUME
  elif [[ $volume =~ ^CHANG_SHARED_VOLUME ]]; then
    echo -n ${CHANG_APP_ID}_${volume#CHANG_SHARED_VOLUME_}
  else
    echo -n ${CHANG_ENV_ID}_$volume
  fi
}