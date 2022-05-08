Openhab
=========


A brief description of the role goes here.

Requirements
------------

None. podman and firewalld are installed when role podman_container_systemd in imported.

Role Variables
--------------

### Change the varibles in the defaults/main.yml. These varibles generally stay the same.

container_state: running
container_name: openhab
container_image: openhab/openhab:2.3.0-amd64-alpine
container_dir_config: openhab_conf
container_dir_data: openhab_userdata
container_dir_addons: openhab_addons
container_dir_owner: 9001
container_dir_group: 9001
container_run_args: >-
  --rm
  -p 8083:8080/tcp
  -p 8101:8101/tcp
  -p 5007:5007/tcp
  -v "{{podman_exported_container_volumes_basedir}}/{{container_dir_addons}}:/openhab/addons:Z"
  -v "{{podman_exported_container_volumes_basedir}}/{{container_dir_config}}:/openhab/conf:Z"
  -v "{{podman_exported_container_volumes_basedir}}/{{container_dir_data}}:/openhab/userdata:Z"
  --hostname="openhab.{{ my_domain }}"
  --memory=512M
  -e EXTRA_JAVA_OPTS="-Duser.timezone={{ my_timezone }}"
firewall_port_list:
  - 8083/tcp
  - 8101/tcp
  - 5007/tcp


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
     - openhab


