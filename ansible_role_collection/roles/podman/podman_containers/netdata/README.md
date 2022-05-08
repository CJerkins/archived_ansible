Netdata
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
container_name: netdata
container_image: docker.io/netdata/netdata:latest
container_dir_proc: proc
container_dir_sys: sys
container_dir_sock: var/run/docker.sock
container_run_args: >-
  -d
  -v "{{podman_exported_container_volumes_basedir}}/{{ container_dir_proc }}:/host/proc:Z"
  -v "{{podman_exported_container_volumes_basedir}}/{{ container_dir_sys }}:/host/sys:Z"
  -v "{{podman_exported_container_volumes_basedir}}/{{ container_dir_sock }}:/var/run/docker.sock:Z"
  --cap-add SYS_PTRACE
  --security-opt apparmor=unconfined
  - p 19999:19999
container_firewall_ports:
  - 19999/tcp 
 


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
     - netdata


