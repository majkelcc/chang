chang_command_error() {
  printf "$(chang_color_cmd_error)chang ${@:2} returned $1$(chang_color_reset)\n" >&2
  exit 1
}