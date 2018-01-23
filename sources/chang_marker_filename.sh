chang_marker_filename() {
  sed 's/[^a-zA-Z0-9._-]//g' <<< "${@}" | head -c 200
}