Role Name: ansible_role_init_setups
===================================

Automating initial vm and container installs and configurations. This role can be deployed in through AWX and cmdline.

Tasks conducted:
- Update
- Install common packages
- Modify hostname
- Add ipaclients
- Add PAM users
- Logging config
- sshd config
- ssh-copy-id
- Config static ip ipv4
- Reboot

Requirements
============

## *** ##
None


Role Variables
==============
Tags resembles a task the playbook is running.
Tags:
- setup-all
- update
- hostname
- firewall
- ldap
- log-setup
- sshd
- ssh-copy-id
- static-ip-setup

Specifying --tags=tagged runs only things that have some tag, while --tags=untagged runs only things that have no tag.

You could alternatively invoke ansible with --skip-tags=a,b,c and it will execute all plays and tasks that are not tagged with a, b, or c.

Presumably --skip-tags=tagged does the opposite of --tags=tagged, and --skip-tags=untagged does the opposite of --tags=untagged.

If a play or task is tagged always, then it will be executed unless ansible is invoked with skip-tags=always.



ahuffman.resolv
An Ansible role to configure /etc/resolv.conf

Role Variables
Defaults
Variable Name Required  Description Default Value Type
resolv_nameservers  yes A list of up to 3 nameserver IP addresses []  list
resolv_domain no  Local domain name ""  string
resolv_search no  List of up to 6 domains to search for host-name lookup  []  list
resolv_sortlist no  List of IP-address and netmask pairs to sort addresses returned by gethostbyname. []  list
resolv_options  no  List of options to modify certain internal resolver variables.  []  list
Example Playbooks
Role Invocation
    - name: "Role Invocation - ahuffman.resolv Example"
      hosts: "all"
      roles:
        - role: "ahuffman.resolv"
          resolv_nameservers:
            - "8.8.8.8"
            - "8.8.4.4"
          resolv_domain: "foo.org"
          resolv_search:
            - "foo.bar"
            - "foobar.com"
          resolv_options:
            - "timeout:2"
            - "rotate"
Included Role
---
- name: "Included Role - ahuffman.resolv Example"
  hosts: "all"
  tasks:
    - name: "Configure resolv.conf"
      include_role:
        name: "ahuffman.resolv"
      vars:
        resolv_nameservers:
          - "8.8.8.8"
          - "8.8.4.4"
        resolv_domain: "foo.org"
        resolv_search:
          - "foo.bar"
          - "foobar.com"
        resolv_options:
          - "timeout:2"
          - "rotate"



Variables defining proxmox server
---------------------------------
## -- Hostname -- ##
inventory_hostname: # pulls from inventory but can manually define

## -- Packages -- ##
additional_packages:
  - vim

## -- User init -- ##
user:
  - user
  - admin
password:
  - password
  - password
user_admin:
  - admin

## -- PAM init -- ##
use_pam: true

## -- sshd_config -- ##
no_pass_auth: true
disable_root: true

## -- Network setup -- ##
init_static_network: false
conn_name: eth0
ip_address: 192.168.1.100/24
gateway: 192.168.1.1
dns4:
  - 8.8.8.8

## -- FreeIPA client init -- ##
use_ldap: false
freeipa_client_domain: example.com
freeipa_client_server: ipaserver.example.com
freeipa_client_realm: EXAMPLE.COM
freeipa_client_principal: admin
freeipa_client_password: Passw0rd

Example Playbook
----------------

- hosts: all
  gather_facts: yes
  become: root
  vars:
    ## -- ssh vars -- ##
    user: user
    password: password
    user_path: home/user # Your machines users path to public ssh key
    ssh_pub_file: id_rsa.pub # ssh key filename
    no_pass_auth: true
    disable_root: true
    ## -- hosts var -- ##
    local_fqdn_name: 'example.com'
  roles:
    - init


Example cmdline
---------------
ansible-playbook -i inventory/hosts playbooks/main.yml --tags=setup-all


License
-------



Author Information
------------------

