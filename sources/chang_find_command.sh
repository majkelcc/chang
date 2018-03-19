chang_find_command() {
  command_dir=".chang/bin"

  while [[ ! -z ${1:-} ]]; do
    test -d $command_dir/$1 || break
    command_dir+="/$1"
    shift
  done

  if [[ ! -z ${1:-} && -f $command_dir/$1 ]]; then
    echo "$command_dir/$1" "${@:2}"
  elif [[ -f $command_dir/${command_dir##*/} ]]; then
    echo "$command_dir/${command_dir##*/}" "${@:-}"
  else
    chang_error "Command not found in $command_dir/${@:-}"
  fi
}