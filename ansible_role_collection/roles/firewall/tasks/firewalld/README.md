Unique rules use
----------------

In unique rules template, uncomment and modify as needed to map your tasks. Uniques rules are separated by policy zone. 2 reasons this is done so rules can be set in order and managablity. 

Things you can do with it:
	- configure multiple server configs in one role. Add "(firewall_server-name_enable | default(False))" in your group_vars/all.yml, host_vars/main.yml, or defaults/main.yml to enable this feature.
	- Modify the order which you want rules set in. Recommend printing out ipv4.rules file that you want to end up with then modify the tasks file to specify what you wnat.
	- Add unique firewalld tasks to the your over all play without modifying firewalld.yml mainfile

# - name: "Specific server-name" public rules 							## Modify server_name in (Specific "server-name")
#   include_tasks: tasks/firewalld/zone_folder/zone_server-name.yml 	## Modify server_name in (zone_"server-name".yml).
#   when: (firewall_server-name_enable | default(False)) 				## Modify server_name in (firewall_"server-name" | default(False)).



Unique zone rules use
----------------------

Unique zone rule template will give you a starting point to create unique rules for a specific server using ansible.

How to use:
1. cp zone_server-name.yml to the zone folder you want to configure and rename it to the zone and server-name to specify it. See Example: cp zone_server-name.yml public/public_xmpp-server.yml.
2. map the task in the unique_rules.yml.
	# - name: "Specific xmpp-server" public rules 				
	#   include_tasks: tasks/firewalld/public/public_xmpp-server.yml 	
	#   when: (firewall_xmpp-server_enable | default(False))
3. place var "firewall_xmpp-server_enable: true" in a var file of your chose.
4. modify zone_server-name.yml in the specified zone folder to your liking. SEE https://docs.ansible.com/ansible/latest/modules/firewalld_module.html to learn ansible firewalld module options. There is also examples in the file to get you started as well.

- If you what to create another unique rule set in the same zone repeat steps 1 - 4. 
