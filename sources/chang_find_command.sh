chang_find_command() {
  local command_dir="${CHANG_PWD}/.chang/bin"
  local arg=("$@")
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
    chang_error "Command \`chang ${arg[@]:0:((level + 1))}\` not found! We looked all over the place in $command_dir/${1:-${command_dir##*/}}"
  fi
}
