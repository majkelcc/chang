chang() {
  (
    export CHANG_LEVEL=$((CHANG_LEVEL+1))
    chang_run_command "$@"
  )
}