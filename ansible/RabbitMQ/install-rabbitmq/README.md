Install RabbitMQ
=========

Ansible role to install RabbitMQ using cholocatey

Requirements
------------
- OS:
  - Ubuntu 18.04 or later
  - Windows 2016 or later

- Chocolatey

Role Variables
--------------

None

Dependencies
------------

None

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: install-rabbitmq }
