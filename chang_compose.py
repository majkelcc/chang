#!/usr/bin/env python

import yaml
import sys
import os
import re
import itertools
import subprocess
import pipes

CHANG_TMP_PATH = os.environ["CHANG_TMP_PATH"]
CHANG_APP_ID = os.environ["CHANG_APP_ID"]
CHANG_APP_NAME = os.environ["CHANG_APP_NAME"]
CHANG_NETWORK = os.environ["CHANG_NETWORK"]
CHANG_SET = os.environ["CHANG_SET"]

if len(sys.argv) != 2:
  chang_error("USAGE...")

class VolumesMapper:
  def __init__(self):
    self.i = itertools.count()
    self.map = {}

  def __getitem__(self, volume):
    if not self.map.get(volume, False):
      self.map[volume] = str(next(self.i))
    return self.map[volume]

def chang_service_network_alias(name):
  return subprocess.check_output(["/usr/local/bin/bash", "%sc" % CHANG_SET, 'chang_service_network_alias "{0}"'.format(name)])

def chang_external_volume_name(name):
  return subprocess.check_output(["/usr/local/bin/bash", "%sc" % CHANG_SET, "chang_external_volume_name '%s'" % name])

VOLUMES_MAPPER = VolumesMapper()

def chang_error(message):
  os.system("bash -c 'chang_error {0}'".format(message))
  sys.exit(1)
  
chang_compose_file = sys.argv[1]
chang_compose = yaml.load(file(chang_compose_file, 'r'))

env_file = open("{0}/environment".format(CHANG_TMP_PATH), "w")
for line in chang_compose["environment"]:
  env_file.write("export {0}\n".format(line))

environment = chang_compose.get("environment", [])
services = {}

keys = ["command", "user", "build", "depends_on", "working_dir", "tty", "image", "environment", "extends"]
for name in chang_compose["services"]:
  desc = chang_compose["services"][name]
  service = {}
  for key in keys:
    if desc.get(key, False):
      service[key] = desc[key]
  for volume in desc.get("volumes", []):
    match = re.search("^([^:]+):(.*)$", volume)
    volume_name = match.group(1)
    volume_mount = match.group(2)
    if not service.get("volumes", False):
      service["volumes"] = []
    service["volumes"].append(VOLUMES_MAPPER[volume_name] + ":" + volume_mount)
  env = service.get("environment", [])
  service["environment"] = environment + env
  service["networks"] = { "chang": { "aliases": [chang_service_network_alias(name)] }}
  services[name] = service

watch_file = open("{0}/watch".format(CHANG_TMP_PATH), "w")
for watch in chang_compose.get("watch", []):
  watch_file.write("export {0}\n".format(line))

volumes = {}
for volume in VOLUMES_MAPPER.map:
  volumes[VOLUMES_MAPPER[volume]] = {
    "external": { "name": chang_external_volume_name(volume) }
  }

compose_yaml = {
  "version": "2",
  "services": services,
  "volumes": volumes,
  "networks": {
    "chang": { "external": { "name": CHANG_NETWORK } }
  }
}

compose_file = open("{0}/compose_file".format(CHANG_TMP_PATH), "w")
yaml.dump(compose_yaml, compose_file, default_flow_style=False)

volumes_file = open("{0}/volumes".format(CHANG_TMP_PATH), "w")
for volume in VOLUMES_MAPPER.map:
  volumes_file.write(chang_external_volume_name(volume) + "\n")

proxy_file = open("{0}/proxy".format(CHANG_TMP_PATH), "w")
if chang_compose.get("server", {}).get("root", False):
  service, port = chang_compose["server"]["root"].split(":")
  proxy_file.write("$CHANG_NETWORK $CHANG_APP_NAME $CHANG_REV_PROXY_PORT %s %s\n" % (service, port))
