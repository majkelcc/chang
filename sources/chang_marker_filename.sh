chang_marker_filename() {
  printf ${CHANG_ENV_ID}_$(sed 's/[^a-zA-Z0-9._-]//g' <<< "${@}" | head -c 200)
}