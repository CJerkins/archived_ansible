Grafana
=========

https://grafana.com/. Awesome for graphing dashboards. Works best with influx DB.

Requirements
------------

None. podman and firewalld are installed when role podman_container_systemd in imported.

Role Variables
--------------

### Change the varibles in the defaults/main.yml. These varibles generally stay the same.

container_state: running
container_name: grafana
container_image: grafana/grafana
container_dir_lib: grafana-lib
container_dir_etc: grafana-etc
container_dir_owner: 472
container_dir_group: root
container_memory: 128M
container_fqdn: "grafana.{{ domain }}"
container_run_args: >-
  --rm
  -p 3000:3000/tcp
  -v "{{podman_exported_container_volumes_basedir}}/{{ container_dir_lib }}:/var/lib/grafana:Z"
  -v "{{podman_exported_container_volumes_basedir}}/{{ container_dir_etc }}:/etc/grafana:Z"
  --hostname="{{ container_fqdn }}"
  --memory="{{ container_memory }}"
container_firewall_ports:
  - 3000/tcp

### Copy past into the group_vars or host_vars ###

podman_exported_container_volumes_basedir: /var/lib/containers/{{ container_name }}
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
     - grafana


