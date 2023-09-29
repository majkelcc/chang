chang_clone() {
  git clone $1
  cd ${1##*/}
  chang start
}
