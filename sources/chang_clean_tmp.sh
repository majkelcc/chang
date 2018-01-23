chang_clean_tmp() {
  find ${CHANG_TMP_PATH} -mtime +${1:-7} -type f -delete
}