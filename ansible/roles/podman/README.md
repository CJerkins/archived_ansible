podman
======

Is a set of roles to deploy podman containers. Roles are described as follows:

[podman_container_systemd] - This role is used in conjunction with podmane_containers. This role installs podman, pulls the images, starts container or pods. A systemd service is configured as well to enable container on boot. (This feature is currently under development) SEE README.md in the role for more detail.

[podman_containers/'example_service'] - This a collection of roles which drives podman_container_systemd and provide service specific varibles to deploy the service. Things specified in role is the image, directorys that need to be created, and podman envorinmental varibles. You can create additional service roles by copy/paste podman_templates/containers folder into the podman_container folder and rename the folder to the service in which you are developing. SEE README.md in the role for more detail.

[podman_pods/'example_service'] - This a collection of roles which drives podman_container_systemd and provide service specific varibles to deploy the pod. Pods are much like kubenettes pods. These roles are configure mostly from a pod file than in the tasks. It still uses podman_container_systemd to do the baseline install and configurations with systemd. You can create additional pod roles by copy/paste podman_templates/pods folder into the podman_pods folder and rename the folder to the service in which you are developing. SEE README.md in the role for more detail.

[container_image_cleanup] - This role is a handy tool to cleanup unused images. SEE README.md in the role for more detail.

Requirements
------------

podman_container_systemd

Role Variables
--------------

Role uses variables that are required to be passed while including it. As
there is option to run one container separately or multiple containers in pod,
note that some options apply only to other method.

Place these varibles group_vars/all.yml or host_vars/example.service/vars.yml

timezone: "America/New_York"
domain: local.drokdev.pro
podman_exported_container_volumes_basedir: "/var/lib/containers/{{ container_name }}"
podman_pod_yaml_dir: "/etc/containers/pods/{{ pod_name }}"



This playbook doesn't have python module to parse parameters for podman command.
Until that you just need to pass all parameters as you would use podman from
command line. See ```man podman``` or
[podman tutorials](https://github.com/containers/libpod/tree/master/docs/tutorials)
for info.



Dependencies
------------

No dependencies.

Example Playbook
----------------

See the tests/main.yml for sample. In short, include role with vars:

```
- hosts: test
  become: yes 
  roles:
     - podman/podman_containers/service
```

