chang_marker_filename() {
  "${CHANG_APP_HASH}_$(sed 's/[^a-zA-Z0-9._-]//g' <<< "${@}" | head -c 200)"
}