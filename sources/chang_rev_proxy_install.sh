chang_rev_proxy_install() {
  local network=$1
  local host=$2
  local port=$3
  local target_host=$(chang_service_network_alias $4)
  local target_port=$5

  local https_port=443
  [[ $port != $CHANG_REV_PROXY_PORT ]] && https_port=$port

  chang_rev_proxy_join_network $network

  docker exec -i $CHANG_REV_PROXY_CONTAINER sh -c "cat - > /nginx.d/chang/${host}_${port}.conf" <<CONF
server {
  set \$target $target_host:$target_port;
  keepalive_timeout 0;

  proxy_busy_buffers_size 512k;
  proxy_buffers 4 512k;
  proxy_buffer_size 256k;

  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_prefer_server_ciphers on;
  ssl_dhparam /dhparam.pem;
  ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA';
  ssl_session_timeout 1d;
  ssl_session_cache shared:SSL:50m;

  ssl_certificate /nginx-selfsigned.crt;
  ssl_certificate_key /nginx-selfsigned.key;

  server_name .$host.localhost;
  listen $https_port ssl http2;
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

  [[ $port == $CHANG_REV_PROXY_PORT ]] && docker exec -i $CHANG_REV_PROXY_CONTAINER sh -c "cat - >> /nginx.d/chang/${host}_${port}.conf" <<CONF
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
}