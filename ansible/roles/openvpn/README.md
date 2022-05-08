openvpn
=======

These role are ment to run in conjunction with eachother and firewall except for openvpn_mwr. Brief reason why this is not all in role is implement a certificate and config generation seperation from the running vpn server. The firewall role was seperated so you can implement across multi hosts with each having their own specific unique rules, this could not be achieve in a all in one role. If you are looking for an all in one solution look to openvpn_mwr.

- openvpn_cert = Generates certificates and config files for a server and its clients. Yon can one generate one server at a time. The role is ment to be used on a throw away virtual machine to create the certs and configs and scp them to a folder on admin machine or scp to the vpn you attend to use. Recommend install ansible on a throw away VM, install the role then run on that machine. This ensure absolute integrety of the root CAs.

- openvpn_install = Installs openvpn and sends generated server or client config and supporting files. After install then enables and starts openvpn service. This role can uninstall and wipe the openvpn directory as well.

- openvpn_revoke = Revokes client crt from vpn server.

- openvpn_mwr = One size fits not all, all in one role created by kyl191/ansible-role-openvpn. It is unmodified and works very well. Creates a NATed vpn server with options to connect to a LDAP and few other features. The above roles derived from this role.

Tested OSes:
- ubuntu 18.4
- CentOS 7


Requirements
------------

ansible
openssl

Role Variables
--------------

openvpn_gen_machine: cert ## ansible_host name for vm that is generating the certs and configs
openvpn_fetch_config_dir: /tmp/vpn-test/ ## local directory in which certs, configs, and supporting files are stored.

openvpn_cert/vars/'vpn_server'.yml = in the openvpn_cert/vars directory create a vpn_vars.yml (name vpn_vars.yml whatever you want) place the openvpn_cert vars into this file. 
In the:

      - name: Generate certs and configs
        import_role: 
          name: openvpn/openvpn_cert
          vars_from: vars/example.yml
        delegate_to: "{{ openvpn_gen_machine }}"

line in the vars_from: give the filename of your var.yml file.

Dependencies
------------

Role is ment to work in conjunction with firewall role

Example Playbook
----------------

## Playbook example shows how to run across multiple vpn servers as well as connect a client

    - hosts: vpnserver-test
      gather_facts: yes
      become: yes
      # connection: local ## uncomment if a local connection
      tasks:


      - name: Generate certs and configs
        import_role: 
          name: openvpn/openvpn_cert
          vars_from: vars/example.yml
        delegate_to: "{{ openvpn_gen_machine }}"


      - name: Install and start vpn server
        import_role: 
          name: openvpn/openvpn_install
        delegate_to: example.com


      - name: Setup firewall rules on vpn server
        import_role:
          name: firewall
        vars:
          firewall_type: iptables
          firewall_openvpn_NAT_enable: true       ## unique firewall rule
        delegate_to: example.com




License
-------



Author Information
------------------


