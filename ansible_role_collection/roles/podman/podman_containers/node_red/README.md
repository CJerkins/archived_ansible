Node_red
=========


A brief description of the role goes here.

Requirements
------------

None. podman and firewalld are installed when role podman_container_systemd in imported.

Role Variables
--------------

### Change the varibles in the defaults/main.yml. These varibles generally stay the same.

container_state: running
container_name: nodered
container_image: nodered/node-red-docker
container_dir_config: node-red
container_dir_owner: 1001
container_dir_group: root
container_run_args: >-
  --rm
  -p 1880:1880/tcp
  -v "{{podman_exported_container_volumes_basedir}}/{{ container_dir_config }}:/data:Z"
  --hostname="nodered.{{ domain }}"
  --memory=512M
  -e FLOWS="flows_nodered.{{ domain }}.json"
container_firewall_ports:
  - 1880/tcp

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
     - node_red


