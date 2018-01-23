chang_rev_proxy_reset() {
  local host=$1
  docker exec -i $CHANG_REV_PROXY_CONTAINER sh -c "grep -v ${host}.localhost /var/www/chang.html > /var/www/chang.html.tmp; mv /var/www/chang.html.tmp /var/www/chang.html"
  chang_rev_proxy_reload
}