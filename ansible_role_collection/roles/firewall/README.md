firewall
=========

This role template has set out to achieve a superior configuration of the operating system's firewall. Mostly leaning on using iptables to achieve the detailed configations but as well utilize UFW or Firewalld if user chooses. Use the template as a bases then follow the instruction on how to expand you particular config. 

The role is ment to be used in tandem with the init_setups and installing services type roles.

Requirements
------------
Tested on:
	Centos 7
	Ubuntu 18.4

Can work on any Redhat and Debian distro

Role Variables
--------------

## located in inventory:
ansible_port: 22 ## will change ssh port if specified in inventory ansible_port. Default is 22

## located in defaults:
firewall_firewall_ip_forward: false  	## default is false
firewall_setenforce: false 				## when true it is set to 0
firewall_service: iptables 				## choose firewalld or ufw

iptables_allow_ping: true

## Unique rules:
firewall_server-name: enable
SEE task/'iptables or firewalld or ufw'/REAMME.md to setup unique rules for specific operating systems.

Default setup
-------------
Iptables defaults
- Open ssh port
- chain INPUT, ctstate: ESTABLISHED,RELATED. jump: ACCEPT
- chain: INPUT, ctstate: INVALID, jump: DROP
- chain: INPUT. in_interface: lo, jump: ACCEPT
- chain OUTPUT, ctstate: ESTABLISHED,RELATED. jump: ACCEPT
- chain: OUTPUT, ctstate: INVALID, jump: DROP
- chain: OUTPUT. in_interface: lo, jump: ACCEPT
- chain FORWARD, ctstate: ESTABLISHED,RELATED. jump: ACCEPT
- chain: FORWARD, ctstate: INVALID, jump: DROP
- Log connection on input, output, and forward chains




Dependencies
------------

none

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

- hosts: server
  gather_facts: true
  become: true
  vars:
	firewall_firewall_ip_forward: false
	## created_varibles: 192.168.1.1 ##
  roles:
    - firewall

Important notes
---------------
create a .gitignore file and ignore unique rules to prevent git pull to be distrubed. You can place unique rules in the example_unique_rules folder to push to repo to help others create unique rule sets.
Example:
tasks/iptables
tasks/firewalld
tasks/ufw

License
-------



Author Information
------------------

fortified.tech.advisor@gmail.com
