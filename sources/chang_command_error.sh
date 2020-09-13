chang_command_error() {
  if [[ $CHANG_LEVEL -eq 1 ]]; then
    printf $(chang_color_cmd_error) >&2
    echo -ne "chang ${@:2} returned $1 " >&2
    printf $(chang_color_reset) >&2
    printf "\n" >&2
  fi
  exit $1
}