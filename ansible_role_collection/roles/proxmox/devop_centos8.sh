#! /bin/bash

# usage run command with ./devop_vm_proxmox.sh <number of vms>
# mkrole will then create role directorys in the project directory
# and setup git for your new role

# devop_vm_proxmox.sh requires ansible, proxmox role, and proxmox server setup with the desired template configed with cloudinit drive. config varibles.

#function run

run() {
    number=$1
    shift
    for i in `seq $number`; do
      $@
    done
}

run $1 nohup ansible-playbook playbooks/proxmox/devops_centos8.yml &>/dev/null &

# for i in `seq $1`; do ansible-playbook playbooks/proxmox/devops.yml; done
# nohup ansible-playbook playbooks/proxmox/devops.yml &>/dev/null &