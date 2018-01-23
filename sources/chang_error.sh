chang_error() {
  printf "$(chang_color_error)⚡️  ${@}$(chang_color_reset)\n" >&2
  exit 1
}