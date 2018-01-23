chang_current_branch() {
  git branch | grep \* | cut -d ' ' -f2-
}