homeassistant 
=========

Homeassistant is an opensource homeautomation hub. Typically installes with MQTT(IoT communication protocol), Grafana, and Node-red.
https://www.home-assistant.io/

Requirements
------------

None. podman and firewalld are installed when role podman_container_systemd in imported.

Role Variables
--------------
### Change the varibles in the defaults/main.yml. These varibles generally stay the same

container_state: running
setenforce: false
container_name: hassio
container_image: docker.io/homeassistant/home-assistant:latest
container_dir_config: config
container_dir_ssl: ssl
container_run_args: >-
  -dt
  -v "{{exported_container_volumes_basedir}}/{{ container_dir_config }}:/config:Z"
  -v "{{exported_container_volumes_basedir}}/{{ container_dir_ssl }}:/ssl:Z"
  -v /etc/localtime:/etc/localtime:z
  --net=host
container_firewall_ports:
  - 8123/tcp 


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

---
- hosts: server
  become: yes
  roles:
     - homeassistant


