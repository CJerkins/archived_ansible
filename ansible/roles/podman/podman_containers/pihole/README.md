role
=========


A brief description of the role goes here.

Requirements
------------

None. podman and firewalld are installed when role podman_container_systemd in imported.

Role Variables
--------------

### Change the varibles in the tasks/main.yml. These varibles generally stay the same.

    container_state: running
    container_name: pihole
    container_image: pihole/pihole:latest
    container_dir_config: pihole-etc
    container_dir_data: pihole-dnsmasq.d
    container_dir_owner: 0
    container_dir_group: 0
    container_run_args: >-
      --rm
      -p 53:53/tcp
      -p 53:53/udp
      -p 67:67/udp
      -p 80:80/tcp
      -p 443:443/tcp
      -v "{{podman_exported_container_volumes_basedir}}/{{container_dir_config}}:/etc/pihole:Z"
      -v "{{podman_exported_container_volumes_basedir}}/{{container_dir_data}}:/etc/dnsmasq.d:Z"
      --hostname="pihole.{{ domain }}"
      --memory=512M
      -e "TZ={{ timezone }}"
      --dns 127.0.0.1,192.168.117.1
    firewall_port_list:
      - 53:53/tcp
      - 53:53/udp
      - 67:67/udp
      - 80:80/tcp
      - 443:443/tcp


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
      roles:
         - pihole


