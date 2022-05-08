openvpn_cert
=========

This role generates the certificates and config files for a server and its clients. It does not install openvpn, only openssl in order to generate the certificates. It also does not setup firewall rules or ipv4 forwarding. Use openvpn_install, and firewall to setup the rest of your server. The role is ment to be used on a throw away virtual machine to create the certs and configs and scp them to a folder on admin machine or scp to the vpn you attend to use. Recommend install ansible on a throw away VM, install the role then run on that machine. This ensure absolute integrety of the root CAs.

Tested OSes:
- ubuntu 18.4
- CentOS 7


Requirements
------------

ansible - if you chose to run on a local VM
openssl - openssl will install when role is played

Role Variables
--------------
## You can find all vars in defaults/main.yml file. If var is copy/paste to your playbook or group_vars/all.yml to override defaults. See the notes to the side for helpful information about the var.



# defaults file for openvpn
openvpn_base_dir: /etc/openvpn ## used in ldap config generater
## vars used in tasks
openvpn_key_dir: "/tmp/openvpn/{{openvpn_server_name}}"
openvpn_crl_path: "{{openvpn_key_dir}}"
openvpn_server_name: openvpn
openvpn_server_config_file: "{{openvpn_server_name}}-server"
openvpn_client_config_file: "{{openvpn_server_name}}"



## vars used in cert create
openvpn_rsa_bits: 2048
## vars used in server config
openvpn_topology: subnet       		## p2p or subnet. used in client and server
openvpn_ifname_server: tun  		## vpn interface name
openvpn_dualstack: false    		## if true ipv4 and ipv6 will be enabled
openvpn_proto: udp          		## udp or tcp. used in client and server 
openvpn_port: 1194          		## vpn port. used in client and server 
openvpn_server_network:     		## format 192.168.1.0 ONLY define for subnet configurations.
openvpn_server_netmask:     		## format 255.255.255.0 ONLY define for subnet configurations.
openvpn_server_address:     		## format 192.168.1.1. ONLY define for p2p configurations. used in client and server 
openvpn_client_address:     		## format 192.168.1.2. ONLY define for p2p configurations. used in client and server
client_config: true         		## if true it creates client_config file in openvpn_key_dir/ccd and openvpn option 'client-config-dir ccd' server config file
openvpn_client_config_options: []  	## list client_config_options in playbook group_vars/all.yml
openvpn_status_version: 2   		## Default is 1. Options: 1, 2, or 3. SEE https://openvpn.net/community-resources/reference-manual-for-openvpn-2-4/ for mor inforamation
openvpn_ncp_disable: true   		## if true it disables ncp negotiation.
openvpn_cipher: AES-128-GCM      	## chose a cipher. used in client and server
openvpn_use_modern_tls: true      	## inputs tls-cipher option in server config. used in client and server
openvpn_tls_cipher: TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384  ## chose a tls-cipher. used in client and server
openvpn_use_hardened_tls: true    	## inputs tls-version option in server config. used in client and server
openvpn_tls_version: 1.2          	## chose a tls-version. used in client and server
openvpn_diffi_hellman: false      	## if false it inputs dh none option in server config
openvpn_auth_alg: SHA256    		## Default is SHA256. Chose a alg. used in client and server
openvpn_verify_cn: true     		## if true inputs verify-x509-name and remote-cert-tls in server config. used in client and server
tls_auth_required: false    		## if true inputs tls-auth ta.key option in server config. used in client and server
tls_crypt_required: true    		## if true inputs tls-crypt ta.key option in server config. used in client and server
openvpn_jails: false        		## if true enable jails. used in client and server
openvpn_addl_server_options: []  	## list additional options in playbook or group_vars/all.yml
openvpn_push: []            		## list push options in playbook or group_vars/all.yml
openvpn_redirect_gateway: false 	## if true inputs, push "redirect-gateway def1", in server config
openvpn_set_dns: false      		## enables dns push settings
openvpn_custom_dns: false   		## enables custom dns push settings
openvpn_dns_servers: []     		## list custom dns nameservers
openvpn_duplicate_cn: false 		## if true enables connection to duplicate common name certs
openvpn_client_to_client: false  	## if true enables client to client communication
openvpn_tun_mtu:            		## if defined input tun-mtu setting in server config
openvpn_use_crl: false      		## if true generates a crl cert and inputs crl-verify option server config

# Logrotate configuration
openvpn_log_dir: /var/log/openvpn
openvpn_server_log_file: "{{openvpn_server_config_file}}.log"
openvpn_logrotate_config: |
  rotate 4
  weekly
  missingok
  notifempty
  sharedscripts
  copytruncate
  delaycompress



## currently untested ##
# LDAP configuration
openvpn_use_ldap: false
ldap:
  url: ldap://host.example.com
  anonymous_bind: False
  bind_dn: uid=Manager,ou=People,dc=example,dc=com
  bind_password: mysecretpassword
  tls_enable: no
  tls_ca_cert_file: "{{ openvpn_base_dir }}/auth/ca.pem"
  base_dn: ou=People,dc=example,dc=com
  search_filter: (&(uid=%u)(accountStatus=active))
  require_group: False
  group_base_dn: ou=Groups,dc=example,dc=com
  group_search_filter: (|(cn=developers)(cn=artists))



## vars used in client and server
openvpn_verbose: 3          		## Default is 3. Options: 1 - 11. SEE https://openvpn.net/community-resources/reference-manual-for-openvpn-2-4/ for mor inforamation
openvpn_keepalive_ping: 10
openvpn_keepalive_timeout: 60
openvpn_service_user: nobody
openvpn_service_group: nogroup



## vars used in client config
clients: [] ## list client names in playbook or group_vars/all.yml.
openvpn_ifname_client: tun          ## vpn interface name
server_public_ipaddress:   			## vpn server publiaddress. 
openvpn_client_log_file: "{{openvpn_client_config_file}}.log"  ## if defined inputs in client config file. defines client log file. Some client software will error if defined in config.
openvpn_addl_client_options: []     ## list additional options in playbook or group_vars/all.yml 
openvpn_client_register_dns: false  ## if true inputs register-dns in client config
# openvpn_resolv_retry: 5           ## not what this does



### These vars below need to be defined. ###
openvpn_server_name: openvpn
openvpn_server_network:     		## format 192.168.1.0 ONLY define for subnet configurations.
openvpn_server_netmask:     		## format 255.255.255.0 ONLY define for subnet configurations.
openvpn_server_address:     		## format 192.168.1.1. ONLY define for p2p configurations. used in client and server 
openvpn_client_address:     		## format 192.168.1.2. ONLY define for p2p configurations. used in client and server
clients: [] ## list client names in playbook or group_vars/all.yml.
server_public_ipaddress:   			## vpn server publiaddress.


Dependencies
------------

Role is ment to work in conjunction with firewall, openvpn_install, and openvpn_revoke

Example Playbook
----------------

    - hosts: localhost
      gather_facts: yes
      vars:
		openvpn_server_name: openvpn
		openvpn_server_network: 10.8.0.0     		## format 192.168.1.0 ONLY define for subnet configurations.
		openvpn_server_netmask: 255.255.255.0    	## format 255.255.255.0 ONLY define for subnet configurations.
		server_public_ipaddress: 35.124.64.9   		## vpn server publiaddress.
		clients:
		  - client0
		  - cliemt1
      roles:
        - openvpn_cert



License
-------



Author Information
------------------


