chang_memo() {
  name=$1
  memo=${CHANG_TMP_PATH}/${__CHANG_PID}_${name}
  if [ -f $memo ]; then
    return 1
  else
    touch $memo
    return 0
  fi
}