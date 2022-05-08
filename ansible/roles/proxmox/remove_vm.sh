#! /bin/bash

# usage run command with ./remove_vm.sh <vmid1> <vmid2> <vmid3> <vmid4> <vmid5> <vmid6>


# devop_vm_proxmox.sh requires ansible, proxmox role, and proxmox server setup with the desired template configed with cloudinit drive. config varibles.

read -p "Are you sure you want delete these vms?(y/n): " answer

case $answer in
  y)
    echo "OKAY!!!! I'm deleting VMs"
	nohup ansible-playbook playbooks/proxmox/rm_vm.yml -e "vmid=$1" &>/dev/null &
	nohup ansible-playbook playbooks/proxmox/rm_vm.yml -e "vmid=$2" &>/dev/null &
	nohup ansible-playbook playbooks/proxmox/rm_vm.yml -e "vmid=$3" &>/dev/null &
	nohup ansible-playbook playbooks/proxmox/rm_vm.yml -e "vmid=$4" &>/dev/null &
	nohup ansible-playbook playbooks/proxmox/rm_vm.yml -e "vmid=$5" &>/dev/null &
	nohup ansible-playbook playbooks/proxmox/rm_vm.yml -e "vmid=$6" &>/dev/null &
    ;;
  n)
    continue
    ;;
  *)
    ;;
esac




# for i in `seq $1`; do ansible-playbook playbooks/proxmox/devops.yml; done
# nohup ansible-playbook playbooks/proxmox/devops.yml &>/dev/null &