chang_find_command() {
  command_dir=".chang/bin"

  local level=0

  while [[ ! -z ${1:-} ]]; do
    test -d $command_dir/$1 || break
    command_dir+="/$1"
    shift
    ((level++))
  done

  if [[ ! -z ${1:-} && -f $command_dir/$1 ]]; then
    ((level++))
    echo "$command_dir/$1" $level
  elif [[ -f $command_dir/${command_dir##*/} ]]; then
    echo "$command_dir/${command_dir##*/}" $level
  else
    chang_error "Command not found! We looked all over the place in $command_dir/${@:-}"
  fi
}
