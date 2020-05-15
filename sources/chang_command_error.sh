chang_command_error() {
  printf $(chang_color_cmd_error) >&2
  echo -ne "{${CHANG_LEVEL}} chang ${@:2} returned $1 " >&2
  printf $(chang_color_reset) >&2
  printf "\n" >&2
  exit 1
}