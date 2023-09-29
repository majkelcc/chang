chang_tty() {
  test -t 1 && echo "TTY" || echo "NO_TTY"
  test -t 1 && "$@"
}
