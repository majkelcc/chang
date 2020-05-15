chang_error() {
  printf $(chang_color_error) >&2
  printf 🔥 >&2
  echo -ne " ${@} " >&2
  printf $(chang_color_reset) >&2
  printf 🔥 >&2
  printf "\n" >&2
  exit 1
}