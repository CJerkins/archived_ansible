# Prosody ansible role

**Moved to https://gitlab.com/lxmx-tech/prosody-ansible**

This role:

1. Facilitates the [Prosody](https://www.prosody.im) XMPP server installation
2. Enables all of the useful XMPP extensions supported by the [Conversations](https://conversations.im) XMPP client:

    * [XEP-0280](https://xmpp.org/extensions/xep-0280.html) - [Message Carbons](https://code.google.com/p/prosody-modules/wiki/mod_carbons) (`mod_carbons.lua`)
    * [XEP-0198](https://xmpp.org/extensions/xep-0198.html) - [Stream Management](https://code.google.com/p/prosody-modules/wiki/mod_smacks) (`mod_smacks.lua`)
    * [XEP-0191](https://xmpp.org/extensions/xep-0191.html) - [Blocking Command](https://code.google.com/p/prosody-modules/wiki/mod_blocking) (`mod_blocking.lua`)
    * [XEP-0352](https://xmpp.org/extensions/xep-0352.html) - [Client State Indication](https://code.google.com/p/prosody-modules/wiki/mod_csi) (`mod_csi.lua`)
    * [XEP-0313](https://xmpp.org/extensions/xep-0313.html) - [Message Archive Management](https://code.google.com/p/prosody-modules/wiki/mod_mam) (`mod_mam.lua`)

## Requirements

  * CentOS 7 machine
  * SSL certificate for your domain name, put into `files/ssl/example.com.key`, `files/ssl/example.com.pem` (includes the CA chain).

## Role Variables

The following variables should be set:

  * `prosody_domain` - the hostname of your server (e.g. `example.com`)
  * `prosody_db_password` - PostgreSQL database password (can be anything, the DB is created automatically)
  * `prosody_enable_mam` - whether or not to enable the MAM module (default is `True`).

## Installation

1. Create and run a playbook:

    ```yaml
      - hosts: servers
        roles:
          - prosody
        vars:
          prosody_domain: 'example.com'
          prosody_db_password: 'changeme'
          prosody_enable_mam: False
    ```

    ```
    ansible-playbook -i hosts prosody.yml
    ```

2. Create your admin user on the server:

    ```
    prosodyctl adduser admin@example.com
    ```

3. Configure the DNS settings (replace `example.com` and `192.168.1.99`):

    ```
    chat.example.com. 1800 IN A 192.168.1.99
    _xmpp-client._tcp.example.com. 1800 IN SRV 5 0 5222 chat.example.com.
    _xmpp-server._tcp.example.com. 1800 IN SRV 5 0 5269 chat.example.com.
    ftproxy.example.com. 1800 IN CNAME chat.example.com.
    conference.example.com. 1800 IN CNAME chat.example.com.
    _xmpp-server._tcp.conference.example.com. 1800 IN SRV 5 0 5269 chat.example.com.
    ```

## More info

* [DNS configuration in Jabber/XMPP](http://prosody.im/doc/dns)

## License

GNU GPLv3
