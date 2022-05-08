Role Name: ansible_role_proxmox
===============================

Automationing cloning, provisioning or removing VM's and LXC containers through ansible. This role can be deployed in through AWX and cmdline.

- Cloning vm's as well as utilizing cloud-init to config vm at boot. This will require template vm to be installed with cloud init and cloud-init disk created.

- Provisioning VM's configures VM.conf in /etc/pve/qemu but does not boot and conduct the initial install. You will still be required to login proxmox to chose the iso file to boot from. When the VM is first booted it will require user input to install the Operating System.

- Removing VM's will be able to shutdown the VM and remove from proxmox.

- Creating LXC containers will create the container as you would in the proxmox GUI as well as start the container at the end.

- Removing LXC containers will shutdown the container then remove. 


Requirements
============

## Pre-requirements on proxmox machine ##
- Install Python-minimal, Python-pip
- Install Proxmoxer
- pip install requests
- pip install paramiko

Troubleshooting the API
=======================
curl -I -k https://node-b:8006

Output: 
-------
HTTP/1.1 501 method 'HEAD' not available
Cache-Control: max-age=0
Connection: close
Date: Sat, 12 Oct 2019 12:06:35 GMT
Pragma: no-cache
Server: pve-api-daemon/3.0
Expires: Sat, 12 Oct 2019 12:06:35 GMT

Role Variables
==============

Tags
----
Tags resembles a task the playbook is running.
Tags:
 - vm
 - container

 
Variables defining proxmox server
---------------------------------
vars below needs to placed at the highest vars hierarchy. Example: group_vars >> main.yml. 

node        : pve
api_user    : inputuser@pam
api_password: ChangMe
api_host    : pve


Clone VM playbook
--------------
## Clone vars ##
action: start
build_type: clone
# vmid: 101      		# source VM name. You must chose the vmid or vmsource variables not both. 
vmnewid: 251     		# target VM name. Can comment out
vmname: testVM   		# Can comment out. If in use this must be unique to other vm name
vmsource: template.CloudInit.Centos7 # source VM name
# vmcores: 4 	 		# defaults
# vmsockets: 1   		# defaults
# vmmemory: 4096 		# defaults
vmbridge: vmbr0

## Cloud init vars ##
ciuser: user
cipassword: 'ChangeMe'
# vmdisk: 20G    		# default is template disk size
vmsearchdomain: example.com
vmnameserver: '8.8.8.8'
# sshkey: ssh-rsa key-string
# sshkey: /root/.ssh/id_rsa.pub
vmip: 192.168.1.2/24
vmgw: 192.168.1.1
# vmmacaddr: 02:00:00:02:80:de


Provision VM playbook
------------------
## -- VM vars -- ##
action: start
build_type: provision
vmnewid: 357 			# The target VM ID or the VM ID in provisioning
vmname: example.com 	# The target VM Name

## -- You will need to go on the WebUI to select the iso file -- ##

## -- Additional vars -- ##
vmcores     : 4
vmsockets   : 1
vmvcpus     : 1
vmmemory    : 4096
vmdisk      : 16
vmbridge    : vmbr0
vmstorage   : local-lvm
vmonboot    : no
vmformat    : qcow2


Remove VM playbook
------------------
## -- VM vars -- ##
action  : remove
vmid	: 500 				 # The target VM name. Must chose one or the other.
# vmname  : example.com    # The target VM name


Create LXC playbook
-------------------
## -- Container vars -- ##
action		: start
ctid        : 247 # Varible has to be set in playbook
ctpassword  : lukmanlab # Varible has to be set in playbook
ctip        : 172.16.1.183/24
ctgw        : 172.16.1.1
ctbridge    : vmbr0
OS_Template : centos-7-default_20171212_amd64.tar.xz
# ubuntu-18.04-standard_18.04-1_amd64.tar.gz 
# ubuntu-16.04-standard_16.04-1_amd64.tar.gz 
# centos-7-default_20171212_amd64.tar.xz

## -- Additional vars -- ##
cthostname  : server.example.com
searchdomain: example.com
ctnameserver: 8.8.8.8
ctcores     : 2
ctmemory    : 1024
ctswap      : 512
ctdisk      : 8
ctstorage   : local-lvm
ctnetif     : 
  net0: "name=eth0,ip=dhcp,bridge=vmbr0"
  # net0: "name=eth0,ip=8.8.8.8,gw=9.9.9.9,bridge=vmbr0"
ctmounts    : 
  mp0: "/mnt/pve/cephfs_data/downloads/,mp=/downloads"
  mp1: "/mnt/pve/cephfs_data/media,mp=/media"
ctunprivileged: yes
ctpubkey    : "ssh-rsa myPublicKey engonzal@hostname"
ctonboot    : no


Remove LXC playbook
-------------------
## -- Container vars -- ##
action   : remove
ctid     : 247 # Varible has to be set in playbook	


Example Playbook
----------------

Playbook for VMs:
- hosts: proxmox
  gather_facts: yes
  vars:
	action: start
  role:
  	- proxmox



Example cmdline
---------------

ansible-playbook -i inventory/hosts playbooks/proxmox.yml --tags=vm


License
-------



Author Information
------------------

