chang_rev_proxy_stop() {
  if chang_rev_proxy_exists; then
    chang_rev_proxy_remove
  fi
}