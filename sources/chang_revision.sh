chang_revision() {
  (
    cd $CHANG_HOME
    git rev-parse --short HEAD
  )
}
