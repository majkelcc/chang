chang_rev_proxy_install() {
  local network=$1
  local host=$2
  local port=$3
  local target_host=$(chang_service_network_alias $4)
  local target_port=$5

  chang_rev_proxy_join_network $network

  docker exec -i $CHANG_REV_PROXY_CONTAINER sh -c "cat - > /nginx.d/chang/${host}_${port}.conf" <<CONF
server {
  set \$target $target_host:$target_port;
  keepalive_timeout 0;

  server_name .$host.localhost;
  listen $port;
  client_max_body_size 1G;

  location / {
    proxy_pass_request_headers on;
    error_page 502 @offline;
    proxy_pass http://\$target;
  }

  location @offline {
    return 502 "#502 Bad gateway: it looks like ${host} app is not running";
  }
}
CONF

  docker exec -i $CHANG_REV_PROXY_CONTAINER sh -c "cat - >> /var/www/chang.html && cd /var/www && sort -u chang.html > chang.html.tmp; mv chang.html.tmp chang.html" <<CONF
  <p><a href="//${host}.localhost:${port}">${host}.localhost:${port}</a></p>
CONF

  docker exec -i $CHANG_REV_PROXY_CONTAINER sh -c "cat - > /nginx.d/chang/chang.dev" <<CONF
  server {
    listen 80;
    server_name localhost;

    location / {
      root /var/www;
      index chang.html;
    }
  }
CONF

  chang_rev_proxy_reload
}