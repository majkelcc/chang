#!/usr/bin/env ruby

require 'yaml'
require 'set'
require 'json'

def env(key)
  ENV.fetch key
end

def chang_service_network_alias(name)
  `/usr/bin/env bash ${CHANG_SET} -c "chang_service_network_alias #{name}"`.chomp
end

def chang_external_volume_name(name)
  `/usr/bin/env bash ${CHANG_SET} -c "chang_external_volume_name #{name}"`.chomp
end

def chang_error(msg)
  `chang_error #{msg}`
  exit 1
end

chang_compose_file = ARGV[0]
chang_compose = YAML.load(File.read chang_compose_file)
chang_compose["version"] ||= '2'

CHANG_SYNC_ENABLED = env("CHANG_SYNC_ENABLED") == "true"
CHANG_NETWORK = env("CHANG_NETWORK")
CHANG_TMP_PATH = env("CHANG_TMP_PATH")
CHANG_ENVIRONMENT = chang_compose.delete("environment") || []

VOLUMES = Set.new
SERVICES = Hash.new

system("mkdir -p #{CHANG_TMP_PATH}")

File.open(File.join(CHANG_TMP_PATH, "environment"), "w") do |env_file|
  CHANG_ENVIRONMENT.each do |line|
    env_file.puts("export #{line}")
  end
end

def expand_env_variables(str)
  `source #{CHANG_TMP_PATH}/environment && echo #{str}`.chomp
end

chang_compose.fetch("services").each do |name, service|
  service.fetch("volumes", []).map do |volume|
    case volume
    when /^chang:(.*)/
      if CHANG_SYNC_ENABLED
        VOLUMES.add("chang")
        "#{volume}:nocopy"
      else
        "../../:#{$1}"
      end
    when Hash
      chang_error "Hash syntax in services volumes is not supported: #{volume.inspect}"
    when /([^:]+):([^:]+)/
      VOLUMES.add(expand_env_variables $1)
      expand_env_variables volume
    else
      chang_error "Unrecognized service volume syntax: #{volume.inspect}"
    end
  end
  service["networks"] ||= {}
  service["networks"].merge! "chang" => { "aliases" => [chang_service_network_alias(name)] }
  service["environment"] ||= []
  service["environment"] += CHANG_ENVIRONMENT
end

chang_compose["volumes"] ||= {}
chang_compose["volumes"]
VOLUMES.-(chang_compose["volumes"].keys).each do |volume|
  chang_compose["volumes"][volume] = {
    "external" => {
      "name" => chang_external_volume_name(volume)
    }
  }
end

chang_compose["networks"] ||= {}
chang_compose["networks"]["chang"] = {
  "external" => {
    "name" => CHANG_NETWORK
  }
}

File.open(File.join(CHANG_TMP_PATH, "volumes"), "w") do |volumes_file|
  VOLUMES.each do |volume|
    volumes_file.puts(chang_external_volume_name(volume))
  end
end

File.open(File.join(CHANG_TMP_PATH, "proxy"), "w") do |proxy_file|
  if root = chang_compose.fetch("server", {})["root"]
    service, port = root.split(":")
    proxy_file.puts("$CHANG_NETWORK $CHANG_APP_NAME $CHANG_REV_PROXY_PORT #{service} #{port}")
  end
  if subdomains = chang_compose.fetch("server", {})["subdomains"]
    subdomains.each do |name, target|
      service, port = target.split(":")
      proxy_file.puts("$CHANG_NETWORK #{name}.$CHANG_APP_NAME $CHANG_REV_PROXY_PORT #{service} #{port}")
    end
  end
end

chang_compose.delete("environment")
chang_compose.delete("server")
chang_compose.delete("watch")

File.open(File.join(CHANG_TMP_PATH, "docker-compose.yml"), "w") do |docker_compose_file|
  docker_compose_file.write(chang_compose.to_yaml)
end