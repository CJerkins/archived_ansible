Ansible testing tips and best practices
---------------------------------------
REF: https://www.youtube.com/watch?v=FaXVZ60o8L8

## Ansible Testing Spectrum
1. yamllint
	To install yamllint: 
	`pip3 install yamllint`
	Run in the directory of the playbook `yamllint .`
	Create a yamllint file to set rules for your playbooks

2. ansible-playbook --syntax-check
	`ansible-playbook playbook.yml --syntax-check`
	Only check the syntax is correct

3. ansible-lint
	Ensure best practices are used and helps prevents pitfalls
	`pip3 install ansible-lint`
	`ansible-lint playbook.yml`

4. molecule test (integration)
	`pip3 install ansible-molecule`
	`molecule init role myrole`
	`molecule test`
	`molecule converge` runs molecule playbook tile the converge play then stops
	`molecule login` ssh into docker container your testing
	
	Use ansible module fail: to but break point to stop playbook.

5. ansible-playbook --check (against prod)


6. Parallel infrastructure