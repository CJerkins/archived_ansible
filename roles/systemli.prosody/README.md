ansible-role-prosody
=========
[![Build Status](https://travis-ci.org/systemli/ansible-role-prosody.svg?branch=master)](https://travis-ci.org/systemli/ansible-role-prosody)
[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-prosody-blue.svg)](https://galaxy.ansible.com/systemli/prosody/)
[![IM observatory](https://check.messaging.one/badge.php?domain=jabber.systemli.org)](https://check.messaging.one/result.php?domain=jabber.systemli.org&amp;type=client)
<a href='https://compliance.conversations.im/server/jabber.systemli.org'><img src='https://compliance.conversations.im/badge/jabber.systemli.org'></a> 


Install and maintain [Prosody](http://prosody.im/) from offical repo with Ansible.
Per default, this role also installs monit and munin-node to monitor Prosody.
Tested with Molecule, Docker, Vagrant and TravisCI.

Requirements
------------

Debian 8,9,10. Other versions of Debian/Ubuntu might be supported as well, but aren't tested.

To use `lua-event`, the testing repo needs to be enable on Debian 9.

Role Variables
--------------

```
prosody_vhost: localhost
prosody_virtual_hosts:
  - name: "{{ prosody_vhost }}"
prosody_admins: ['admin']
prosody_proxy: "proxy.{{ prosody_vhost }}"
prosody_contacts:
  - { name: abuse, address: "xmpp:admin@{{ prosody_vhost }}" }
  - { name: admin, address: "xmpp:admin@{{ prosody_vhost }}" }
# supported levels are: "debug", "info", "warn", "error". 
prosody_log_level: info
# use "cyrus" to activate ldap auth
prosody_authentication: internal_hashed
prosody_dhparam_length: 2048
prosody_welcome_msg: "Hello $username, welcome to the $host IM server!"

# Set either a string, or a list of strings. If a list is given, the external
# module "motd_sequential" will be activated and used automatically.
# motd_sequential is a variant of mod_motd, that lets you specify a sequence
# of MOTD messages instead of a single static one. Each message is only sent
# once and the module keeps track of who as seen which message.
prosody_motd: []

# https://prosody.im/doc/setting_up_bosh#cross-domain_issues
prosody_cors: False

prosody_custom_registration_theme: False
prosody_custom_registration_theme_repo: "https://github.com/beli3ver/Prosody-Web-Registration-Theme.git"
prosody_custom_registration_theme_path: "/etc/prosody/register-templates/Prosody-Web-Registration-Theme"

prosody_mod_register_redirect_registration_whitelist: ""
prosody_mod_register_redirect_registration_url: "https://localhost:5281/register_web"
prosody_mod_register_redirect_text: "To register please visit {{ prosody_mod_register_redirect_registration_url}}"

prosody_modules:
  - admin_adhoc  # Allows administration via an XMPP client that supports ad-hoc commands
  - admin_telnet  # Opens telnet console interface on localhost port 5582
  - announce  # Send announcement to all online users
  - blocklist  # Allow users to block communications with other users
  - bosh  # Enable BOSH clients, aka "Jabber over HTTP"
  - carbons  # Keep multiple clients in sync
  - csi_simple  # traffic optimizations
  - mam  # Store messages in an archive and allow users to access it
  - pep  # Enables users to publish their avatar, mood, activity, playing music and more
  - pep_vcard_avatar  # XEP-0398: User Avatar to vCard-Based Avatars Conversion
  - private  # Private XML storage (for room bookmarks, etc.)
  - server_contact_info  # Publish contact information for this service
  - vcard4  # new vards standard
  - vcard_legacy  # Allow users to set vCards
  - welcome  # Welcome users who register accounts
  - websocket  # XMPP over WebSockets

prosody_external_modules:
  - auto_activate_hosts
  - c2s_conn_throttle
  - c2s_limit_sessions
  - cloud_notify
  - csi
  - filter_chatstates
  - http_upload
  - lastlog
  - limit_auth
  - list_inactive
  - log_sasl_mech
  - omemo_all_access
  - reload_modules
  - register_redirect
  - register_web
  - s2s_auth_compat
  - s2s_blacklist
  - smacks

prosody_external_modules_dir: /usr/share/prosody-modules

prosody_muc_modules:
  - muc_mam  # Store MUC messages in an archive and allow users to access it
  - vcard_muc  # adds the ability to set vCard for MUC rooms

prosody_s2s_blacklist:
  - buycc.me
  - validcc-notifier.su

prosody_blacklist: []

prosody_file_limit: false

prosody_limits: True
prosody_limits_c2s_rate: "3kb/s"
prosody_limits_c2s_burst: "2s"

# storage policies
prosody_mam_archive_expires_after: "1w"
prosody_mam_default_archive_policy: "false"
prosody_muc_log_by_default: true
prosody_max_history_messages: 100

# http upload settings
prosody_http_upload_file_size_limit: 1048576  # 1MB
prosody_http_upload_expire_after: 2592000  # 30 days in seconds
prosody_http_upload_quota: 52428800  # 50MB

prosody_clean_inactive_users: false

prosody_packages:
  - prosody
  - mercurial
  - lua-sec
  - lua-bitop
  - lua-event

prosody_repo_packages:
  - apt
  - ca-certificates

# ldap
prosody_ldap_packages:
  - sasl2-bin
  - libsasl2-modules-ldap
  - lua-cyrussasl
prosody_ldap_filter: (sAMAccountName=%u)

# monitoring
prosody_monitoring: true
prosody_monitoring_packages:
  - munin-node
  - monit
  - git
```

Download
--------

Download latest release with `ansible-galaxy`

	ansible-galaxy install systemli.prosody

Example Playbook
----------------

```
- hosts: servers
  roles:
    - systemli.prosody
  vars:
    prosody_virtual_hosts:
      - name: example.net
        key: |
          -----BEGIN PRIVATE KEY-----
            ...
          -----END PRIVATE KEY-----
        cert: |
            -----BEGIN CERTIFICATE-----
              ...
            -----END CERTIFICATE-----
      - name: x5tno6mwkncu4m2h.onion
        admins: ["admin@x5tno6mwkncu4m2h.onion"]
```

You would need a configured Tor onion service for this.
Look at [systemli.onion](https://github.com/systemli/ansible-role-onion).

You can also combine it with [systemli.letsencrypt](https://github.com/systemli/ansible-role-letsencrypt/) to automatically configure certs.

```
- hosts: servers
  roles:
    - systemli.letsencrypt
    - systemli.prosody
  vars:
    prosody_vhost: example.net
    letsencrypt_cert:
      name: example.net
      domains:
        - example.net
        - conference.example.net
        - proxy.example.net
        - pubsub.example.net
      challenge: dns
      renew_hook: "/usr/bin/prosodyctl --root cert import /etc/letsencrypt/live/"
```

Tests
-----

Run local tests with
```
molecule test -s vagrant
```
Requires Molecule, Vagrant and `python-vagrant` to be installed.

License
-------

GPL

Author Information
------------------

https://www.systemli.org
