openvpn_cert
=========

This role installs openvpn and sends generated server or client config and supporting files. After install then enables and starts openvpn service. This role can uninstall and wipe the openvpn directory as well.

Tested OSes:
- ubuntu 18.4
- CentOS 7


Requirements
------------

openvpn_cert role to generate all nessassary files.

Role Variables
--------------
## All these vars are the same as the openvpn_cert vars. You must define if it is a server of client install.



# defaults file for openvpn
openvpn_uninstall: false
openvpn_base_dir: /etc/openvpn ## used in ldap config generater
openvpn_fetch_config_dir: /User/drok/Desktop/vpn_certs
openvpn_server_name: openvpn
## vars used in tasks
openvpn_key_dir: "/tmp/openvpn/{{openvpn_server_name}}"
openvpn_server_config_file: "{{openvpn_server_name}}-server"
openvpn_client_config_file: "{{openvpn_server_name}}"
openvpn_log_dir: /var/log/openvpn
openvpn_jails: false
openvpn_use_ldap: false
openvpn_install: server ## Options server or client.
clients: []


Dependencies
------------

Role is ment to work in conjunction with firewall, openvpn_install, and openvpn_revoke

Example Playbook
----------------

    - hosts: vpn_server
      gather_facts: yes
      become: yes
      vars:
        openvpn_install: server ## Options server or client.
        openvpn_uninstall: false
      roles:
        - openvpn_install



License
-------



Author Information
------------------


