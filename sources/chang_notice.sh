chang_notice() {
  printf "\033[1K"
  printf "\r"
  printf "$(chang_color_notice)▷ " >&2
  echo -n "${@}" >&2
  printf "$(chang_color_reset)\n" >&2
}