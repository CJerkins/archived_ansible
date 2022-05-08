mosquitto
=========


A brief description of the role goes here.

Requirements
------------

None. podman and firewalld are installed when role podman_container_systemd in imported.

Role Variables
--------------

### Change the varibles in the tasks/main.yml. These varibles generally stay the same.

container_state: running
setenforce: false
container_name: mosquitto
container_image: docker.io/eclipse-mosquitto:latest
container_dir_config: config/mosquitto.conf
container_dir_data: data
container_dir_log: log
container_run_args: >-
  -v "{{podman_exported_container_volumes_basedir}}/{{ container_dir_config }}:/mosquitto/config/mosquitto.conf:Z"
  -v "{{podman_exported_container_volumes_basedir}}/{{ container_dir_data }}:/mosquitto/data:Z"
  -v "{{podman_exported_container_volumes_basedir}}/{{ container_dir_log }}:/mosquitto/log:Z"
  -p 1883:1883
  -p 9001:9001
  --memory=1g
  --net=host
container_firewall_ports:
  - 8123/tcp 


### Copy past into the group_vars or host_vars ###

podman_exported_container_volumes_basedir: /var/lib/containers/exported_volumes
domain: localdomain
timezone: "Europe/Helsinki"

Dependencies
------------

Depends on ansible role [podman_container_systemd](https://galaxy.ansible.com/ikke_t/podman_container_systemd) which uses systemd to make sure containers state.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

- hosts: server
  become: yes
  roles:
     - mosquitto


